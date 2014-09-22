## What Is a Node.js Addon?

- any library that needs to access C/C++ functionality

## What Is a Node.js Addon?

- Node.js itself works like an addon
- ???

## Looking at Node.js

- embedds v8 to *run* JavaScript
- calls out to **libuv** to handle system calls
- additional libraries used for other tasks, i.e. **http-parser**

## fs module

- `/lib/fs.js` *binds* `/src/file.cc`

## fs module

```js
// fs.js
var binding = process.binding('fs');
```

## fs module

```cc
void InitFs(Handle<Object> target,
            Handle<Value> unused,
            Handle<Context> context,
            void* priv) {

  NODE_SET_METHOD(target, "close", Close);
  NODE_SET_METHOD(target, "open", Open);
  // ...
  NODE_SET_METHOD(target, "readdir", ReadDir);
}
NODE_MODULE_CONTEXT_AWARE_BUILTIN(fs, node::InitFs)
```

## fs module

- allows creating 'fs' object in JavaScript land with methods like `readdir`
- calling `fs.readdir` calls C++ `ReadDir` passing along JS parameters in `args` array

## fs module

```js
fs.readdir = function(path, callback) {
  callback = makeCallback(callback);
  if (!nullCheck(path, callback)) return;
  binding.readdir(pathModule._makeLong(path), callback);
};
```

## fs module

```cc
static void ReadDir(const FunctionCallbackInfo<Value>& args) {
  HandleScope scope(env->isolate());

  // ...

  node::Utf8Value path(args[0]);

  if (args[1]->IsFunction()) {
    ASYNC_CALL(readdir, args[1], *path, 0 /*flags*/)
  } else {
    SYNC_CALL(readdir, *path, *path, 0 /*flags*/)

    // ...

    args.GetReturnValue().Set(names);
  }
}
```

## readdirSync

```cc
#define SYNC_DEST_CALL(func, path, dest, ...)                                 \
  fs_req_wrap req_wrap;                                                       \
  int err = uv_fs_ ## func(env->event_loop(),                                 \
                         &req_wrap.req,                                       \
                         __VA_ARGS__,                                         \
                         NULL);                                               \
  if (err < 0) {                                                              \
    if (dest != NULL &&                                                       \
        (err == UV_EEXIST ||                                                  \
         err == UV_ENOTEMPTY ||                                               \
         err == UV_EPERM)) {                                                  \
      return env->ThrowUVException(err, #func, "", dest);                     \
    } else {                                                                  \
      return env->ThrowUVException(err, #func, "", path);                     \
    }                                                                         \
  }
```


## readdirSync

```cc
SYNC_DEST_CALL(path, dest)
  fs_req_wrap req_wrap;

  int err = uv_fs_readdir(env->event_loop(), &req_wrap.req, NULL);

  if (err < 0) {
    if (dest != NULL &&
        (err == UV_EEXIST ||
         err == UV_ENOTEMPTY ||
         err == UV_EPERM)) {
      return env->ThrowUVException(err, readdir, "", dest);
    } else {
      return env->ThrowUVException(err, readdir, "", path);
    }
  }
```

## readdir (async)

```cc
#define ASYNC_DEST_CALL(func, callback, dest_path, ...)                       \
  Environment* env = Environment::GetCurrent(args.GetIsolate());              \
  FSReqWrap* req_wrap;                                                        \
  char* dest_str = (dest_path);                                               \
  int dest_len = dest_str == NULL ? 0 : strlen(dest_str);                     \
  char* storage = new char[sizeof(*req_wrap) + dest_len];                     \
  req_wrap = new(storage) FSReqWrap(env, #func);                              \
  req_wrap->dest_len(dest_len);                                               \
  if (dest_str != NULL) {                                                     \
    memcpy(const_cast<char*>(req_wrap->dest()),                               \
           dest_str,                                                          \
           dest_len + 1);                                                     \
  }                                                                           \
  int err = uv_fs_ ## func(env->event_loop() ,                                \
                           &req_wrap->req_,                                   \
                           __VA_ARGS__,                                       \
                           After);                                            \
  req_wrap->object()->Set(env->oncomplete_string(), callback);                \
  req_wrap->Dispatched();                                                     \
  if (err < 0) {                                                              \
    uv_fs_t* req = &req_wrap->req_;                                           \
    req->result = err;                                                        \
    req->path = NULL;                                                         \
    After(req);                                                               \
  }                                                                           \
  args.GetReturnValue().Set(req_wrap->persistent());
```

## readdir (async)

```cc
ASYNC_DEST_CALL(readdir, callback, dest_path, ...)
  Environment* env = Environment::GetCurrent(args.GetIsolate());
  FSReqWrap* req_wrap;
  char* dest_str = (dest_path);
  int dest_len = dest_str == NULL ? 0 : strlen(dest_str);
  char* storage = new char[sizeof(*req_wrap) + dest_len];
  req_wrap = new(storage) FSReqWrap(env, readdir);
  req_wrap->dest_len(dest_len);
  if (dest_str != NULL)
    memcpy(const_cast<char*>(req_wrap->dest()), dest_str, dest_len + 1);

  int err = uv_fs_readdir(env->event_loop() , &req_wrap->req_, After);

  req_wrap->object()->Set(env->oncomplete_string(), callback);
  req_wrap->Dispatched();
  if (err < 0) {
    uv_fs_t* req = &req_wrap->req_;
    req->result = err;
    req->path = NULL;
    After(req);
  }
  args.GetReturnValue().Set(req_wrap->persistent());
```

## readdir

```
fs.readdir()
  -> binding.readdir()
  -> Fs.ReadDir()
  -> uv_fs_readdir()
```

## Addons

- basically same thing except not part of Node.js

## node-gyp

- cross-platform command-line tool written in Node.js for compiling native addon modules for Node.js
- bundles the [gyp](https://code.google.com/p/gyp/) project 
- produces `myaddon.node` file to be included via JavaScript

## gyp

- **G**enerate **Y**our **P**roject
- similar goal as Cmake, Autoconf, etc.
- specifies sources, flags, etc. for different architectures
- used to produce `Makefile`

## gyp

```json
  'variables': {
    'v8_use_snapshot%': 'true',
    'node_use_dtrace%': 'false',
    'library_files': [
      'src/node.js',
      'lib/_debugger.js',
    ],
  },

  'targets': [
    {
      'target_name': 'node',
      'type': 'executable',

      'include_dirs': [
        'src',
      ],

      'sources': [
        'src/node_file.cc',
        'src/node_http_parser.cc',
        'common.gypi',
      ]
       ...

      [ 'node_shared_libuv=="false"', {
        'dependencies': [ 'deps/uv/uv.gyp:libuv' ],
      }],
    }
  ]
```

## binding.gyp

```json
{
  "targets": [
    { 
      'target_name': 'simple',
      'sources': [ 
          './src/simple.cc',
          './simple.js',
        ],
        'include_dirs': [
          '<!(node -e "require(\'nan\')")',
      ],
    }
  ]
}
```

## node-gyp

- dealing with two projects
  - Node.js
  - your addon

## node-gyp

- harder to integrate into IDE
- need to start Node.js for our addon and attach debugger
- cannot easily explore code base (including Node.js)

## nad

- your addon **is** like a Node.js module
- nad makes it part of Node.js during development

## nad

DEMO

## nad existing projects

- integration based on `binding.gyp`
- works out of the box with most projects
- minor tweaks to make it work with others

## nad leveldb

- demo
