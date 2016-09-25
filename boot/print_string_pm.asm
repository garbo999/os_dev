[bits 32]

; define constants
VIDEO_MEMORY equ 0xb8000
WHITE_ON_BLACK equ 0x0f
GREEN_MONOCHROME equ 0x2a

; print null-terminated string pointed to by EBX

print_string_pm:
  pusha
  mov edx, VIDEO_MEMORY     ; EDX points to start of video memory

print_string_pm_loop:
  mov al, [ebx]             ; EBX points to null-terminated string
  mov ah, GREEN_MONOCHROME

  cmp al, 0
  je print_string_pm_done

  mov [edx], ax
  add ebx, 1              ; increment EBX to next char in string
  add edx, 2              ; increment EDX to next word in video memory

  jmp print_string_pm_loop

print_string_pm_done:
  popa
  ret