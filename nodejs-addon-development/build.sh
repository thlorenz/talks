#!/usr/bin/env bash

rm -rf ./gitbook
gitbookify slides.md -o gitbook                                && \
  rm -rf ../nodejs-addon-development-book                      && \
  gitbook build ./gitbook -o  ../nodejs-addon-development-book && \
  cd ../nodejs-addon-development-book                          && \
  ln -s ../nodejs-addon-development/img/ img                   && \
  echo "http://localhost:3000" && http-server -p 3000 -c-1
