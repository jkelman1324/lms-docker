#!/usr/bin/env python3

import json
import os

ATTRIBUTES = ["username", "password", "firstname", "lastname", "email", "course1", "role1"]
THIS_DIR = os.path.abspath(os.path.dirname(os.path.realpath(__file__)))
USERS_PATH = os.path.join(THIS_DIR, "..", "data", "users.json")
ROLE_MAP = {
    "admin": "editingteacher",
    "grader": "teacher",
    "other": "guest",
    "owner": "manager",
    "student": "student"
}

with open(USERS_PATH, "r") as file:
    users = json.load(file)

print(",".join(ATTRIBUTES))

for user in users:
    row = [
        user["email"],
        user["password"],
        user["name-last"],
        user["name-last"],
        user["email"],
        "course101",
        ROLE_MAP[user["course-info"]["course101"]["role"]]
    ]

    print(",".join(row))
