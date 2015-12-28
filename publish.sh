#!/bin/bash

jekyll b
ghp-import --no-jekyll -m "Generate jekyll site" -b master _site
git push origin master
