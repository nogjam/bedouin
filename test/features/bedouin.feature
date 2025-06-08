Feature: Bedouin
    In order to make database schema definition and migration easier,
    As a developer,
    I want to be able to define a schema with JSON and migrate to a new schema
    simply by changing the JSON.

    Scenario: Simple schema
        Given the following JSON schema
            """
            {
                "version-id": "abcdefg",
                "version-sequence": 1,
                "tables": [
                    "data": {
                        "columns": [
                            {
                                "number": int,
                                "description": str
                            }
                        ]
                    }
                ]
            }
            """
        When we run the generate command
        Then the following SQL should be generated
            """
            CREATE TABLE IF NOT EXISTS data (
                row_id INTEGER PRIMARY KEY,
                number INTEGER NOT NULL,
                description TEXT NOT NULL
            )
            """
        And we should be able to persist the following records
            """
            [
                (1, "The first"),
                (2, "The second"),
            ]
            """
