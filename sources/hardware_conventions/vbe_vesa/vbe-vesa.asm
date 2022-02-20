enable_vbe_vesa:

    xor ax, ax
    mov es, ax
    mov ah, 4Fh
    mov di, ADDRESS_vbe_info_block
    int 10h
    cmp ax, 4Fh
    jnz .error
    mov ax, word [ADDRESS_vbe_info_block.video_mode_pointer]
    mov [ADDRESS_display_rates.offset], ax
    mov ax, word [ADDRESS_vbe_info_block.video_mode_pointer+2]
    mov [ADDRESS_display_rates.t_segment], ax
    mov fs, ax
    mov si, [ADDRESS_display_rates.offset]
    
    .findMode:
    mov dx, [fs:si]
    inc si
    inc si
    mov [ADDRESS_display_rates.offset], si
    mov [ADDRESS_display_rates.mode], dx
    cmp dx, word 0FFFFh
    jz .endOfModes
    mov ax, 4F01h
    mov cx, [ADDRESS_display_rates.mode]
    mov di, ADDRESS_mode_info_block
    int 10h
    cmp ax, 4Fh
    jnz .error

    .checkIfCompatible:
    mov ax, [ADDRESS_display_rates.width]
    cmp ax, [ADDRESS_mode_info_block.x_resolution]
    jnz .checkNextMode
    mov ax, [ADDRESS_display_rates.height]
    cmp ax, [ADDRESS_mode_info_block.y_resolution]
    jnz .checkNextMode
    mov ax, [ADDRESS_display_rates.bpp]
    cmp al, [ADDRESS_mode_info_block.bits_per_pixel]
    jnz .checkNextMode

    .ifCompatible:
    mov ax, 4F02h
    mov bx, [ADDRESS_display_rates.mode]
    or bx, 4000h
    xor di, di
    int 10h
    cmp ax, 4Fh
    jnz .error
    jmp .success

    .success:
    ret

    .error:
    mov ax, 0E45h
    int 10h
    cli
    hlt

    .checkNextMode:
    mov ax, [ADDRESS_display_rates.t_segment]
    mov fs, ax
    mov si, [ADDRESS_display_rates.offset]
    jmp .findMode
    
    .endOfModes:
    mov ax, 0E65h
    int 10h
    cli
    hlt