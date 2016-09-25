[bits 16]
; switch to protected mode
switch_to_pm:
  
  cli               ; switch off interrupts until we prepare protected mode interrupt vector

  lgdt [gdt_descriptor]

  mov eax, cr0      ; set 1st bit of CR0 control register
  or eax, 0x1       ; to switch to protected mode
  mov cr0, eax

  jmp CODE_SEG:init_pm  ; make far jump to our 32-bit code
                        ; this also forces CPU to flush cache of prefetched
                        ; and real-mode decode instructions (avoiding chaos)

[bits 32]
; initialize registers and stack once in PM
init_pm:

  mov ax, DATA_SEG      ; in PM our old segments are meaningless,
  mov ds, ax            ; so load all segments anew
  mov ss, ax  
  mov es, ax  
  mov fs, ax  
  mov gs, ax  

  mov ebp, 0x90000      ; place stack at top of free space
  mov esp, ebp

  call BEGIN_PM