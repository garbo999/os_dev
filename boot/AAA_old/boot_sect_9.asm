;
; A simple boot sector program that demonstrates segment offsetting.
;

  mov ah, 0x0e  ; scrolling teletype BIOS routine

  mov al, '1'
  int 0x10              ; 1st try --> fails because 'the_secret' is not offset
  mov al, [the_secret]
  int 0x10

  mov al, '2'
  int 0x10              ; 2nd try --> works with correct offset
  mov bx, 0x7c0
  mov ds, bx
  mov al, [the_secret]
  int 0x10

  mov al, '3'
  int 0x10              ; 3rd try --> fails because no offset yet in ES
  mov al, [es:the_secret]
  int 0x10

  mov al, '4'
  int 0x10              ; 4th try --> works with correct offset
  mov bx, 0x7c0
  mov es, bx
  mov al, [es:the_secret]
  int 0x10

  jmp $

; Global variable
the_secret:
  db 'X'

; Padding and magic BIOS number.
times 510-($-$$) db 0   ; Pad the boot sector out with zeros
dw 0xaa55               ; Last two bytes form the magic number,
                        ; so BIOS knows we are a boot sector.