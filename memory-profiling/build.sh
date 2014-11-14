#!/usr/bin/env bash

link_img() {
  for D in *; do
    if [ -d "${D}" ]; then
      ln -s ../../img $D/img
    fi
  done
}

rm -rf ./gitbook
gitbookify slides.md -o gitbook      && \
  rm -rf ./book                      && \
  gitbook build ./gitbook -o  ./book && \
  cd ./book                          && \
  link_img                           && \
  echo "http://localhost:3000" && http-server -p 3000 -c-1
