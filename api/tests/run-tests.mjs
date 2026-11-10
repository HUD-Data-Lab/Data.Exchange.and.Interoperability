#!/usr/bin/env node
// Contract-test the HMIS Data Exchange API with Newman.
//
// 1. Lint the OpenAPI description and the Arazzo workflows, and check that the API's JSON-LD
//    mappings agree with the ontology (check-ontology.mjs).
// 2. Build a Postman collection from the OpenAPI description with Portman, adding a
//    contract test per operation (status, content type, JSON body, response schema).
// 3. Run that collection with Newman.
//
// By default the collection runs against a Prism mock server generated from the same
// OpenAPI file, which checks that the description and its examples agree. Set
// HMIS_API_BASE_URL to run the same tests against a real HMIS implementation instead.
//
// Plain Node with no shell, so it runs the same way on Linux, macOS and Windows.
// `node run-tests.mjs --lint-only` runs step 1 alone.
import { spawn, spawnSync } from "node:child_process";
import { createWriteStream, mkdirSync, readdirSync, readFileSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";
import { createRequire } from "node:module";

const here = dirname(fileURLToPath(import.meta.url));
process.chdir(here);
const require = createRequire(import.meta.url);

const spec = join("..", "hmis-api.openapi.yaml");
const workflows = readdirSync(join("..", "workflows"))
  .filter((f) => f.endsWith(".arazzo.yaml"))
  .sort()
  .map((f) => join("..", "workflows", f));
const mockPort = 4010;
const mockUrl = `http://localhost:${mockPort}`;
const baseUrl = process.env.HMIS_API_BASE_URL || mockUrl;

// Absolute path of an npm package's CLI script, run with this Node binary rather than
// through the platform's .bin shims (.cmd files on Windows need a shell).
function bin(pkg, name) {
  const pkgJson = require.resolve(`${pkg}/package.json`);
  const { bin: bins } = JSON.parse(readFileSync(pkgJson, "utf8"));
  const rel = typeof bins === "string" ? bins : bins[name];
  return join(dirname(pkgJson), rel);
}

function run(pkg, name, args) {
  const { status, error } = spawnSync(process.execPath, [bin(pkg, name), ...args], {
    stdio: "inherit",
  });
  if (error) throw error;
  if (status !== 0) process.exit(status ?? 1);
}

const lint = () =>
  run("@redocly/cli", "redocly", ["lint", "--config", join("..", "redocly.yaml"), spec, ...workflows]);

// Fails if the API's JSON-LD mappings and the ontology have drifted apart (see check-ontology.mjs).
function checkOntology() {
  const { status, error } = spawnSync(process.execPath, [join(here, "check-ontology.mjs")], { stdio: "inherit" });
  if (error) throw error;
  if (status !== 0) process.exit(status ?? 1);
}

mkdirSync("build", { recursive: true });

if (process.argv.includes("--lint-only")) {
  lint();
  checkOntology();
  process.exit(0);
}

lint();
checkOntology();
run("@apideck/portman", "portman", [
  "--local", spec,
  "--portmanConfigFile", "portman-config.json",
  "--baseUrl", mockUrl,
  "--output", join("build", "hmis-api.postman_collection.json"),
  "--runNewman", "false",
]);

let mock = null;
const stopMock = () => {
  if (!mock || mock.exitCode !== null) return;
  if (process.platform === "win32") {
    spawnSync("taskkill", ["/pid", String(mock.pid), "/T", "/F"], { stdio: "ignore" });
  } else {
    mock.kill();
  }
};
process.on("exit", stopMock);
for (const sig of ["SIGINT", "SIGTERM"]) {
  process.on(sig, () => process.exit(130));
}

if (!process.env.HMIS_API_BASE_URL) {
  const log = createWriteStream(join("build", "prism.log"));
  mock = spawn(
    process.execPath,
    [bin("@stoplight/prism-cli", "prism"), "mock", spec, "--port", String(mockPort), "--errors"],
    { stdio: ["ignore", "pipe", "pipe"] },
  );
  mock.stdout.pipe(log);
  mock.stderr.pipe(log);

  let ready = false;
  for (let i = 0; i < 60 && !ready && mock.exitCode === null; i++) {
    try {
      await fetch(mockUrl);
      ready = true;
    } catch {
      await new Promise((r) => setTimeout(r, 1000));
    }
  }
  if (!ready) {
    console.error(`Prism mock did not start on ${mockUrl}; see build/prism.log`);
    process.exit(1);
  }
}

run("newman", "newman", [
  "run", join("build", "hmis-api.postman_collection.json"),
  "--env-var", `baseUrl=${baseUrl}`,
  "--reporters", "cli,junit",
  "--reporter-junit-export", join("build", "newman-results.xml"),
]);
// Exit explicitly: the running Prism child would otherwise keep Node alive.
process.exit(0);
