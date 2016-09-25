;
; A simple boot sector that prints strings using my print function.
;
[org 0x7c00]

  mov bx, HELLO_MESSAGE
  call print_string

  mov bx, GOODBYE_MESSAGE
  call print_string

  jmp $

%include "print_string.asm"

; Data
HELLO_MESSAGE:
  db 'Hello, world!', 0

GOODBYE_MESSAGE:
  db 'Goodbye, youbble!', 0

; Padding and magic BIOS number.
times 510-($-$$) db 0   ; Pad the boot sector out with zeros
dw 0xaa55               ; Last two bytes form the magic number,
                        ; so BIOS knows we are a boot sector.