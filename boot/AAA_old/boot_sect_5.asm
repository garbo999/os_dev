;
; A simple boot sector to test comparisons and jumps.
;

mov bx, 40

; if bx <= 4
cmp bx, 4
jle first_branch

; elseif bx < 40
cmp bx, 40
jl second_branch

; else
mov al, 'C'
jmp the_end

first_branch:
  mov al, 'A'
  jmp the_end
second_branch:
  mov al, 'B'
the_end:

mov ah, 0x0e ; int 10/ ah = 0eh -> scrolling teletype BIOS routine
int 0x10

jmp $ ; Jump to the current address ( i.e. forever ).

; Padding and magic BIOS number.
times 510-($-$$) db 0   ; Pad the boot sector out with zeros
dw 0xaa55               ; Last two bytes form the magic number,
                        ; so BIOS knows we are a boot sector.