[org 0x7c00]

;
; A simple boot sector that demonstrates addressing.
;
mov ah, 0x0e ; int 10/ ah = 0eh -> scrolling teletype BIOS routine

; First attempt
mov al,'1'
int 0x10

mov al, the_secret
int 0x10

; Second attempt
mov al,'2'
int 0x10

mov al, [the_secret]
int 0x10

; Third attempt
mov al,'3'
int 0x10

mov bx, the_secret
add bx, 0x7c00
mov al, [bx]
int 0x10

; Fourth attempt
mov al,'4'
int 0x10

mov al, [0x7c2d]
int 0x10

jmp $ ; Jump to the current address ( i.e. forever ).

the_secret:
  db "X"

; Padding and magic BIOS number.

times 510-($-$$) db 0   ; Pad the boot sector out with zeros
dw 0xaa55               ; Last two bytes form the magic number,
                        ; so BIOS knows we are a boot sector.