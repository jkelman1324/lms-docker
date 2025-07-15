#!/usr/bin/env python3

import json

ATTRIBUTES = ["username", "password", "firstname", "lastname", "email"]

with open("data/users.json", "r") as file:
    users = json.load(file)

print(",".join(ATTRIBUTES))

for user in users:
    row = [
        user["email"],
        user["password"],
        user["name-last"],
        user["name-last"],
        user["email"]
    ]

    print(",".join(row))
