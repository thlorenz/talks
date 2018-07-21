## Function::Bind

- [related PR](https://bugs.chromium.org/p/v8/issues/detail?id=6946)
  - [diff](https://chromium.googlesource.com/v8/v8/+/594803c94671fa19db1420f2b43023b75264e101%5E%21/#F0)
- [related files in chromium search](https://cs.chromium.org/search/?q=kJSCreateBoundFunction&sq=package:chromium&type=cs)


```sh
➝  nave use 4 node -p 'process.versions'
{ http_parser: '2.8.0',
  node: '4.9.1',
  v8: '4.5.103.53',
  uv: '1.9.1',
  zlib: '1.2.11',
  ares: '1.10.1-DEV',
  icu: '56.1',
  modules: '46',
  openssl: '1.0.2o' }
```

```sh
➝  nave use 6 node -p 'process.versions'
{ http_parser: '2.8.0',
  node: '6.14.3',
  v8: '5.1.281.111',
  uv: '1.16.1',
  zlib: '1.2.11',
  ares: '1.10.1-DEV',
  icu: '58.2',
  modules: '48',
  napi: '3',
  openssl: '1.0.2o' }


➝  nave use 8 node -p 'process.versions'
{ http_parser: '2.8.0',
  node: '8.11.3',
  v8: '6.2.414.54',
  uv: '1.19.1',
  zlib: '1.2.11',
  ares: '1.10.1-DEV',
  modules: '57',
  nghttp2: '1.32.0',
  napi: '3',
  openssl: '1.0.2o',
  icu: '60.1',
  unicode: '10.0',
  cldr: '32.0',
  tz: '2017c' }
```

- build `branch-heads/5.1` on OSX 😞
- build `branch-heads/5.2` on OSX 😢
- build `branch-heads/5.3` on OSX 😭
- build `branch-heads/5.4 ... 5.7` on OSX 😿
- build `branch-heads/5.8` on OSX 🙃
