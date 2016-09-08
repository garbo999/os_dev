; DX = 16-bit string to print
; HEX_OUT = label of memory location where ascii will be stored

print_hex:
  pusha
  mov bx, HEX_OUT + 5   ; initialize BX to point to correct (last) location for saving ascii
  mov cx, 4             ; loop counter
   
  ; manipulate string at HEX_OUT to reflect DX

  loop_start:
    mov al, dl
    and al, 0x0f ; get lowest digit only

    ; if al < 10 = digit between 0 and 9
    cmp al, 10
    jl less_than_ten

    ; else al >= 10 = letter between A and F
    add al, 0x40
    sub al, 9
    jmp done

    less_than_ten:
      add al, 0x30
      jmp done

    done:
      ;mov al, 0x41 ; for TESTING
      mov [bx], al

    shr dx, 4
    dec bx
    loop loop_start

    mov bx, HEX_OUT ; now use BX as pointer to start of hex string in ascii
    call print_string

  popa
  ret

