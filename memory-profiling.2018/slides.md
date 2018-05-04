# Memory Profiling For Mere Mortals

#### Or why Bobby Shouldnt be so Greedy

![toystory](img/toystory.png)

# Memory Profiling For Mere Mortals

<p style="text-align: center;">
  <img src="img/inside-tree.jpg" alt="inside-tree" width="40%">
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

const header = fs.readFileSync(path.join(__dirname, 'my-header.html'), 'utf8')

// [ ...]

function onrequest(req, res) {
  const context = getContext(req);

  fs.readFile(path.join(__dirname, 'index.html'), 'utf8', function onreadIndex(err, src) {
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

const header = fs.readFileSync(path.join(__dirname, 'my-header.html'), 'utf8')
```

# Server

## House and Chimney

```js
const http = require('http')
const fs   = require('fs')
const path = require('path')
const templateEngine = require('any-template-engine')

const header = fs.readFileSync(path.join(__dirname, 'my-header.html'), 'utf8')
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

  fs.readFile(path.join(__dirname, 'index.html'), 'utf8', function onreadIndex(err, src) {
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

  fs.readFile(path.join(__dirname, 'index.html'), 'utf8', function onreadIndex(err, src) {
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

  fs.readFile(path.join(__dirname, 'index.html'), 'utf8', function onreadIndex(err, src) {
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
3. function closures

# Memory Leak Causes

1. registered event handlers
2. function closures
3. function closures
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
2. Isolate and find Culprit by profiling via `node --inspect` and *DevTools*

# Inspecting with Chrome DevTools

Relies on `--inspect` option which arrrived with node v6

```
> node -v
v4.6.2

> node --inspect
node: bad option: --inspect
```

# Inspecting with Chrome DevTools

<blockquote width="50%" class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">Node 4 LTS end of life is today; please migrate to a newer version, and remember to test for breakage before deploying.<a href="https://t.co/EpqIA3CNGN">https://t.co/EpqIA3CNGN</a> <a href="https://t.co/23I2skvqcu">pic.twitter.com/23I2skvqcu</a></p>&mdash; Bradley Farias (@bradleymeck) <a href="https://twitter.com/bradleymeck/status/990972497427357696?ref_src=twsrc%5Etfw">April 30, 2018</a></blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

_Shouldn't be running Node.js <v6 anymore anyways_

# Inspecting with Chrome DevTools

<img src="img/snapshot-01.png" alt="chrome-inspect" width="70%">

- take snapshots via _Take Snapshot_ button and _red circle_ on upper right

# Inspecting with Chrome DevTools

<img src="img/snapshot-02.png" alt="chrome-inspect" width="70%">

- look at objects still present in snapshot 3 that were created in between snapshot 1 and 2

# Inspecting with Chrome DevTools

<img src="img/snapshot-03.png" alt="chrome-inspect" width="70%">

- dig in to find the culprit

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
- DevTools using heapdump module or `inspect`
  - show Object Allocation Tracker
  - show closures
  - show retainer view
  - mention function closures problem
  - mention naming function declarations to show up in heapdump

- functions shown in DevTools are closing over allocated objects and prevent them from being collected

-->

# Trouble Shooting Leaks

1. Reproduce (sometimes watching process with *top* suffices)
2. Isolate and find Culprit by profiling via `node --inspect` and *DevTools*
3. Fix the Leak :) [example code](https://github.com/thlorenz/talks/tree/gh-pages/memory-profiling.2018/app)

# Considerations

![considerations](img/considerations.jpg)

- V8 has gotten much better at naming your functions for you
- regardless, properly naming your functions is good practice

# Name Your Functions

![heapdump-noname](img/heapdump-noname.png)

# Name Your Functions

![heapdump-name](img/heapdump-name.png)

# Name Your Functions

```js
const create = function () {}
```

# Name Your Functions

![no](img/no-1.jpg)

# Name Your Functions

```js
const create = function () {}
```

<img src="img/fn-assigned.png" alt-"assigned-fn" width="60%">

_Well, actually it's fine now ..._

# Name Your Functions

```js
Creator.prototype.create = function () {}
```

# Name Your Functions

<img src="img/no-2.jpeg" height="400">

# Name Your Functions

```js
Creator.prototype.create = function () {}
```

<img src="img/fn-proto.png" alt-"proto-fn" width="60%">

_Well, actually it's fine now ..._

# Name Your Functions

```js
class Creator {
  create(arr) { /* ... */ }
}
```

<img src="img/fn-class.png" alt-"class-fn" width="60%">

_Also with classes ..._

# Name Your Functions

```js
go(file, function (err, src) { /* ... */ })
```

# Name Your Functions

![no](img/no-3.jpg)

# Name Your Functions

```js
go(function (err, src) { /* ... */ })
```

<img src="img/fn-anonymous.png" alt-"anonymous-fn" width="60%">

_That is a bad idea still ..._

# Name Your Functions

```js
go(function (err, src) { /* ... */ })
```

```js
go(function create(err, src) { /* ... */ })
```

# Name Your Functions

```js
go((err, src) => { /* .. /* })
```

# Name Your Functions

```js
go((err, src) => { /* .. */ })
```

![mybag](img/mybag.png)

# Name Your Functions

```js
go((err, src) => { /* .. */ })
```

![no-4](img/no-4.jpg)

# Name Your Functions

```js
go((err, src) => { /* .. */ })
```

<img src="img/fn-arrow.png" alt-"arrow-fn" width="60%">

_Actually it's better now, but not great ..._

# Name Your Functions

```js
const create = (err, src) => { /* .. */ }
go(create)
```

<img src="img/fn-arrow-assigned.png" alt-"arrow-assigned-fn" width="60%">

_This is much better ..._

# Recording Allocation Profile

```
> node --inspect
Debugger listening on ws://127.0.0.1:9229/a42a3588-f89f-4c2d-87e8-0b22da716e37
For help, see: https://nodejs.org/en/docs/inspector
```

Then open a _Open dedicated DevTools for Node_ via [chrome://inspect](chrome://inspect)

<img src="img/chrome-inspect.png" alt="chrome-inspect" width="60%">

# Recording Allocation Profile

![img](img/alloc-profile-select.png)

# Recording Allocation Profile

![img](img/alloc-profile-graph.png)

- shows which functions _allocated_ most memory

# Recording Allocation Profile

## Demo Time

![demo](img/demo.jpg)

<!-- notes
- start same app
- start recording allocation profile
- curl a few times and show result after stopping the recording
-->

# Recording Allocation Profile

#### Recording Allocation Profile with Node.js Programatically

- the [sampling-heap-profiler](https://github.com/v8/sampling-heap-profiler) package allows to
  trigger and stop heap samples programatically and write them to a file
- supposed to be lightweight enough for in-production use on servers
- generated snapshots can be saved offline, and be opened in DevTools later

# Recording Allocation Timeline

![img](img/timeline-01.png)

# Recording Allocation Timeline

![img](img/timeline-02.png)

- tracks memory being allocated in real time
- allocated objects can be inspected similar to heap snapshots

# Demo Time

![demo](img/demo.jpg)

# Resources

### [github.com/thlorenz/v8-perf](https://github.com/thlorenz/v8-per)

<img src="img/v8-perf.png" alt="v8-perf" width="60%">

- [garbage collector](https://github.com/thlorenz/v8-perf/blob/master/gc.md)
- [memory profiling](https://github.com/thlorenz/v8-perf/blob/master/memory-profiling.md)

# Thanks!

<p style="text-align: center;">
  <img src="img/rainier.png" alt="rainier" width="60%">
</p>
<p style="text-align: center;">
  <small><a href="http://thlorenz.com">thorsten lorenz</a></small>
</p>
<p style="text-align: center;">
  <small>twitter <a href="http://twitter.com/thlorenz">@thlorenz</a>  |  github  <a href="http://github/thlorenz">@thlorenz</a>  |  irc  thlorenz</small>
</p>
