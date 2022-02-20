; Disk functions for kernel bootloader written by Eric Dee.

if_sector1_loads:
    db 'Sector 1 was loaded with success.', 0xa, 0xd, 255

if_sector1_load_fails:
    db 'An undisclosed disk read error prevented the bootloader from being loaded into memory.', 0xa, 0xd, 255

if_sector2_loads:
    db 'Sector 2 was loaded with success.', 0xa, 0xd, 255

if_sector2_load_fails:
    db 'An undisclosed disk read error prevented the kernel from being loaded into memory.', 0xa, 0xd, 255

disk_place_sector1_into_memory:

    pusha

    mov dh, 0 ; Head
    mov dl, 0 ; Drive

    mov ch, 0 ; Track/Cylinder
    mov cl, 1 ; Sector

    ; Block function: places zero into the extra segment register then sets the segment offset to the magic number address (0x7c0)
    xor bx, bx ; First reference
    mov es, bx ; Readable segment
    mov bx, ADDRESS_bootable ; Offset

    mov ah, 2  ; Read disk argument
    mov al, 1  ; Amount of sectors to be read
    int 19
    jnc .exit
    mov si, if_sector1_load_fails
call display_si
    cli
    hlt

    .exit:
    mov si, if_sector1_loads
call display_si
    popa
    ret

disk_place_sector2_into_memory:

    pusha

    mov dh, 0 ; Head
    mov dl, 0 ; Drive

    mov ch, 0 ; Track/Cylinder
    mov cl, 2 ; Sector

    ; Note that this sets a ceiling reliant on the kernel address. If the kernel is longer than the address, disk loading will fail
    xor bx, bx ; First reference
    mov es, bx ; Readable segment
    mov bx, ADDRESS_kernel ; Offset

    mov ah, 2  ; Read disk argument
    mov al, 3  ; Amount of sectors to be read
    int 19
    jnc .exit
    mov si, if_sector2_load_fails
call display_si
    cli
    hlt

    .exit:
    mov si, if_sector2_loads
call display_si
    popa
    ret