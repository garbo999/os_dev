;
; Read some sectors from boot disk using our disk_read function.
;
[org 0x7c00]

  mov [BOOT_DRIVE], dl    ; save boot drive for later

  mov bp, 0x8000          ; set stack safely out of way
  mov sp, bp              

  mov ax, 0               ; set ES = 0x0000
  mov es, ax

  mov bx, 0x9000          ; load 5 sectors to 0x0000(ES):0x9000(BX)
  mov dh, 5               
  mov dl, [BOOT_DRIVE]
  call disk_load

  mov dx, [0x9000]
  call print_hex          ; should print 0xDADA from start of 1st sector

  mov dx, [0x9000 + 512]
  call print_hex          ; should print 0xDADA from start of 2nd sector

  mov dx, [0x9000 + 512 + 512]
  call print_hex

  mov dx, [0x9000 + 512 + 512 + 512]
  call print_hex

  mov dx, [0x9000 + 512 + 512 + 512 + 512]
  call print_hex
    
  jmp $

%include "print_hex.asm"
%include "print_string.asm"
%include "disk_load.asm"

; Global variables
BOOT_DRIVE: db 0
HEX_OUT: db '0x0000', 0

; Boot sector padding
times 510-($-$$) db 0
dw 0xaa55

; Some data so we can check if our two additional sectors were loaded from boot disk
times 256 dw 0xdada
times 256 dw 0xface
times 256 dw 0x1212
times 256 dw 0x1e1e
times 256 dw 0x3434
