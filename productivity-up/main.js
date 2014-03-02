'use strict';
/*global Reveal */
/*jshint immed: false, expr: true, laxbreak: true, laxcomma: true*/

var testing = false;
//var testing = true;

var tickerintervals = [];
var tickerspeed = 50;

function ticker(el, start) {
  var count = start;
  function update() {
    var step = Math.floor(Math.random() * (start / 5)) + 1;
    count += step;
    el.innerHTML = ''+count;
  }
  tickerintervals.push(setInterval(update, tickerspeed));
}

function start(ev) {
  var cs = ev.currentSlide;
  +function initTickers () {
    var tickers = cs.querySelector("#tickers");
    if (!tickers) return;

    // clear old tickers (in case we go back and forth in slides
    var iv;
    while(iv = tickerintervals.pop(), iv) clearInterval(iv);

    ticker(tickers.querySelector('#arrow-keys-ticker'), 24343);
    ticker(tickers.querySelector('#massage-pinky-ticker'), 55632);
    ticker(tickers.querySelector('#waiting-ide-ticker'), 99299);
    ticker(tickers.querySelector('#vim-ticker'), 883212212248);
  }()
}

Reveal.addEventListener(testing ? 'ready' : 'slidechanged', start);
