;
; A simple boot sector program that prints a 16-bit value in hex.
;
[org 0x7c00]

  mov dx, 0x1fb6 ; number to print
  mov dx, 0xbcde ; number to print
  mov dx, 0x3b9f ; number to print
  call print_hex  

  jmp $

%include "print_string.asm"
%include "print_hex.asm"

; Global variable
HEX_OUT:
  db '0x0000', 0

; Padding and magic BIOS number.
times 510-($-$$) db 0   ; Pad the boot sector out with zeros
dw 0xaa55               ; Last two bytes form the magic number,
                        ; so BIOS knows we are a boot sector.