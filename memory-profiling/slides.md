# Memory Profiling For Mere Mortals 

#### Or why Bobby Shouldnt be so Greedy

![toystory](img/toystory.png)

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

# Toy Story

![toystory-15](img/toystory-15.png)

# Toy Story

![toystory-16](img/toystory-16.png)

# Toy Story

![toystory-17](img/toystory-17.png)

# Toy Story

![toystory-18](img/toystory-18.png)

# Server

```js
var http           = require(http)
  , fs             = require(fs)
  , path           = require(path)
  , templateEngine = require(any-template-engine)

var header = fs.readFileSync(path.join(__dirname, my-header.html), utf8)

// [ ...]

function onrequest(req, res) {
  var context = getContext(req);

  fs.readFile(path.join(__dirname, index.html), utf8, function onreadIndex(err, src) {
    if (err) return console.error(err)
    var html = header + templateEngine(src, context)
    serve(html)
  })
}
```


# Server

## House and Chimney

```js
var http           = require(http)
  , fs             = require(fs)
  , path           = require(path)
  , templateEngine = require(any-template-engine)

var header = fs.readFileSync(path.join(__dirname, my-header.html), utf8)
```

# Server

## House and Chimney

```js
var http           = require(http)
  , fs             = require(fs)
  , path           = require(path)
  , templateEngine = require(any-template-engine)

var header = fs.readFileSync(path.join(__dirname, my-header.html), utf8)
```

- `require`d modules and static header are **created once** and stay in memory for the life time of the server

<!-- notes
- these are shared for each processed request
-->

# Server

## Toys

```js
function onrequest(req, res) {
  var context = getContext(req);

  fs.readFile(path.join(__dirname, index.html), utf8, function onreadIndex(err, src) {
    if (err) return console.error(err)
    var html = header + templateEngine(src, context)
    serve(html)
  })
}
```

# Server

## Toys

```js
function onrequest(req, res) {
  var context = getContext(req);

  fs.readFile(path.join(__dirname, index.html), utf8, function onreadIndex(err, src) {
    if (err) return console.error(err)
    var html = header + templateEngine(src, context)
    serve(html)
  })
}
```

- resources like `context` and `src` of `index.html` are **created for each request**

# Server

## Toys

```js
function onrequest(req, res) {
  var context = getContext(req);

  fs.readFile(path.join(__dirname, index.html), utf8, function onreadIndex(err, src) {
    if (err) return console.error(err)
    var html = header + templateEngine(src, context)
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

- node **8** and **7** reference no other nodes, there *retaining size* is `0`
- node **6** retains node **8**, therefore its *retaining size* is the size of node **8**

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
- Instruments and DevTools using heapdump module
- mention 
  - function closures problem
  - naming function declarations to show up in heapdump
-->

# Trouble Shooting Leaks

1. Reproduce (sometimes watching process with *top* suffices)
2. Isolate and find Culprit (various approaches and tools like *Instruments* and *DevTools*)
3. Fix the Leak :)

# Thanks!

<p style="text-align: center;">
  <img src="http://thlorenz.com/img/avatar.jpg" alt="headshot">
</p>
<p style="text-align: center;">
  <small><a href="http://thlorenz.com">thorsten lorenz</a></small>
</p>
<p style="text-align: center;">
  <small>twitter <a href="http://twitter.com/thlorenz">@thlorenz</a>  |  github  <a href="http://github/thlorenz">@thlorenz</a>  |  irc  thlorenz</small>
</p>
