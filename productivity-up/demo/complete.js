'use strict';

var esprima = require('esprima');

var js = 'var a = 2; function foo() { console.log(a); } foo();';
var ast = esprima.parse(js, { range: true });

var body = ast.body;
var dec = body.filter(function (x) { 
  return x.type = esprima.Syntax.VariableDeclaration 
})[0]

var range = dec.declarations[0].init.range;
var code = js.slice(0, range[0]) + '3' + js.slice(range[1]);
