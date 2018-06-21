#### Slide 4:

- combines cutting-edge IR (intermediate representation) with multi-layered translation +
  optimization pipeline
- clearer separation between JavaScript, V8 and the target architectures allows cleaner, more
  robust generated code and adds flexibility
- generates better quality machine code than Crankshaft JIT

#### Slide 5:

- won’t go into too much detail as there are already lots of talks out there explaining the
  inner workings of new compiler chain
- focus on some JS language features that improved and how that was possible

#### Slide 6:

- for most websites the optimizing compiler isn't important and could even hurt performance
  (speculative optimizations aren't cheap)
- pages need to load fast and unoptimized code needs to run fast enough, esp. on mobile devices

#### Slide 7:

- previous V8 implementations suffered from performance cliffs
- could be 100x degradation

#### Slide 8:

Baseline Performance Improved

- no longer relying on optimizing compiler for sufficiently fast code
- thus improved baseline performance allows delaying optimization until more feedback is
  collected
- avoids optimizations of infrequently executed code
- leads to less time and resources spent optimizing

TurboFan improves this as:

- widens fast path to ensure that optimized code is more flexible and can accept more types of
  arguments
- reduces code memory overhead by reusing code generation parts of TurboFan to build Ignition
  interpreter
- improves slow path

#### Slide 10:

- generates optimized code just for those cases which is not only smaller but also executes at
  peak speed
- TurboFan uses Ignition bytecode directly to optimize (no re-parse needed)


#### Slide 11:

##### Presenter Notes:
- other subtle optimization killers that made performance unpredictable are no longer an issue
  and if they are they can be easily fixed in TF, i.e. passing undefined as first parameter to
  Math.max.apply
- easier to support future JavaScript features as the JavaScript frontend is clearly separated
  from the architecture dependent backends
- new language features are not useful by just being implemented
- need to be fast (at least matching transpiled code), related optimizations are easier with
  new pipeline

#### Slide 15:

- what needed to be done in C++ to be fast now can be done with CSA and is just as fast
- due to improved integration with other parts of compiler chain no crossing C++/JS is needed
- CSA understands API calling conventions, both standard C++ and internal V8 register-based,
  i.e. entry-point stubs into C++ can easily be called from CSA, making trivial to interoperate
  between CSA generated code and other parts of V8

#### Slide 16:

##### Presenter Notes:
- CSA includes type verification at IR level to catch many correctness bugs at compile time
- CSA's instruction selector ensures that optimal code is generated on all platforms
- CSA's performs register allocations automatically
- CSA understands API calling conventions, both standard C++ and internal V8 register-based,
  i.e. entry-point stubs into C++ can easily be called from CSA, making trivial to interoperate
  between CSA generated code and other parts of V8


#### Slide 22:

- each node is an operation
- Crankshaft created CFG through the nodes and then applied optimizations which is rather
  limiting

#### Slide 24:

- relaxed sea of nodes approach allows more effective reordering and optimization when
  generating CFG
- to achieve that fluid code motion, control flow optimizations and precise numerical range
  analysis are used
- control flow elimination turns branch chains into switches


#### Slide 26:

- no more Crankshaft script necessary


#### Slide 27:

- smaller is better
- will explain what cases are in a moment

#### Slide 34:

- what might seem the same to you isn’t necessarily to V8

#### Slide 36:

- ensure consistent objects via classes

#### Slide 37:

##### Presenter Notes:
- less anti patterns aka you are holding it wrong
- now can handle exceptions where it makes sense as try/catch/finally no longer ruins the
  performance of a function
- file a bug report if you discover a bottleneck
- polymorphic functions are fine as well (depends on how crazy you are about performance)
