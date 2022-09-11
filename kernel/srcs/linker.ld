ENTRY(_start)

OUTPUT_ARCH(i386:i386)
OUTPUT_FORMAT(elf32-i386)

SECTIONS
{
    . = 1M;

    .text BLOCK(4k) : ALIGN(4k)
    {
        *(.multiboot)
        *(.text)
    }

    .rodata BLOCK(4k) : ALIGN(4k)
    {
        *(.rodata)
    }

    .data BLOCK(4k) : ALIGN(4k)
    {
        start_ctors = .;
        KEEP(*( .init_array ));
        KEEP(*(SORT_BY_INIT_PRIORITY(.init_array)));
        end_ctors = .;
        *(.data)
    }

    .bss BLOCK(4k) : ALIGN(4k)
    {
        *(COMMON)
        *(.bss)
    }

    /DISCARD/ :
    {
      *(.fini_array*)
      *(.comment)
    }
}
