#!/bin/bash

set -e

# Clone moodle repo
git clone https://github.com/moodle/moodle.git && \
    cd moodle && git checkout v5.0.1

