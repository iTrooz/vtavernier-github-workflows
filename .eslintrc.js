module.exports = {
  extends: ["plugin:yml/standard", "plugin:json-schema-validator/recommended"],
  rules: {
    "json-schema-validator/no-invalid": [
      "error",
      {
        schemas: [
          {
            fileMatch: [".github/workflows/*.yml"],
            schema: "https://json.schemastore.org/github-workflow.json",
          },
        ],
      },
    ],
  },
};
