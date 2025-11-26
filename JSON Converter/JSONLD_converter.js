function jsonLdToJson(jsonLd) {
const json = { ...jsonLd };
delete json["@context"];
delete json["@type"];
delete json["@id"];
return json;
}

// Example usage
const jsonLd = {
"@context": "https://schema.org",
"@type": "Person",
"@id": "https://example.com/person/123",
"name": "John Doe",
"jobTitle": "Software Engineer",
"url": "https://example.com/johndoe"
};

console.log(jsonLdToJson(jsonLd));

{
  name: 'John Doe',
  jobTitle: 'Software Engineer',
  url: 'https://example.com/johndoe'
}