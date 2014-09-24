#!/usr/bin/env bash

rm -rf ./gitbook
gitbookify slides.md -o gitbook && ln -s ../img gitbook/img && gitbook serve ./gitbook
