# XML to JSON Converter

You are given an XML file at: `src/data.xml`

## Your Task

Write a single Bash script called `execute.sh` that:

* Reads `src/data.xml`
* Converts the XML into valid JSON
* Writes the result to `out/output.json`
* Must preserve:
  * Nested structure
  * XML attributes (e.g., `id="1"`, `category="fiction"`)
  * Arrays for repeated elements (e.g., multiple `<person>`, `<member>`)
  * Text content of tags

## Example Input (src/data.xml)

```xml
<?xml version="1.0"?>
<root>
  <person id="1">
    <name>John</name>
  </person>
  <person id="2">
    <name>Jane</name>
  </person>
</root>
```

## Expected Output (out/output.json)

```json
{
  "root": {
    "person": [
      { "@id": "1", "name": "John" },
      { "@id": "2", "name": "Jane" }
    ]
  }
}
```