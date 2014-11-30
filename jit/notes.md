## Inspect Compiler Symbols

### symbols

```
symbols <executable>
```

- spits out symbols found inside which show mapping from hex address to function name and location in file

```
# address             size    symbol
0x000000000002a7d0 (    0x2f) v8::internal::Internals::GetRoot(v8::Isolate*, int) [FUNC, EXT, LENGTH, NameNList, MangledNameNList, Merged, NList, Dwarf]
                0x000000000002a7d0 (     0xb) v8.h:6219
                0x000000000002a7db (     0xf) v8.h:6220
                0x000000000002a7ea (    0x15) v8.h:6221
```

### dsymutil

```
dsymutil <executable>
```

- extracts symbols from executable and info from object files into a DWARF file inside a `.dSYM`

### dwarfdump

```
dwarfdump <executable|dwarf file>
```

- spits out symbols info in DWARF format including return type and parameter info with **DIE**s *Debugging
Information Entry* for each function

```
0x00000624:                 TAG_subprogram [6] *
                             AT_MIPS_linkage_name( "_ZN2v88internal9Internals7GetRootEPNS_7IsolateEi" )
                             AT_name( "GetRoot" )
                             AT_decl_file( "../../deps/v8/include/v8.h" )
                             AT_decl_line( 6218 )
                             AT_type( {0x00007602} ( Object** ) )
                             AT_declaration( 0x01 )
                             AT_external( 0x01 )
                             AT_accessibility( DW_ACCESS_public )

0x00000637:                     TAG_formal_parameter [8]  
                                 AT_type( {0x00007640} ( Isolate* ) )

0x0000063c:                     TAG_formal_parameter [8]  
                                 AT_type( {0x000075fb} ( int ) )

0x00000641:                     NULL

```

### atos

```
atos -o <executable|static lib|obj file> -printHeader <hexaddress>
```

- converts numeric addresses to symbols of binary images or processes

```
➝  atos  -o out/Debug/obj/src/node.uv.o 0x00000624
node::uv::Initialize(v8::Handle<v8::Object>, v8::Handle<v8::Value>, v8::Handle<v8::Context>) (in node.uv.o) (uv.cc:59)
```

## Flushing `perf-<pid>.map`

#### Apply v8 Patch

```patch
diff --git a/deps/v8/src/log.cc b/deps/v8/src/log.cc
index 0dcf6bb..4d9280c 100644
--- a/deps/v8/src/log.cc
+++ b/deps/v8/src/log.cc
@@ -291,6 +291,7 @@ void PerfBasicLogger::LogRecordedBuffer(Code* code,
   base::OS::FPrint(perf_output_handle_, "%llx %x %.*s\n",
                    reinterpret_cast<uint64_t>(code->instruction_start()),
                    code->instruction_size(), length, name);
+  fflush(perf_output_handle_);
 }

```

- most intrusive but easiest to work with once applied
- **guarantees all** *JIT* info is written **immediately**


### flush all

#### Create a `/flush` route

```js
var flushall = require('flush-all');

function onrequest(req, res) {
  if (req.url === '/flush') {
    flushall();
    res.writeHead(200);
    res.end();
  }
  [..]
}
```

- `curl` to `localhost:PORT/fulsh` to trigger flushing all buffers including `perf-<pid>.map`
- allows manual flush while process is running

#### Handle **SIGTERM**

```js
function onSIGTERM() {
  server.close();
  process.exit(0);
}

process.on('SIGTERM', onSIGTERM);
```

- intercept `SIGTERM` and ensure your server closes and process exits cleanly
- otherwise process exists without file ever being flushed
- optionally we may call `flushall` here as well but that is probably not needed
- disadvantage is that process has to exit to get map file
