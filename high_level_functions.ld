ENTRY(ValidateCEntry)
INPUT(builds/operating_system/kernel.o builds/operating_system/high_level_functions.o)
OUTPUT(builds/operating_system/kernel.bin)
OUTPUT_FORMAT(binary)

SECTIONS
{

    . = 0x5100;

    .text :
    {
        *(.text*);
    }

    .bss :
    {
        *(.bss*);
    }

    .rodata :
    {
        *(.rodata*);
    }

    .data :
    {
        *(.data*);
    }

}