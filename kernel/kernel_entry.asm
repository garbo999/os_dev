; Ensures we jump direct to kernel entry function
[bits 32]
[extern main]   ; Declare reference to external symbol "main"
                ; so linker can substitute final address

  call main     ; Invoke main() in C kernel
  jmp $         ; Hang forever upon return from kernel
