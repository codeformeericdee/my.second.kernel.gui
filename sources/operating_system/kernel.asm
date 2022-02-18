; Kernel for easy entry into coding and building operating systems writen by Eric Dee
; Any questions, please see the numerous other repositories I wrote myself while leading up to and preparing this project
; Stay tuned to this repository for continued updates
; https://github.com/AllComputerScience/

; Naming convention:
; All route type labels that tend to be static are UPPERCASE_LABELED
; All external calls/method declarations are lowercase_labeled
; All local loops are .camelCaseLabeled
; All headers denote type then description as UPPERCASE_lowercase_labeled

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