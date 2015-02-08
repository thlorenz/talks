## Abstract

When it comes to getting insight into our Node.js application we usually face a minor challenge. Tools to make this easy
just haven't evolved as far as they have for technologies that have been around much longer.

But if we take some time to investigate what's out there and get creative we can go much further than most of us might
think.

In this talk I will show practical examples how to use existing tools to do that and how we can improve on those with
user land modules.

## Details

One challenge of course is the fact that we are dealing with two seemingly separate parts of the Node.js stack, one
being the C layer which enables system calls, the other being the JavaScript layer which ends up driving the former.

I will show how to attack problems from both layers and how to connect the pieces from each to arrive at a complete
picture of what our Node.js app is doing.

Topics I will mention and/or demonstrate in the talk:

- debugging the C layer with lldb or Xcode
- debuggging the JavaScript layer with NodeInspector and how my work at debugium is about to make that a lot easier with
  lots of added features
- connecting C layer and JavaScript layer stack traces via symbolication
- flamegraphs on any development system, including Mac OSX
- profiling a Node.js app

## Importance

Giving the audience information needed to improve the Node.js debugging experience is crucial as limited insight into a
running server is hard to accept for developers coming from stacks like the JVM which provides a very high level of
insight.

This talk is designed to show that there are indeed ways to gain insight today as well as efforts to majorly improve on
them in the near future.

## Highlights

- tracing a system level call all the way back to the JavaScript call that is responsible for it happening
- demonstrating the power we have to fix some of the current shortcomings with user land modules
- detecting the effects of a memory leak with Instruments, an OSX frontend to DTrace, on the C layer and tracing it back
  to the JavaScript that caused it to occurr
- making people realize that to gain insight into a Node.js app it doesn't need to run on SmartOS, but that debugging tools on Linux
  as well as on OSX exist

## Additional Notes

This talk will have lots of demos designed to trigger a "WOW I didn't know you could do that" reaction from the
audience, and therefore should be lots of fun as well as very informative.
