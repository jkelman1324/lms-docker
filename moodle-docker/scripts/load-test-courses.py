#!/usr/bin/env python3

import json
import os

ATTRIBUTES = ["shortname", "fullname", "category", "enrolment_1"]
THIS_DIR = os.path.abspath(os.path.dirname(os.path.realpath(__file__)))
COURSES_PATH = os.path.join(THIS_DIR, "..", "data", "courses.json")

with open(COURSES_PATH, "r") as file:
    courses = json.load(file)

print(",".join(ATTRIBUTES))

for course in courses:
    row = [
        course["shortname"],
        course["fullname"],
        "1",
        "manual"
    ]

    print(",".join(row))

