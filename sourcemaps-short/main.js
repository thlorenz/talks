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


  +function chickNegg () {
    var canvas = cs.querySelector("#chick-canvas");
    if (!canvas) return;
    canvas.width = cw;
    canvas.height = ch;

    var ctx = canvas.getContext('2d');

    function eggLowerLeft(cb) {
      Reveal.removeEventListener('fragmentshown', eggLowerLeft);
      loadImage(ctx, 'egg.png', 60, ch - 300, cb);
      Reveal.addEventListener('fragmentshown', chickenUpperRight);
    }

    function chickenUpperRight(cb) {
      Reveal.removeEventListener('fragmentshown', chickenUpperRight);

      loadImage(ctx, 'chicken.png', cw - 60 - 200, 50, function () {
        drawCurve(ctx, 150, ch - 170, cw / 2, 40, cw - 60 - 150, 160);
        if (typeof cb === 'function') cb();
        Reveal.addEventListener('fragmentshown', eggLowerRight);
      });
    }

    function eggLowerRight(cb) {
      Reveal.removeEventListener('fragmentshown', eggLowerRight);
      loadImage(ctx, 'egg.png', cw - 60 - 200, ch - 300, function () {
        drawCurve(ctx, cw - 60 - 40, 180, cw + 100, 240, cw - 60 - 100, ch - 240);
        if (typeof cb === 'function') cb();
        Reveal.addEventListener('fragmentshown', chickenUpperLeft);
      });
    }

    function chickenUpperLeft(cb) {
      Reveal.removeEventListener('fragmentshown', chickenUpperLeft);

      loadImage(ctx, 'chicken.png', 60, 50, function () {
        drawCurve(ctx, cw - 60 - 100, ch - 170, cw / 2, 40, 60 + 50, 160);
        if (typeof cb === 'function') cb();
        Reveal.addEventListener('fragmentshown', connectEggLowerLeft);
      });
    }

    function connectEggLowerLeft(cb) {
      Reveal.removeEventListener('fragmentshown', connectEggLowerLeft);
      drawCurve(ctx, 60 + 100, 190, -90, 240, 100, ch - 240);
    }

    function test() {
      eggLowerLeft(function () {
        chickenUpperRight(function () {
          eggLowerRight(function () {
            chickenUpperLeft(connectEggLowerLeft); 
          });
        });
      });
    }

    return testing 
      ? test() 
      : Reveal.addEventListener('fragmentshown', eggLowerLeft);
  }()


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
