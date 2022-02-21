void CleanScreen(unsigned int color)
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

    unsigned int mib = kernel_32_bits_end;
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
        modeInfoBlockFramebuffer[i] = color;
    }
}