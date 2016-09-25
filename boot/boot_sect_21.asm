; Boot sector to boot our C kernel in 32-bit protected mode
[org 0x7c00]
KERNEL_OFFSET equ 0x1000  ; memory offset for loading kernel

  mov [BOOT_DRIVE], dl    ; BIOS stores our boot drive in DL so remember for later

  mov bp, 0x9000          ; prepare stack
  mov sp, bp

  mov bx, MSG_REAL_MODE   ; announce boot in 16-bit real mode
  call print_string

  call load_kernel        ; load kernel

  call switch_to_pm       ; switch to protected mode (whence no return)

  jmp $

; Include our important routines
%include "boot/print_string.asm"
%include "boot/print_string_pm.asm"
%include "boot/disk_load.asm"
%include "boot/gdt.asm"
%include "boot/switch_to_pm.asm"

[bits 16]

; Load kernel
load_kernel:
  mov bx, MSG_LOAD_KERNEL ; print message to say we are loading kernel
  call print_string

  mov bx, KERNEL_OFFSET   ; prepare to load from disk
  mov dh, 15              ; load 1st 15 sectors
  mov dl, [BOOT_DRIVE]    ; from boot disk
  call disk_load

  ret

[bits 32]
; point of arrival after switching to and initialising protected mode
BEGIN_PM:
  
  mov ebx, MSG_PROT_MODE  ; announced protected mode with 32-bit routine
  call print_string_pm

  call KERNEL_OFFSET      ; jump to address of loaded kernel

  jmp $                   ; hang

; global variables
BOOT_DRIVE db 0
MSG_REAL_MODE db "Started in 16-bit real mode", 0x0A, 0x0D, 0
MSG_PROT_MODE db "Successfully landed in 32-bit protected mode", 0
MSG_LOAD_KERNEL db "Loading kernel into memory", 0

; boot sector padding
times 510-($-$$) db 0
dw 0xaa55
