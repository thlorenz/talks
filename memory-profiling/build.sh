#!/usr/bin/env bash

IMAGEROOT='https://raw.githubusercontent.com/thlorenz/talks/gh-pages/memory-profiling/img/'

link_img() {
  for D in *; do
    if [ -d "${D}" ]; then
      ln -s ../../img $D/img
    fi
  done
}

show() {
  gitbookify slides.md -o prep-gitbook      && \
    rm -rf ./book                           && \
    gitbook build ./prep-gitbook -o  ./book && \
    cd ./book                               && \
    link_img                                && \
    echo "http://localhost:3000" && http-server -p 3000 -c-1
}

build() {
  cat slides.md                    \
  | sed -e "s|(img/|($IMAGEROOT|g" \
  | sed -e "s|src=\"img/|src=\"$IMAGEROOT|g" \
  > pub-slides.md

  gitbookify pub-slides.md -o prep-gitbook  && \
    rm -rf ./book                           && \
    gitbook build ./prep-gitbook -o  ./book && \
    rm pub-slides.md
}

rm -rf ./prep-gitbook
if [[ $PUBLISH == 1 ]]; then
  build
else
  show
fi
