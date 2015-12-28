#!/bin/bash

ghp-import -m "Generate jekyll site" -b master _site
git push origin master
