;
; A boot sector program that enters 32-bit protected mode.
;
[org 0x7c00]

  mov bp, 0x9000          ; set stack safely out of way
  mov sp, bp              

  mov bx, MSG_REAL_MODE
  call print_string

  call switch_to_pm       ; note that we will never return here

  jmp $

%include "print_string.asm"
%include "print_string_pm.asm"
%include "gdt.asm"
%include "switch_to_pm.asm"

[bits 32]
; this is where we arriving after switching to and initializing protected mode
BEGIN_PM:

  mov ebx, MSG_PROT_MODE
  call print_string_pm    ; use our 32-bit routine

  jmp $                   ; hang

; Global variables
MSG_REAL_MODE db "Started in 16-bit real mode", 0
MSG_PROT_MODE db "Successfully landed in 32-bit protected mode", 0

; Boot sector padding
times 510-($-$$) db 0
dw 0xaa55