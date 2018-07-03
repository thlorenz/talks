--- Raw source ---
(a, b) {
  return a + b
}


--- Optimized code ---
optimization_id = 1
source_position = 59
kind = OPTIMIZED_FUNCTION
name = addPoly
stack_slots = 4
compiler = turbofan
address = 0x22ada344781
Body (size = 198)
Instructions (size = 160)
                  -- Prologue: check code start register --
0x22ada3447e0     0  488d1df9ffffff REX.W leaq rbx,[rip+0xfffffff9]
0x22ada3447e7     7  483bd9         REX.W cmpq rbx,rcx
0x22ada3447ea     a  7410           jz 0x22ada3447fc  <+0x1c>
                  Abort message: 
                  Wrong value in code start register passed
0x22ada3447ec     c  48ba000000003b000000 REX.W movq rdx,0x3b00000000
0x22ada3447f6    16  e8c5deefff     call 0x22ada2426c0  (Abort)    ;; code: BUILTIN
0x22ada3447fb    1b  cc             int3l
                  -- Prologue: check for deoptimization --
0x22ada3447fc    1c  488b59c8       REX.W movq rbx,[rcx-0x38]
0x22ada344800    20  f6430f01       testb [rbx+0xf],0x1
0x22ada344804    24  0f85b697edff   jnz 0x22ada21dfc0  (CompileLazyDeoptimizedCode)    ;; code: BUILTIN
                  -- Prologue: generate speculation poison --
0x22ada34480a    2a  488d1df9ffffff REX.W leaq rbx,[rip+0xfffffff9]
0x22ada344811    31  4883eb2a       REX.W subq rbx,0x2a
0x22ada344815    35  49c7c100000000 REX.W movq r9,0x0
0x22ada34481c    3c  483bcb         REX.W cmpq rcx,rbx
0x22ada34481f    3f  48c7c3ffffffff REX.W movq rbx,0xffffffff
0x22ada344826    46  4c0f44cb       REX.W cmovzq r9,rbx
0x22ada34482a    4a  4923f9         REX.W andq rdi,r9
0x22ada34482d    4d  4923f1         REX.W andq rsi,r9
0x22ada344830    50  4923e1         REX.W andq rsp,r9
                  -- B0 start (construct frame) --
0x22ada344833    53  55             push rbp
0x22ada344834    54  4889e5         REX.W movq rbp,rsp
0x22ada344837    57  56             push rsi
0x22ada344838    58  57             push rdi
0x22ada344839    59  493ba5300f0000 REX.W cmpq rsp,[r13+0xf30]
0x22ada344840    60  0f8618000000   jna 0x22ada34485e  <+0x7e>
                  -- B2 start --
                  -- B3 start (deconstruct frame) --
                  -- <not inlined:79> --
0x22ada344846    66  488b5518       REX.W movq rdx,[rbp+0x18]
0x22ada34484a    6a  488b4510       REX.W movq rax,[rbp+0x10]
0x22ada34484e    6e  488b75f8       REX.W movq rsi,[rbp-0x8]
0x22ada344852    72  e809daf2ff     call 0x22ada272260  (Add)    ;; code: BUILTIN
0x22ada344857    77  488be5         REX.W movq rsp,rbp
0x22ada34485a    7a  5d             pop rbp
0x22ada34485b    7b  c21800         ret 0x18
                  -- B4 start (no frame) --
                  -- B1 start (deferred) --
                  -- <not inlined:59> --
0x22ada34485e    7e  48bbb057201001000000 REX.W movq rbx,0x1102057b0    ;; external reference (Runtime::StackGuard)
0x22ada344868    88  33c0           xorl rax,rax
0x22ada34486a    8a  488b75f8       REX.W movq rsi,[rbp-0x8]
0x22ada34486e    8e  e8adfaebff     call 0x22ada204320       ;; code: STUB, CEntryStub, minor: 8
0x22ada344873    93  ebd1           jmp 0x22ada344846  <+0x66>
0x22ada344875    95  90             nop
0x22ada344876    96  e8e5f70b00     call 0x22ada404060       ;; lazy deoptimization bailout 0
0x22ada34487b    9b  e8e5f70b00     call 0x22ada404065       ;; lazy deoptimization bailout 1
                  ;;; Safepoint table.

Source positions:
 pc offset  position
        66        79
        7e        59

Inlined functions (count = 0)

Deoptimization Input Data (deopt points = 2)
 index  bytecode-offset    pc
     0                3    77 
     1                0    93 

Safepoints (size = 38)
0x22ada344857      77    96  0000 (sp -> fp)       0
0x22ada344873      93    9b  0000 (sp -> fp)       1

RelocInfo (size = 140)
0x22ada3447e0  comment  (-- Prologue: check code start register --)
0x22ada3447ec  comment  (Abort message: )
0x22ada3447ec  comment  (Wrong value in code start register passed)
0x22ada3447f7  code target (BUILTIN Abort)  (0x22ada2426c0)
0x22ada3447fc  comment  (-- Prologue: check for deoptimization --)
0x22ada344806  code target (BUILTIN CompileLazyDeoptimizedCode)  (0x22ada21dfc0)
0x22ada34480a  comment  (-- Prologue: generate speculation poison --)
0x22ada344833  comment  (-- B0 start (construct frame) --)
0x22ada344846  comment  (-- B2 start --)
0x22ada344846  comment  (-- B3 start (deconstruct frame) --)
0x22ada344846  comment  (-- <not inlined:79> --)
0x22ada344853  code target (BUILTIN Add)  (0x22ada272260)
0x22ada34485e  comment  (-- B4 start (no frame) --)
0x22ada34485e  comment  (-- B1 start (deferred) --)
0x22ada34485e  comment  (-- <not inlined:59> --)
0x22ada344860  external reference (Runtime::StackGuard)  (0x1102057b0)
0x22ada34486f  code target (STUB CEntryStub)  (0x22ada204320)
0x22ada344877  runtime entry
0x22ada34487c  runtime entry
0x22ada344880  comment  (;;; Safepoint table.)

--- End code ---
