print_hex:
  ; input parameter = 16-bit number in DX
  pusha
  mov bx, HEX_OUT + 5      ; use initially BX as pointer for saving ascii char to correct location
                        ; note: start from last digit
  mov cx, 4             ; loop counter
   
  ; manipulate string at HEX_OUT to reflect DX
  loop_start:
    mov al, dl
    and al, 0x0f ; get lowest digit only

    ; if al < 10
    cmp al, 10
    jl less_than_ten
    ; else al >= 10
    add al, 0x40
    sub al, 9
    jmp done

    less_than_ten:
      add al, 0x30
      jmp done

    done:
      ;mov al, 0x41
      mov [bx], al

    shr dx, 4
    dec bx
    loop loop_start

    mov bx, HEX_OUT ; now use BX as pointer to hex string in ascii
    call print_string

  popa
  ret

