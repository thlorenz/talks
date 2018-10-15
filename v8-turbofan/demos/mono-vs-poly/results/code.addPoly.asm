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
address = 0x1f10ba7c4781
Body (size = 198)
Instructions (size = 160)
                  -- Prologue: check code start register --
0x1f10ba7c47e0     0  488d1df9ffffff REX.W leaq rbx,[rip+0xfffffff9]
0x1f10ba7c47e7     7  483bd9         REX.W cmpq rbx,rcx
0x1f10ba7c47ea     a  7410           jz 0x1f10ba7c47fc  <+0x1c>
                  Abort message: 
                  Wrong value in code start register passed
0x1f10ba7c47ec     c  48ba000000003b000000 REX.W movq rdx,0x3b00000000
0x1f10ba7c47f6    16  e8c5deefff     call 0x1f10ba6c26c0  (Abort)    ;; code: BUILTIN
0x1f10ba7c47fb    1b  cc             int3l
                  -- Prologue: check for deoptimization --
0x1f10ba7c47fc    1c  488b59c8       REX.W movq rbx,[rcx-0x38]
0x1f10ba7c4800    20  f6430f01       testb [rbx+0xf],0x1
0x1f10ba7c4804    24  0f85b697edff   jnz 0x1f10ba69dfc0  (CompileLazyDeoptimizedCode)    ;; code: BUILTIN
                  -- Prologue: generate speculation poison --
0x1f10ba7c480a    2a  488d1df9ffffff REX.W leaq rbx,[rip+0xfffffff9]
0x1f10ba7c4811    31  4883eb2a       REX.W subq rbx,0x2a
0x1f10ba7c4815    35  49c7c100000000 REX.W movq r9,0x0
0x1f10ba7c481c    3c  483bcb         REX.W cmpq rcx,rbx
0x1f10ba7c481f    3f  48c7c3ffffffff REX.W movq rbx,0xffffffff
0x1f10ba7c4826    46  4c0f44cb       REX.W cmovzq r9,rbx
0x1f10ba7c482a    4a  4923f9         REX.W andq rdi,r9
0x1f10ba7c482d    4d  4923f1         REX.W andq rsi,r9
0x1f10ba7c4830    50  4923e1         REX.W andq rsp,r9
                  -- B0 start (construct frame) --
0x1f10ba7c4833    53  55             push rbp
0x1f10ba7c4834    54  4889e5         REX.W movq rbp,rsp
0x1f10ba7c4837    57  56             push rsi
0x1f10ba7c4838    58  57             push rdi
0x1f10ba7c4839    59  493ba5300f0000 REX.W cmpq rsp,[r13+0xf30]
0x1f10ba7c4840    60  0f8618000000   jna 0x1f10ba7c485e  <+0x7e>
                  -- B2 start --
                  -- B3 start (deconstruct frame) --
                  -- <not inlined:79> --
0x1f10ba7c4846    66  488b5518       REX.W movq rdx,[rbp+0x18]
0x1f10ba7c484a    6a  488b4510       REX.W movq rax,[rbp+0x10]
0x1f10ba7c484e    6e  488b75f8       REX.W movq rsi,[rbp-0x8]
0x1f10ba7c4852    72  e809daf2ff     call 0x1f10ba6f2260  (Add)    ;; code: BUILTIN
0x1f10ba7c4857    77  488be5         REX.W movq rsp,rbp
0x1f10ba7c485a    7a  5d             pop rbp
0x1f10ba7c485b    7b  c21800         ret 0x18
                  -- B4 start (no frame) --
                  -- B1 start (deferred) --
                  -- <not inlined:59> --
0x1f10ba7c485e    7e  48bbb0b75b0f01000000 REX.W movq rbx,0x10f5bb7b0    ;; external reference (Runtime::StackGuard)
0x1f10ba7c4868    88  33c0           xorl rax,rax
0x1f10ba7c486a    8a  488b75f8       REX.W movq rsi,[rbp-0x8]
0x1f10ba7c486e    8e  e8adfaebff     call 0x1f10ba684320     ;; code: STUB, CEntryStub, minor: 8
0x1f10ba7c4873    93  ebd1           jmp 0x1f10ba7c4846  <+0x66>
0x1f10ba7c4875    95  90             nop
0x1f10ba7c4876    96  e8e5f70b00     call 0x1f10ba884060     ;; lazy deoptimization bailout 0
0x1f10ba7c487b    9b  e8e5f70b00     call 0x1f10ba884065     ;; lazy deoptimization bailout 1
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
0x1f10ba7c4857      77    96  0000 (sp -> fp)       0
0x1f10ba7c4873      93    9b  0000 (sp -> fp)       1

RelocInfo (size = 140)
0x1f10ba7c47e0  comment  (-- Prologue: check code start register --)
0x1f10ba7c47ec  comment  (Abort message: )
0x1f10ba7c47ec  comment  (Wrong value in code start register passed)
0x1f10ba7c47f7  code target (BUILTIN Abort)  (0x1f10ba6c26c0)
0x1f10ba7c47fc  comment  (-- Prologue: check for deoptimization --)
0x1f10ba7c4806  code target (BUILTIN CompileLazyDeoptimizedCode)  (0x1f10ba69dfc0)
0x1f10ba7c480a  comment  (-- Prologue: generate speculation poison --)
0x1f10ba7c4833  comment  (-- B0 start (construct frame) --)
0x1f10ba7c4846  comment  (-- B2 start --)
0x1f10ba7c4846  comment  (-- B3 start (deconstruct frame) --)
0x1f10ba7c4846  comment  (-- <not inlined:79> --)
0x1f10ba7c4853  code target (BUILTIN Add)  (0x1f10ba6f2260)
0x1f10ba7c485e  comment  (-- B4 start (no frame) --)
0x1f10ba7c485e  comment  (-- B1 start (deferred) --)
0x1f10ba7c485e  comment  (-- <not inlined:59> --)
0x1f10ba7c4860  external reference (Runtime::StackGuard)  (0x10f5bb7b0)
0x1f10ba7c486f  code target (STUB CEntryStub)  (0x1f10ba684320)
0x1f10ba7c4877  runtime entry
0x1f10ba7c487c  runtime entry
0x1f10ba7c4880  comment  (;;; Safepoint table.)

--- End code ---
