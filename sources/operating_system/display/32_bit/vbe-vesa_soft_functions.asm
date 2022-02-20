; vbe/vesa functions Written by Eric Dee

vbe_clean_screen_for_end_of_process:

    pusha
    mov edx, [kernel_32_bits_end]
    add edx, 40
    mov edi, [edx]
    mov ecx, 1920*1080   ; ARGB (8888 bits per 32 bytes)
    mov eax, 44444444h   ; Pixel color
    rep stosd
    popa
    ret