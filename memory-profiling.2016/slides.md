# Memory Profiling For Mere Mortals 

#### Or why Bobby Shouldnt be so Greedy

![toystory](img/toystory.png)

# Memory Profiling For Mere Mortals 

<p style="text-align: center;">
  <img src="img/tty.png" alt="tty">
</p>
<p style="text-align: center;">
  <small><a href="http://thlorenz.com">Thorsten Lorenz</a></small>
</p>
<p style="text-align: center;">
  <small>twitter <a href="http://twitter.com/thlorenz">@thlorenz</a>  |  github  <a href="http://github/thlorenz">@thlorenz</a>  |  irc  thlorenz</small>
</p>

# Toy Story

![toystory-1](img/toystory-1.png)

# Toy Story

![toystory-2](img/toystory-2.png)

# Toy Story

![toystory-3](img/toystory-3.png)

# Toy Story

![toystory-4](img/toystory-4.png)

# Toy Story

![toystory-5](img/toystory-5.png)

# Toy Story

![toystory-6](img/toystory-6.png)

# Toy Story

![toystory-7](img/toystory-7.png)

# Toy Story

![toystory-8](img/toystory-8.png)

# Toy Story

![toystory-9](img/toystory-9.png)

# Toy Story

![toystory-10](img/toystory-10.png)

# Toy Story

![toystory-11](img/toystory-11.png)

# Toy Story

![toystory-12](img/toystory-12.png)

# Toy Story

![toystory-13](img/toystory-13.png)

# Toy Story

![toystory-14](img/toystory-14.png)

<!--
- triceratops (threehorned dinosaur)
-->

# Toy Story

![toystory-15](img/toystory-15.png)

# Toy Story

![toystory-16](img/toystory-16.png)

# Toy Story

![toystory-17](img/toystory-17.png)

# Toy Story

![toystory-18](img/toystory-18.png)

# HUH?

![confused](img/confused.jpg)

# Server

```js
const http = require('http')
const fs   = require('fs')
const path = require('path')
const templateEngine = require('any-template-engine')

const header = fs.readFileSync(path.join(__dirname, my-header.html), utf8)

// [ ...]

function onrequest(req, res) {
  const context = getContext(req);

  fs.readFile(path.join(__dirname, index.html), utf8, function onreadIndex(err, src) {
    if (err) return console.error(err)
    const html = header + templateEngine(src, context)
    serve(html)
  })
}
```


# Server

## House and Chimney

```js
const http = require('http')
const fs   = require('fs')
const path = require('path')
const templateEngine = require('any-template-engine')

const header = fs.readFileSync(path.join(__dirname, my-header.html), utf8)
```

# Server

## House and Chimney

```js
const http = require('http')
const fs   = require('fs')
const path = require('path')
const templateEngine = require('any-template-engine')

const header = fs.readFileSync(path.join(__dirname, my-header.html), utf8)
```

- `require`d modules and static header are **created once** and stay in memory for the life time of the server

<!-- notes
- these are shared for each processed request
-->

# Server

## Toys

```js
function onrequest(req, res) {
  const context = getContext(req);

  fs.readFile(path.join(__dirname, index.html), utf8, function onreadIndex(err, src) {
    if (err) return console.error(err)
    const html = header + templateEngine(src, context)
    serve(html)
  })
}
```

# Server

## Toys

```js
function onrequest(req, res) {
  const context = getContext(req);

  fs.readFile(path.join(__dirname, index.html), utf8, function onreadIndex(err, src) {
    if (err) return console.error(err)
    const html = header + templateEngine(src, context)
    serve(html)
  })
}
```

- resources like `context` and `src` of `index.html` are **created for each request**

# Server

## Toys

```js
function onrequest(req, res) {
  const context = getContext(req);

  fs.readFile(path.join(__dirname, index.html), utf8, function onreadIndex(err, src) {
    if (err) return console.error(err)
    const html = header + templateEngine(src, context)
    serve(html)
  })
}
```

- resources like `context` and `src` of `index.html` are **created for each request**
- should not stay in memory after processing request is finished **either with success or failure**

