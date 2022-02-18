; Bootloader for easy entry into coding and building operating systems writen by Eric Dee
; Any questions, please see the numerous other repositories I wrote myself while leading up to and preparing this project
; Stay tuned to this repository for continued updates
; https://github.com/AllComputerScience/

org 0x7c0

mov ah, 0x0e
mov al, 'H'
int 0x10
jmp $

times 510 - ($-$$) db 0
dw 0xaa55
