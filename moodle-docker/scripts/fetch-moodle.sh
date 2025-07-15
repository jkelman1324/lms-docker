#!/bin/bash

VERSION="v5.0.1"

set -e

# Clone moodle repo
git clone https://github.com/moodle/moodle.git
cd moodle
git checkout $VERSION
