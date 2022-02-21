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
    __asm__("call ConfirmLocation");

    return;
}

#include "display/32_bit/pixel_plots.c"

void EntryPointTestingGrounds()
{

    CleanScreen(0x12344444);

    __asm__("hlt");

    return;
}