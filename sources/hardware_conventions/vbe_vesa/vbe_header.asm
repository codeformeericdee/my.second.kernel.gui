ADDRESS_display_rates:

    .width: dw 1920
    .height: dw 1080
    .bpp: db 32
    .offset: dw 0
    .t_segment: dw 0
    .mode: dw 0

ADDRESS_vbe_info_block:

    .vbe_signature: db 'VBE2'
    .vbe_version: dw 0
    .oem_string_pointer: dd 0 
    .capabilities: dd 0
    .video_mode_pointer: dd 0
    .total_memory: dw 0
    .oem_software_rev: dw 0
    .oem_vendor_name_pointer: dd 0
    .oem_product_name_pointer: dd 0
    .oem_product_revision_pointer: dd 0
    .reserved: times 222 db 0
    .oem_data: times 256 db 0

ADDRESS_mode_info_block:

    .mode_attributes: dw 0
    .window_a_attributes: db 0
    .window_b_attributes: db 0
    .window_granularity: dw 0
    .window_size: dw 0
    .window_a_segment: dw 0
    .window_b_segment: dw 0
    .window_function_pointer: dd 0
    .bytes_per_scanline: dw 0

    .x_resolution: dw 0
    .y_resolution: dw 0
    .x_charsize: db 0
    .y_charsize: db 0
    .number_of_planes: db 0
    .bits_per_pixel: db 0
    .number_of_banks: db 0
    .memory_model: db 0
    .bank_size: db 0
    .number_of_image_pages: db 0
    .reserved1: db 1

    .red_mask_size: db 0
    .red_field_position: db 0
    .green_mask_size: db 0
    .green_field_position: db 0
    .blue_mask_size: db 0
    .blue_field_position: db 0
    .reserved_mask_size: db 0
    .reserved_field_position: db 0
    .direct_color_mode_info: db 0

    .physical_base_pointer: dd 0
    .reserved2: dd 0
    .reserved3: dw 0

    .linear_bytes_per_scan_line: dw 0
    .bank_number_of_image_pages: db 0
    .linear_number_of_image_pages: db 0
    .linear_red_mask_size: db 0
    .linear_red_field_position: db 0
    .linear_green_mask_size: db 0
    .linear_green_field_position: db 0
    .linear_blue_mask_size: db 0
    .linear_blue_field_position: db 0
    .linear_reserved_mask_size: db 0
    .linear_reserved_field_position: db 0
    .max_pixel_clock: dd 0

    .reserved4: times 190 db 0