Bits 16

    jmp KERNEL

    %include "sources/kernel_header.asm"

KERNEL:

    org ADDRESS_kernel

    mov ax, cs
    mov ds, ax

    mov ah, 0x0e
    mov al, 'N'
    int 0x10
    cli
    hlt

times 512-($-$$) db 0 ; Limit the size of the file as needed