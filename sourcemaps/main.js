'use strict';
/*global Reveal */
/*jshint immed: false, expr: true, laxbreak: true, laxcomma: true*/

var testing = false;
//var testing = true;

function drawCurve(ctx, x1, y1, x2, y2, x3, y3) {
  ctx.beginPath();
  ctx.moveTo(x1, y1);
  ctx.quadraticCurveTo(x2, y2, x3, y3);

  ctx.lineWidth = 5;
  ctx.strokeStyle = 'blue';
  ctx.stroke();
}

function loadImage(ctx, name, x, y, cb) {
  var img = new Image();
  img.onload = function () { 
    ctx.drawImage(img, x, y);
    if (typeof cb === 'function') cb();
  }
  img.src = 'img/' + name;
}

function start(ev) {
  var cs = ev.currentSlide;
  var cw = 900;
  var ch = 650;

  +function appleSauce () {
    var canvas = cs.querySelector("#apple-canvas");
    if (!canvas) return;
    canvas.width = cw;
    canvas.height = ch;

    var ctx = canvas.getContext('2d');
    loadImage(ctx, 'applesauce.jpg', 60, 60);
    loadImage(ctx, 'apple-red.png', cw - 60 - 300, 0);
    loadImage(ctx, 'apple-green.png', cw - 60 - 300, 220);
    loadImage(ctx, 'apple-rotten.jpg', cw - 60 - 300, ch - 60 - 150);

    function firstApple(cb) {
      Reveal.removeEventListener('fragmentshown', firstApple);
      drawCurve(ctx, 160, 180, cw / 2, 60, cw - 60 - 200, 100);
      if (typeof cb === 'function') cb();
      Reveal.addEventListener('fragmentshown', secondApple);
    }

    function secondApple(cb) {
      Reveal.removeEventListener('fragmentshown', secondApple);
      drawCurve(ctx, 160, 340, cw / 2, 550, cw - 60 - 200, 350);
      if (typeof cb === 'function') cb();
      Reveal.addEventListener('fragmentshown', thirdApple);
    }

    function thirdApple(cb) {
      Reveal.removeEventListener('fragmentshown', thirdApple);
      drawCurve(ctx, 160, 600, cw / 2, 700, cw - 60 - 200, 550);
      if (typeof cb === 'function') cb();
    }

    function test() {
      setTimeout(
        function () { 
          firstApple(function () {
            secondApple(function () {
              thirdApple();
            });  
          });
        }
      , 200);
    }

    return testing 
      ? test() 
      : Reveal.addEventListener('fragmentshown', firstApple);
  }()

}

Reveal.addEventListener(testing ? 'ready' : 'slidechanged', start);