# Memory Leak

> In an environment in which memory is managed by a garbage collector, a memory leak occurs when references to objects
> are retained even though they are no longer needed by your program.

# Memory Leak

> In an environment in which memory is managed by a garbage collector, a memory leak occurs when references to objects
> are retained even though they are no longer needed by your program.

- especially bad if those objects are created during an action that is repeated often, like serving a request

# Memory Leak

> In an environment in which memory is managed by a garbage collector, a memory leak occurs when references to objects
> are retained even though they are no longer needed by your program.

![fish-tank](img/fish-tank.png)

<!-- notes
- if Bobby was to hold on to each fish he gets and keep them in an aquarium itd flow over at some point
-->

# Memory Leak

> Im not Bobby, I release what I no longer need

# Memory Leak

![are-you-sure](img/are-you-sure.jpg)

# Memory Leak Causes

1. registered event handlers

<!-- notes
- specifically relating to node
- in the browser its different (mostly DOM nodes hanging around)
-->

# Memory Leak Causes

1. registered event handlers
2. function closures 

# Memory Leak Causes

1. registered event handlers
2. function closures 
3. registered event handlers

# Memory Leak Causes

1. registered event handlers
2. function closures 
3. registered event handlers
4. leaking connections  

<!-- notes
- i.e. when a request fails but the connection isnt properly cleaned up
-->

# Garbage Collector

- follows *retaining path* from a *GC root* to an object
- if no such path exists, object is **unreachable** and subject to being collected

# Garbage Collector

- what is a *Root* and that *retaining path* you speak about?

<img width="350" src="img/root.jpg"/> 
<img width="350" src="img/retaining-path.jpg"/>

# Garbage Collector

![gc-nodes](img/gc-nodes.png)

