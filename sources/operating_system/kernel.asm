; Kernel for easy entry into coding and building operating systems writen by Eric Dee
; Any questions, please see the numerous other repositories I wrote myself while leading up to and preparing this project
; Stay tuned to this repository for continued updates
; https://github.com/AllComputerScience/

; Naming convention:
; All route type labels that tend to be static are UPPERCASE_LABELED
; All external calls/method declarations are lowercase_labeled
; All local loops are .camelCaseLabeled
; All headers denote type then description as UPPERCASE_lowercase_labeled

bits 16

    jmp KERNEL

    %include "sources/operating_system/kernel_header.asm"
    %include "sources/hardware_conventions/global_descriptor_table/global_descriptor_table.asm"
    %include "sources/bios_calls/display/interrupt_10h-16d.asm"

if_ds_works:
    db 'The kernel data segment was loaded properly.', 0xa, 0xd, 255

KERNEL:

    org ADDRESS_kernel

    mov ax, cs
    mov ds, ax
    mov si, if_ds_works
call display_si

    .enableA20:
    in al, 0x92
    or al, 2
    out 0x92, al

    .referenceToGlobalDescriptorTable:
    cli
    lgdt[gdt_pointer]
    mov eax, cr0
    or eax, 1
    mov cr0, eax
    jmp gdt_code_segment:PROTECTED_32_BIT_MODE

bits 32

PROTECTED_32_BIT_MODE:

    mov ax, gdt_data_segment
    mov ds, ax
    mov ebp, 0x90000
    mov esp, ebp

    .kernel:
    mov byte [0x000b8000], '3'
    mov byte [0x000b8002], '2'
    mov byte [0x000b8004], ' '
    mov byte [0x000b8006], 'b'
    mov byte [0x000b8008], 'i'
    mov byte [0x000b800a], 't'
    mov byte [0x000b800c], 's'
    mov byte [0x000b800e], '.'
    cli
    hlt

times 512-($-$$) db 0 ; Limit the size of the file as needed