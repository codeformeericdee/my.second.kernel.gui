; Sector calculator written by Eric Dee

%include "sources/operating_system/kernel_header.asm"

calculate_kernel_sector_count:
    pusha
    mov ax, VALUE_kernel_size
    mov cx, 512
    xor dx, dx ; Clear this or there are division errors
    div cx

    kernel_calculated_sector_count:
        dw 0
    mov [kernel_calculated_sector_count], ax
    kernel_sector_count: equ kernel_calculated_sector_count
    popa
    ret