[devtools/javascript-memory-profiling](https://developer.chrome.com/devtools/docs/javascript-memory-profiling)

# Garbage Collector

![gc-nodes](img/gc-nodes.png)

- node **1** is the *Root* node that *dominates* all other nodes

# Garbage Collector

![gc-nodes](img/gc-nodes.png)

- node **8** and **7** reference no other nodes, their *retaining size* is equal to their *shallow size* 
- node **6** retains node **8**, therefore its *retaining size* is the it's own *shallow size* plus the *retaining size* of node **8**

# Garbage Collector

![gc-nodes](img/gc-nodes.png)

- nodes **9** and **10** are not reachable via the *Root* node and therefore are orphaned and subject to garbage
  collection

# Garbage Collector

![gc-nodes](img/gc-nodes.png)

- if we keep referencing nodes we no longer need we got ourselves a memory leak

# Trouble Shooting Leaks

1. Reproduce (sometimes watching process with *top* suffices)

# Trouble Shooting Leaks

## Demo Time

![demo](img/demo.jpg)

<!-- notes
- crash process
- increasing memory by itself doesnt prove leak until it hits 1.5GB
- increasing memory although we repeatedly trigger garbage collection indicates a leak
- only once you reach 1.5G do you prove you have a leak since v8 is does not aggressively collect for perf reasons
- 1.5GB is heap allocated by v8 per Isolate, i.e. Tab or in our case Node.js process
-->

# Trouble Shooting Leaks

1. Reproduce (sometimes watching process with *top* suffices)
2. Isolate and find Culprit (various approaches and tools like *Instruments* and *DevTools*)

# Trouble Shooting Leaks

## Steps

1. Take *bottom line* snapshot *Checkpoint 1*
2. Perform operation that might cause a leak followed by GC
3. Take snapshot *Checkpoint 2*
4. Perform same operation as in *2.* followed by GC
5. Take snapshot *Checkpoint 3*
6. Repeat as often as you want in order to collect as many snapshots as you need

# Trouble Shooting Leaks

## Demo Time

![demo](img/demo.jpg)

<!-- notes
- DevTools using heapdump module
-->


# Trouble Shooting Leaks

## IMPORTANT!!!

![important](img/devtools-important.png)

# Trouble Shooting Leaks

## Demo Time

![demo](img/demo.jpg)

<!-- notes
- DevTools 
  - show Object Allocation Tracker
  - show closures
  - show retainer view
  - mention function closures problem
  - mention naming function declarations to show up in heapdump

- functions shown in DevTools are closing over allocated objects and prevent them from being collected

-->

# Trouble Shooting Leaks

1. Reproduce (sometimes watching process with *top* suffices)
2. Isolate and find Culprit (various approaches and tools like *Instruments* and *DevTools*)
3. Fix the Leak :) [example code](https://github.com/thlorenz/talks/tree/gh-pages/memory-profiling.2016/example)

# Considerations

![considerations](img/considerations.jpg)

# Name Your Functions

![heapdump-noname](img/heapdump-noname.png)

# Name Your Functions

![heapdump-name](img/heapdump-name.png)

# Name Your Functions

```js
var foo = function () {}
```

# Name Your Functions

![no](img/no-1.jpg)

# Name Your Functions

```js
var foo = function () {}
```

```js
var foo = function foo() {}
```

# Name Your Functions

```js
Bar.prototype.foo = function () {}
```

# Name Your Functions

<img src="img/no-2.jpeg" height="400">

# Name Your Functions

```js
Bar.prototype.foo = function () {}
```

```js
Bar.prototype.foo = function foo() {}
```

# Name Your Functions

```js
fs.readFile(file, function (err, src) {
})
```

# Name Your Functions

![no](img/no-3.jpg)

# Name Your Functions

```js
fs.readFile(file, function (err, src) {
})
```

```js
fs.readFile(file, function onreadFile(err, src) {
})
```

# Name Your Functions

```js
fs.readFile(file, (err, src) => {
})
```

# Name Your Functions

```js
fs.readFile(file, (err, src) => {
})
```

![mybag](img/mybag.png)

# Name Your Functions

```js
fs.readFile(file, (err, src) => {
})
```

![no-4](img/no-4.jpg)

# Sampling Memory Allocations

- bleeding edge feature of latest v8 (part of Nodejs v6)
- at this point samples object allocations made to the [new space](https://github.com/thlorenz/v8-perf/blob/master/gc.md#new-space)

# Sampling Memory Allocations

- we can make that API available via a [sample-heap-allocations addon](https://github.com/thlorenz/sample-heap-allocations) so you can do

```js
const sh = require('sample-heap-allocations')

sh.startSampling(32, 10)

// allocate some things like Arrays

const allocs = sh.collectAllocations()
console.log(allocs)
```

# Sampling Memory Allocations

![sampleburst](img/sampleburst.jpg)

# Sampling Memory Allocations

```js
exports.innerOuterArray = function innerOuterArray() {
  const arr = []
  const OUTER_ITER = ITER / 20
  const INNER_ITER = OUTER_ITER * 10

  for (let j = 0; j < OUTER_ITER; j++) {
    let innerArr = []
    for (let i = 0; i < INNER_ITER; i++) {
      innerArr.push({ i: i })
    }
    arr.push(innerArr)
  }
  return arr
}
```

# Demo Time

![demo](img/demo.jpg)

# Resources

![v8-perf](img/v8-perf.png)

- [thlorenz.github.io/v8-perf/](https://thlorenz.github.io/v8-perf/)
  - [garbage collector](https://github.com/thlorenz/v8-perf/blob/master/gc.md)
  - [memory profiling](https://github.com/thlorenz/v8-perf/blob/master/memory-profiling.md)
- [sample-heap-allocations addon](https://github.com/thlorenz/sample-heap-allocations) 

# Thanks!

<p style="text-align: center;">
  <img src="img/rainier.png" alt="rainier">
</p>
<p style="text-align: center;">
  <small><a href="http://thlorenz.com">thorsten lorenz</a></small>
</p>
<p style="text-align: center;">
  <small>twitter <a href="http://twitter.com/thlorenz">@thlorenz</a>  |  github  <a href="http://github/thlorenz">@thlorenz</a>  |  irc  thlorenz</small>
</p>
