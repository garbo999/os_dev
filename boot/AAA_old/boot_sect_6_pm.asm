;
; A simple boot sector that prints strings using my print function.
;
; THIS DOESN"T WORK BECAUSE IT CALLS ROUTINE THAT RUNS IN PROTECTED MODE
;

[org 0x7c00]

  mov bx, HELLO_MESSAGE
  call print_string_pm

  ;mov bx, GOODBYE_MESSAGE
  ;call print_string_pm

  jmp $

%include "print_string_pm.asm"

; Data
HELLO_MESSAGE:
  db 'Hello, world!', 0

GOODBYE_MESSAGE:
  db 'Goodbye, youbble in protected mode!', 0

; Padding and magic BIOS number.
times 510-($-$$) db 0   ; Pad the boot sector out with zeros
dw 0xaa55               ; Last two bytes form the magic number,
                        ; so BIOS knows we are a boot sector.