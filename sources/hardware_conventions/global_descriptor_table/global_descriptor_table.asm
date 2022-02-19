gdt_start:

.nullDescriptor:

dd 0x0
dd 0x0

.codeSegmentBlock:

dw 0xffff
dw 0x0
db 0x0
db 10011010b
db 11001111b
db 0x0

.dataSegmentBlock:

dw 0xffff
dw 0x0
db 0x0
db 10010010b
db 11001111b
db 0x0

gdt_end:

gdt_pointer:
dw gdt_end - gdt_start - 1
dd gdt_start

gdt_code_segment: equ gdt_start.codeSegmentBlock - gdt_start
gdt_data_segment: equ gdt_start.dataSegmentBlock - gdt_start