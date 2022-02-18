# Makefile for building an operating system assemblies.

# NOTE: Should auto generate primary directories

bootloader_directory = bootloader
bootloader_source_name = boot
booloader_output_name = bootloader

builds_directory = builds
bootloader_build_directory = $(builds_directory)/$(bootloader_directory)

sources_directory = sources
bootloader_sources_directory = $(sources_directory)/$(bootloader_directory)

all:
	nasm $(bootloader_sources_directory)/$(bootloader_source_name).asm -o $(bootloader_build_directory)/$(booloader_output_name).bin