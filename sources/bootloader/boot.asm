; Bootloader for easy entry into coding and building operating systems writen by Eric Dee
; Any questions, please see the numerous other repositories I wrote myself while leading up to and preparing this project
; Stay tuned to this repository for continued updates
; https://github.com/AllComputerScience/

; Naming convention:
; All route type labels that tend to be static are UPPERCASE_LABELED
; All external calls/method declarations are lowercase_labeled
; All local loops are .camelCaseLabeled
; All headers denote type then description as UPPERCASE_lowercase_labeled

bits 16

    jmp 0x7c0:BOOTLOADER ; This will increment the instruction pointer to pass the include code

%include "sources/bootloader/boot_header.asm"
%include "sources/bios_calls/display/interrupt_10h-16d.asm"
%include "sources/bios_calls/disk/interrupt_13h-19d.asm"
%include "sources/memory_tracking/header_calculators.asm"

if_boot_faults:
    db 'There was a boot error that could not be caught.', 0xa, 0xd, 255

BOOTLOADER:

    mov ax, ADDRESS_bootable
    mov ds, ax

call disk_place_sector1_into_memory
    jmp ADDRESS_bootable:BOOT_SECTOR

    .bootFault:
    mov si, if_boot_faults
call display_si
    cli
    hlt

BOOT_SECTOR:

call calculate_kernel_sector_count
call disk_place_sector2_into_memory
    jmp 0:ADDRESS_kernel

    .bootFault:
    mov si, if_boot_faults
call display_si
    cli
    hlt

times 510 - ($-$$) db 0
dw 0xaa55