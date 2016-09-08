print_string:
  ; input parameter = string at memory location in BX
  pusha
  mov ah, 0x0e ; int 10/ ah = 0eh -> scrolling teletype BIOS routine

  print_start:
    mov al, [bx]
    cmp al, 0
    je done_printing
    int 0x10
    inc bx
    jmp print_start

  done_printing:
    popa
    ret
