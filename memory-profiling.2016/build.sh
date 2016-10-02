#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
REPO=$(basename $DIR)

IMAGEROOT="https://raw.githubusercontent.com/thlorenz/talks/gh-pages/$REPO/img/"

link_img() {
  for D in *; do
    if [ -d "${D}" ]; then
      ln -s ../../img $D/img
    fi
  done
}

show() {
  gitbookify slides.md -o prep-gitbook   && \
    rm -rf ./book                        && \
    gitbook build ./prep-gitbook  ./book && \
    mv ./prep-gitbook/_book ./book       && \
    cd ./book                            && \
    link_img                             && \
    echo "http://localhost:3000" && http-server -p 3000 -c-1
}

build() {
  cat slides.md                    \
  | sed -e "s|(img/|($IMAGEROOT|g" \
  | sed -e "s|src=\"img/|src=\"$IMAGEROOT|g" \
  > pub-slides.md

  gitbookify pub-slides.md -o prep-gitbook && \
    rm -rf ./book                          && \
    gitbook build ./prep-gitbook ./book    && \
    mv ./prep-gitbook/_book ./book         && \
    rm -rf pub-slides.md prep-gitbook 
}

rm -rf ./prep-gitbook
if [[ $PUBLISH == 1 ]]; then
  build
else
  show
fi
