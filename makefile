# Makefile for building operating system assemblies written by Eric Dee

# NOTE: Should auto generate primary directories

builds_directory = builds
sources_directory = sources

bootloader_directory = bootloader
bootloader_source_name = boot
booloader_output_name = bootloader
bootloader_sources_directory = $(sources_directory)/$(bootloader_directory)
bootloader_build_directory = $(builds_directory)/$(bootloader_directory)

operating_system_directory = operating_system
operating_system_source_name = kernel
kernel_output_name = kernel
operating_system_output_name = operating_system
operating_system_sources_directory = $(sources_directory)/$(operating_system_directory)
operating_system_build_directory = $(builds_directory)/$(operating_system_directory)

c_source_name = high_level_functions
clang_flags = -c -O0 -std=c17 -ffreestanding -march=i386 -m32 -fno-builtin -nostdinc

application_directory = application

all:
	nasm $(bootloader_sources_directory)/$(bootloader_source_name).asm -o $(bootloader_build_directory)/$(booloader_output_name).bin
	make build_the_operating_system

build_the_operating_system: $(operating_system_source_name) $(c_source_name)
	ld -m elf_i386 -T high_level_functions.ld
	cat $(bootloader_build_directory)/$(booloader_output_name).bin $(operating_system_build_directory)/$(kernel_output_name).bin > $(application_directory)/$(operating_system_output_name).flp

$(operating_system_source_name):
	nasm $(operating_system_sources_directory)/$@.asm -f elf32 -o $(operating_system_build_directory)/$@.o

$(c_source_name):
	clang $(clang_flags) $(operating_system_sources_directory)/$@.c -o $(operating_system_build_directory)/$@.o
