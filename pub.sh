#!/bin/bash

gitbook build .
cp -rf _book/* ~/GitHub/Handlebars_Pages
cd ~/GitHub/Handlebars_Pages
git add .
git commit -m 'pub'
git push origin gh-pages
