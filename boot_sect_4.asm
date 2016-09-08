;
; A simple boot sector that demonstrates the stack.
;
mov ah, 0x0e ; int 10/ ah = 0eh -> scrolling teletype BIOS routine

mov bp, 0x8000
mov sp, bp

push 'A'
push 'B'
push 'C'

;pop bx
;mov al, bl
;int 0x10

;pop bx
;mov al, bl
;int 0x10

mov al, [0x7ffe]
int 0x10

mov al, [0x7ffc]
int 0x10

mov al, [0x7ffa]
int 0x10

jmp $ ; Jump to the current address ( i.e. forever ).

; Padding and magic BIOS number.
times 510-($-$$) db 0   ; Pad the boot sector out with zeros
dw 0xaa55               ; Last two bytes form the magic number,
                        ; so BIOS knows we are a boot sector.