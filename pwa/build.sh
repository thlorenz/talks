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

improve_fonts() {
  echo '' >> $DIR/book/gitbook/style.css
  echo "@import url('https://fonts.googleapis.com/css?family=Source+Sans+Pro');" >> $DIR/book/gitbook/style.css
  echo "@import url('https://fonts.googleapis.com/css?family=Source+Code+Pro');" >> $DIR/book/gitbook/style.css
  sed -i.orig "s/Consolas/'Source Code Pro'/" $DIR/book/gitbook/style.css
  sed -i.orig "s/Open Sans/Source Sans Pro/" $DIR/book/gitbook/style.css
}

improve_layout() {
  echo '' >> $DIR/book/gitbook/style.css
  echo '.book .book-body .page-wrapper .page-inner section.normal { width: 900px }' >> $DIR/book/gitbook/style.css
}

show() {
  nave use 6 gitbookify slides.md -o prep-gitbook   && \
    rm -rf ./book                                   && \
    nave use 6 gitbook build ./prep-gitbook  ./book && \
    cd ./book                                       && \
    link_img                                        && \
    improve_fonts                                   && \
    improve_layout                                  && \
    echo "http://localhost:3000" && http-server -p 3000 -c-1
}

build() {
  cat slides.md                    \
  | sed -e "s|(img/|($IMAGEROOT|g" \
  | sed -e "s|src=\"img/|src=\"$IMAGEROOT|g" \
  > pub-slides.md

  nave use 6 gitbookify slides.md -o prep-gitbook  && \
    rm -rf ./book                                  && \
    nave use 6 gitbook build ./prep-gitbook ./book && \
    cd ./book                                      && \
    link_img                                       && \
    improve_fonts                                  && \
    improve_layout                                 && \
    cd $DIR                                        && \
    rm -rf pub-slides.md prep-gitbook
}

rm -rf ./prep-gitbook
if [[ $PUBLISH == 1 ]]; then
  build
else
  show
fi

