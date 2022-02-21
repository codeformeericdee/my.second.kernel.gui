/* Operating system for easy entry into coding and building operating systems writen by Eric Dee
* Any questions, please see the numerous other repositories I wrote myself while leading up to and preparing this project
* Stay tuned to this repository for continued updates
* https://github.com/AllComputerScience/ */

// Naming convention:
// All methods are in UppercaseCamelCase
// All BSS values are Uppercase_Name_BSS labeled
// All local variables are lowercaseCamelCase
// All labels are denoted by an underscore preceding the _labelName, any non local label should be a method

// Note that these differ from the assembly conventions defined in the kernel and bootloader, as they aim to loosley follow common high level practices

#define Confirmed_BSS 1

void ConfirmLocation()
{
    // Settings to test general functionality of all things leading
    if (Confirmed_BSS == 1)
    {
        goto _locationConfirmed;
    }
    else
    {
        /* Will be expanded upon at some point. */
        __asm__("hlt");
    }
    _locationConfirmed:
    return;
}

void ValidateCEntry()
{
    /* If it halts without changing the screen then success. */
    __asm__("call ConfirmLocation");
    return;
}

void EntryPointTestingGrounds()
{
    // extern void kernel_32_bits_end(void); - This worked well with hardcoded values

    extern unsigned int kernel_32_bits_end;

    /* Example of adding to the mib
    unsigned int mib = 0x10000;
    unsigned int mib_40;

    __asm__("mov %1, %0\n\t"
    "add $40, %0"
    :"=r" (mib_40)
    : "r" (mib));
    */

    unsigned int mib = (unsigned int)kernel_32_bits_end;
    unsigned int mib_40;

    __asm__("mov %1, %0\n\t"
    "add $40, %0"
    :"=r" (mib_40)
    : "r" (mib));

    // For some reason I can't figure out, higher level addition doesn't work well with asm defines.
    // The above needs to be inline in order to properly calculate the address

    unsigned int* modeInfoBlockFramebuffer = (unsigned int*)*(unsigned int*)mib_40;
    
    for (unsigned int i = 0; i < 1920*1080; i++)
    {
        modeInfoBlockFramebuffer[i] = 0x12344444;
    }

    __asm__("hlt");
    return;
}