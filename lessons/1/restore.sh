#! /bin/bash

scriptdir="$(dirname "$0")"
cd "$scriptdir"

git restore --staged .
git restore .
git rm -rf ./commit-practice
git checkout origin/master ./commit-practice