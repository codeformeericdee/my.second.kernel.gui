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
%include "sources/hardware_conventions/vbe_vesa/vbe_header.asm"
%include "sources/hardware_conventions/vbe_vesa/vbe-vesa.asm"

if_ds_works:
    db 'The kernel data segment was loaded properly.', 0xa, 0xd, 255

KERNEL:

    org ADDRESS_kernel

    mov ax, cs
    mov ds, ax
    mov si, if_ds_works
call display_si

call enable_vbe_vesa

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

; Note: It would be a good practice to calculate the end of the 16 bit kernel. Not a priority

bits 32

PROTECTED_32_BIT_MODE:

    mov ax, gdt_data_segment
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
    mov ebp, 0x90000
    mov esp, ebp

    .kernel:

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ; Calculate the kernel end location, and store it for reference later
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    xor eax, eax
    mov eax, [ADDRESS_kernel] 
    add eax, VALUE_kernel_size

    kernel_32_bits_calculated_end:
        dw 0
    mov [kernel_32_bits_calculated_end], eax
    kernel_32_bits_end: equ kernel_32_bits_calculated_end
    xor eax, eax

    ; Sending a struct of mode info block type to an address that won't conflict with the kernel

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ; Give RAM a reference to the mode info block to manipulate as live data
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    mov esi, ADDRESS_mode_info_block ; mib is treated as a template. In C it would be the equivalent to a struct. Add a label reference, and it would be a class
    mov edi, [kernel_32_bits_end]
    mov ecx, 64                      ; As the mib is 256 bytes long, dividing by 64 generates 4 double words
    rep movsd                        ; Repeats move from esi to edi in "chunks" using ecx as the argument

    pusha
    mov edx, [kernel_32_bits_end]
    add edx, 40
    mov edi, [edx]
    mov ecx, 1920*1080   ; ARGB (8888 bits per 32 bytes)
    mov eax, 12344444h   ; Pixel color
    rep stosd
    popa

    cli
    hlt

times VALUE_kernel_size-($-$$) db 0 ; Limit the size of the file as needed