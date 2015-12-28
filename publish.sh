#!/bin/bash

jekyll b
ghp-import -m "Generate jekyll site" -b master _site
git push origin master
