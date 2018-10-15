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
address = 0x3d3001e44781
Body (size = 231)
Instructions (size = 208)
                  -- Prologue: check code start register --
0x3d3001e447e0     0  488d1df9ffffff REX.W leaq rbx,[rip+0xfffffff9]
0x3d3001e447e7     7  483bd9         REX.W cmpq rbx,rcx
0x3d3001e447ea     a  7410           jz 0x3d3001e447fc  <+0x1c>
                  Abort message: 
                  Wrong value in code start register passed
0x3d3001e447ec     c  48ba000000003b000000 REX.W movq rdx,0x3b00000000
0x3d3001e447f6    16  e8c5deefff     call 0x3d3001d426c0  (Abort)    ;; code: BUILTIN
0x3d3001e447fb    1b  cc             int3l
                  -- Prologue: check for deoptimization --
0x3d3001e447fc    1c  488b59c8       REX.W movq rbx,[rcx-0x38]
0x3d3001e44800    20  f6430f01       testb [rbx+0xf],0x1
0x3d3001e44804    24  0f85b697edff   jnz 0x3d3001d1dfc0  (CompileLazyDeoptimizedCode)    ;; code: BUILTIN
                  -- Prologue: generate speculation poison --
0x3d3001e4480a    2a  488d1df9ffffff REX.W leaq rbx,[rip+0xfffffff9]
0x3d3001e44811    31  4883eb2a       REX.W subq rbx,0x2a
0x3d3001e44815    35  49c7c100000000 REX.W movq r9,0x0
0x3d3001e4481c    3c  483bcb         REX.W cmpq rcx,rbx
0x3d3001e4481f    3f  48c7c3ffffffff REX.W movq rbx,0xffffffff
0x3d3001e44826    46  4c0f44cb       REX.W cmovzq r9,rbx
0x3d3001e4482a    4a  4923f9         REX.W andq rdi,r9
0x3d3001e4482d    4d  4923f1         REX.W andq rsi,r9
0x3d3001e44830    50  4923e1         REX.W andq rsp,r9
                  -- B0 start (construct frame) --
0x3d3001e44833    53  55             push rbp
0x3d3001e44834    54  4889e5         REX.W movq rbp,rsp
0x3d3001e44837    57  56             push rsi
0x3d3001e44838    58  57             push rdi
0x3d3001e44839    59  493ba5300f0000 REX.W cmpq rsp,[r13+0xf30]
0x3d3001e44840    60  0f863d000000   jna 0x3d3001e44883  <+0xa3>
                  -- B2 start --
                  -- B3 start (deconstruct frame) --
0x3d3001e44846    66  488b4518       REX.W movq rax,[rbp+0x18]
0x3d3001e4484a    6a  a801           test al,0x1
0x3d3001e4484c    6c  0f8549000000   jnz 0x3d3001e4489b  <+0xbb>
0x3d3001e44852    72  488b5d10       REX.W movq rbx,[rbp+0x10]
0x3d3001e44856    76  f6c301         testb rbx,0x1
0x3d3001e44859    79  0f8541000000   jnz 0x3d3001e448a0  <+0xc0>
0x3d3001e4485f    7f  488bd3         REX.W movq rdx,rbx
0x3d3001e44862    82  48c1ea20       REX.W shrq rdx, 32
0x3d3001e44866    86  488bc8         REX.W movq rcx,rax
0x3d3001e44869    89  48c1e920       REX.W shrq rcx, 32
0x3d3001e4486d    8d  03d1           addl rdx,rcx
0x3d3001e4486f    8f  0f8030000000   jo 0x3d3001e448a5  <+0xc5>
0x3d3001e44875    95  48c1e220       REX.W shlq rdx, 32
0x3d3001e44879    99  488bc2         REX.W movq rax,rdx
0x3d3001e4487c    9c  488be5         REX.W movq rsp,rbp
0x3d3001e4487f    9f  5d             pop rbp
0x3d3001e44880    a0  c21800         ret 0x18
                  -- B4 start (no frame) --
                  -- B1 start (deferred) --
                  -- <not inlined:16> --
0x3d3001e44883    a3  48bbb0f7af0201000000 REX.W movq rbx,0x102aff7b0    ;; external reference (Runtime::StackGuard)
0x3d3001e4488d    ad  33c0           xorl rax,rax
0x3d3001e4488f    af  488b75f8       REX.W movq rsi,[rbp-0x8]
0x3d3001e44893    b3  e888faebff     call 0x3d3001d04320     ;; code: STUB, CEntryStub, minor: 8
0x3d3001e44898    b8  ebac           jmp 0x3d3001e44846  <+0x66>
0x3d3001e4489a    ba  90             nop
0x3d3001e4489b    bb  e8c0f70300     call 0x3d3001e84060     ;; deoptimization bailout 0
0x3d3001e448a0    c0  e8c0f70300     call 0x3d3001e84065     ;; deoptimization bailout 1
0x3d3001e448a5    c5  e8c0f70300     call 0x3d3001e8406a     ;; deoptimization bailout 2
0x3d3001e448aa    ca  e8c0f70b00     call 0x3d3001f0406f     ;; lazy deoptimization bailout 3
0x3d3001e448af    cf  90             nop
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
0x3d3001e44898      b8    ca  0000 (sp -> fp)       3

RelocInfo (size = 133)
0x3d3001e447e0  comment  (-- Prologue: check code start register --)
0x3d3001e447ec  comment  (Abort message: )
0x3d3001e447ec  comment  (Wrong value in code start register passed)
0x3d3001e447f7  code target (BUILTIN Abort)  (0x3d3001d426c0)
0x3d3001e447fc  comment  (-- Prologue: check for deoptimization --)
0x3d3001e44806  code target (BUILTIN CompileLazyDeoptimizedCode)  (0x3d3001d1dfc0)
0x3d3001e4480a  comment  (-- Prologue: generate speculation poison --)
0x3d3001e44833  comment  (-- B0 start (construct frame) --)
0x3d3001e44846  comment  (-- B2 start --)
0x3d3001e44846  comment  (-- B3 start (deconstruct frame) --)
0x3d3001e44883  comment  (-- B4 start (no frame) --)
0x3d3001e44883  comment  (-- B1 start (deferred) --)
0x3d3001e44883  comment  (-- <not inlined:16> --)
0x3d3001e44885  external reference (Runtime::StackGuard)  (0x102aff7b0)
0x3d3001e44894  code target (STUB CEntryStub)  (0x3d3001d04320)
0x3d3001e4489c  runtime entry  (deoptimization bailout 0)
0x3d3001e448a1  runtime entry  (deoptimization bailout 1)
0x3d3001e448a6  runtime entry  (deoptimization bailout 2)
0x3d3001e448ab  runtime entry
0x3d3001e448b0  comment  (;;; Safepoint table.)

--- End code ---
