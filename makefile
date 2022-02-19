# Makefile for building an operating system assemblies.

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
operating_system_output_name = operating_system
operating_system_sources_directory = $(sources_directory)/$(operating_system_directory)
operating_system_build_directory = $(builds_directory)/$(operating_system_directory)

application_directory = application

all:
	nasm $(bootloader_sources_directory)/$(bootloader_source_name).asm -o $(bootloader_build_directory)/$(booloader_output_name).bin
	make build_the_operating_system

build_the_operating_system: $(operating_system_source_name)

$(operating_system_source_name):
	nasm $(operating_system_sources_directory)/$@.asm -o $(operating_system_build_directory)/$@.bin
	cat $(bootloader_build_directory)/$(booloader_output_name).bin $(operating_system_build_directory)/$@.bin > $(application_directory)/$(operating_system_output_name).flp