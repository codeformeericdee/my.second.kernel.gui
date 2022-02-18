; Display methods for BIOS interrupts written by Eric Dee

display_add_spaces_by_dx_value:

    pusha
    xor cx, cx
    mov ah, 0x0e
    
    .printLoop:
    cmp cx, dx
    jz .exit
    mov al, 10 ; 0xa, \n, line feed
    int 16
    mov al, 13 ; 0xd, \r, carraige return
    int 16
    inc cx
    jmp .printLoop

    .exit:
    popa
    ret

display_si:

    pusha
    mov ah, 0x0e
    .printLoop:
    cmp byte [si], 255
    jz .exit
    mov al, [si]
    int 16
    inc si
    jmp .printLoop

    .exit:
    popa
    ret