; load DH sectors to ES:BX from drive DL
disk_load:
  push dx           ; save DX = sectors to be read
  mov ah, 0x02      ; BIOS read sector function
  mov al, dh        ; read DH cylinders
  mov ch, 0x00      ; select cylinder 0
  mov dh, 0x00      ; select head 0
  mov cl, 0x02      ; start reading from second sector (i.e. after boot sector)
  int 0x13          ; BIOS interrupt

  jc disk_error_1     ; jump if error (carry flag set)

  pop dx            ; restore DX from stack
  cmp dh, al        ; if AL (sectors read) != DH (sectors expected)
  jne disk_error_2    ; display error message
  ret

disk_error_1:
  mov bx, DISK_ERROR_MSG_1
  call print_string
  jmp $             ; this seems odd (infinite loop here -- move to main program?)

disk_error_2:
  mov bx, DISK_ERROR_MSG_2
  call print_string
  jmp $             ; this seems odd (infinite loop here -- move to main program?)

; variables
DISK_ERROR_MSG_1  db "Disk read error 1!", 0
DISK_ERROR_MSG_2  db "Disk read error 2!", 0
