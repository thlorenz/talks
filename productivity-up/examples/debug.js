var calledFoo = 0;

function foo() {
  calledFoo++;
  console.log('foo');
}

function bar() {
  for (var i = 0; i < 5; i++) {
    foo();
  }
}

bar();
