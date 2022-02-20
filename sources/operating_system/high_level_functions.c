void Validate_C_Entry()
{
    /* If it halts without changing the screen then success. */
    __asm__("hlt");
    return;
}