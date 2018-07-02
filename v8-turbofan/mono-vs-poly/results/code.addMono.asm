--- Raw source ---
(a, b) {
  return a + b
}


--- Optimized code ---
optimization_id = 0
source_position = 16
kind = OPTIMIZED_FUNCTION
name = addMono
stack_slots = 4
compiler = turbofan
address = 0xece89fc4781
Body (size = 231)
Instructions (size = 208)
                  -- Prologue: check code start register --
0xece89fc47e0     0  488d1df9ffffff REX.W leaq rbx,[rip+0xfffffff9]
0xece89fc47e7     7  483bd9         REX.W cmpq rbx,rcx
0xece89fc47ea     a  7410           jz 0xece89fc47fc  <+0x1c>
                  Abort message: 
                  Wrong value in code start register passed
0xece89fc47ec     c  48ba000000003b000000 REX.W movq rdx,0x3b00000000
0xece89fc47f6    16  e8c5deefff     call 0xece89ec26c0  (Abort)    ;; code: BUILTIN
0xece89fc47fb    1b  cc             int3l
                  -- Prologue: check for deoptimization --
0xece89fc47fc    1c  488b59c8       REX.W movq rbx,[rcx-0x38]
0xece89fc4800    20  f6430f01       testb [rbx+0xf],0x1
0xece89fc4804    24  0f85b697edff   jnz 0xece89e9dfc0  (CompileLazyDeoptimizedCode)    ;; code: BUILTIN
                  -- Prologue: generate speculation poison --
0xece89fc480a    2a  488d1df9ffffff REX.W leaq rbx,[rip+0xfffffff9]
0xece89fc4811    31  4883eb2a       REX.W subq rbx,0x2a
0xece89fc4815    35  49c7c100000000 REX.W movq r9,0x0
0xece89fc481c    3c  483bcb         REX.W cmpq rcx,rbx
0xece89fc481f    3f  48c7c3ffffffff REX.W movq rbx,0xffffffff
0xece89fc4826    46  4c0f44cb       REX.W cmovzq r9,rbx
0xece89fc482a    4a  4923f9         REX.W andq rdi,r9
0xece89fc482d    4d  4923f1         REX.W andq rsi,r9
0xece89fc4830    50  4923e1         REX.W andq rsp,r9
                  -- B0 start (construct frame) --
0xece89fc4833    53  55             push rbp
0xece89fc4834    54  4889e5         REX.W movq rbp,rsp
0xece89fc4837    57  56             push rsi
0xece89fc4838    58  57             push rdi
0xece89fc4839    59  493ba5300f0000 REX.W cmpq rsp,[r13+0xf30]
0xece89fc4840    60  0f863d000000   jna 0xece89fc4883  <+0xa3>
                  -- B2 start --
                  -- B3 start (deconstruct frame) --
0xece89fc4846    66  488b4518       REX.W movq rax,[rbp+0x18]
0xece89fc484a    6a  a801           test al,0x1
0xece89fc484c    6c  0f8549000000   jnz 0xece89fc489b  <+0xbb>
0xece89fc4852    72  488b5d10       REX.W movq rbx,[rbp+0x10]
0xece89fc4856    76  f6c301         testb rbx,0x1
0xece89fc4859    79  0f8541000000   jnz 0xece89fc48a0  <+0xc0>
0xece89fc485f    7f  488bd3         REX.W movq rdx,rbx
0xece89fc4862    82  48c1ea20       REX.W shrq rdx, 32
0xece89fc4866    86  488bc8         REX.W movq rcx,rax
0xece89fc4869    89  48c1e920       REX.W shrq rcx, 32
0xece89fc486d    8d  03d1           addl rdx,rcx
0xece89fc486f    8f  0f8030000000   jo 0xece89fc48a5  <+0xc5>
0xece89fc4875    95  48c1e220       REX.W shlq rdx, 32
0xece89fc4879    99  488bc2         REX.W movq rax,rdx
0xece89fc487c    9c  488be5         REX.W movq rsp,rbp
0xece89fc487f    9f  5d             pop rbp
0xece89fc4880    a0  c21800         ret 0x18
                  -- B4 start (no frame) --
                  -- B1 start (deferred) --
                  -- <not inlined:16> --
0xece89fc4883    a3  48bbb0c71b0b01000000 REX.W movq rbx,0x10b1bc7b0    ;; external reference (Runtime::StackGuard)
0xece89fc488d    ad  33c0           xorl rax,rax
0xece89fc488f    af  488b75f8       REX.W movq rsi,[rbp-0x8]
0xece89fc4893    b3  e888faebff     call 0xece89e84320       ;; code: STUB, CEntryStub, minor: 8
0xece89fc4898    b8  ebac           jmp 0xece89fc4846  <+0x66>
0xece89fc489a    ba  90             nop
0xece89fc489b    bb  e8c0f70300     call 0xece8a004060       ;; deoptimization bailout 0
0xece89fc48a0    c0  e8c0f70300     call 0xece8a004065       ;; deoptimization bailout 1
0xece89fc48a5    c5  e8c0f70300     call 0xece8a00406a       ;; deoptimization bailout 2
0xece89fc48aa    ca  e8c0f70b00     call 0xece8a08406f       ;; lazy deoptimization bailout 3
0xece89fc48af    cf  90             nop
                  ;;; Safepoint table.

Source positions:
 pc offset  position
        a3        16

Inlined functions (count = 0)

Deoptimization Input Data (deopt points = 4)
 index  bytecode-offset    pc
     0                0    NA 
     1                0    NA 
     2                0    NA 
     3                0    b8 

Safepoints (size = 23)
0xece89fc4898      b8    ca  0000 (sp -> fp)       3

RelocInfo (size = 133)
0xece89fc47e0  comment  (-- Prologue: check code start register --)
0xece89fc47ec  comment  (Abort message: )
0xece89fc47ec  comment  (Wrong value in code start register passed)
0xece89fc47f7  code target (BUILTIN Abort)  (0xece89ec26c0)
0xece89fc47fc  comment  (-- Prologue: check for deoptimization --)
0xece89fc4806  code target (BUILTIN CompileLazyDeoptimizedCode)  (0xece89e9dfc0)
0xece89fc480a  comment  (-- Prologue: generate speculation poison --)
0xece89fc4833  comment  (-- B0 start (construct frame) --)
0xece89fc4846  comment  (-- B2 start --)
0xece89fc4846  comment  (-- B3 start (deconstruct frame) --)
0xece89fc4883  comment  (-- B4 start (no frame) --)
0xece89fc4883  comment  (-- B1 start (deferred) --)
0xece89fc4883  comment  (-- <not inlined:16> --)
0xece89fc4885  external reference (Runtime::StackGuard)  (0x10b1bc7b0)
0xece89fc4894  code target (STUB CEntryStub)  (0xece89e84320)
0xece89fc489c  runtime entry  (deoptimization bailout 0)
0xece89fc48a1  runtime entry  (deoptimization bailout 1)
0xece89fc48a6  runtime entry  (deoptimization bailout 2)
0xece89fc48ab  runtime entry
0xece89fc48b0  comment  (;;; Safepoint table.)

--- End code ---
