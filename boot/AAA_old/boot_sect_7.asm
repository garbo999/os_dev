;
; A simple boot sector program that prints a 16-bit value in hex.
;
[org 0x7c00]

  mov dx, 0x1fb6 ; number to print
  call print_hex  

  jmp $

%include "print_string.asm"

print_hex:
  ; input parameter = 16-bit number in DX
  pusha
  mov bx, HEX_OUT ; use initially BX as pointer for saving ascii char to correct location

    done:
      mov al, 0x41
      mov [HEX_OUT+3], al

    mov bx, HEX_OUT ; now use BX as pointer to hex string in ascii
    call print_string

  popa
  ret

; Global variable
HEX_OUT:
  db '0x0000', 0

; Padding and magic BIOS number.
times 510-($-$$) db 0   ; Pad the boot sector out with zeros
dw 0xaa55               ; Last two bytes form the magic number,
                        ; so BIOS knows we are a boot sector.