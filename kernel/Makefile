DEFAULT_HOST = i686-elf
HOST ?= DEFAULT_HOST
HOST_ARCH = i386

BOOT_SRC_DIR = src/boot
KERNEL_SRC_DIR = src/kernel
SRC = src

BUILD_DIR = build
OBJS_DIR = build/objs

CFLAGS = -m32 -std=gnu99 -fno-use-cxa-atexit -nostdlib -fno-builtin -fno-rtti -fno-exceptions -fno-leading-underscore -ffreestanding -O2 -Wall -Wextra
CPPFLAGS := $(CPPFLAGS) -D__is_kernel -Iincs
AFLAGS = --32
LFLAGS = -m elf_i386 -nostdlib

DESTDIR ?=
PREFIX ?= /usr/local
EXEC_PREFIX ?= $(PREFIX)
BOOTDIR ?= $(EXEC_PREFIX)/boot
INCLUDEDIR ?= $(PREFIX)/incs

ARCHDIR = arch/i386

include $(ARCHDIR)/make.config

CFLAGS := $(CFLAGS) $(KERNEL_ARCH_CFLAGS)
CPPFLAGS := $(CPPFLAGS) $(KERNEL_ARCH_CPPFLAGS)
LDFLAGS := $(LDFLAGS) $(KERNEL_ARCH_LDFLAGS)
LIBS := $(LIBS) $(KERNEL_ARCH_LIBS)

KERNEL_OBJS = $(KERNEL_ARCH_OBJS) srcs/kernel.o

OBJS = $(ARCHDIR)/init_screen_vga.o $(ARCHDIR)/print_text_vga.o \
	$(ARCHDIR)/utils_vga.o $(KERNEL_OBJS) \

LINK_LIST = $(LDFLAGS) $(ARCHDIR)/init_screen_vga.o $(ARCHDIR)/print_text_vga.o \
	$(KERNEL_OBJS) $(LIBS) $(ARCHDIR)/utils_vga.o

.PHONY: all clean install install-headers install-kernel
.SUFFIXES: .o .c .S

all: gospel.kernel

gospel.kernel: $(OBJS) $(ARCHDIR)/linker.ld
	$(CC) -T $(ARCHDIR)/linker.ld -o $@ $(CFLAGS) $(LINK_LIST)
	grub-file --is-x86-multiboot gospel.kernel

$(ARCHDIR)/init_screen_vga.o $(ARCHDIR)/print_text_vga.o $(ARCHDIR)/utils_vga.o:
	OBJ=`$(CC) $(CFLAGS) $(LDFLAGS) -print-file-name=$(@F)` && cp "$$OBJ" $@

.c.o:
	$(CC) -MD -c $< -o $@ -std=gnu11 $(CFLAGS) $(CPPFLAGS)


.S.o:
	$(CC) -MD -c $< -o $@ $(CFLAGS) $(CPPFLAGS)


build:
	mkdir -p build

$(BUILD_DIR)/%.o: $(BOOT_SRC_DIR)/%.S
	as $(AFLAGS) -o $@ $<

$(BUILD_DIR)/%.o: $(KERNEL_SRC_DIR)/%.c
	echo "BUILD SRC"
	gcc -I includes/ $(CFLAGS) -o $@ -c $<

nixity.bin: $(SRC)/linker.ld $(BUILD_DIR)/boot.o $(BUILD_DIR)/kernel.o
	ld $(LFLAGS) -T $< -o $@ $(BUILD_DIR)/boot.o $(BUILD_DIR)/kernel.o

install: install-headers install-kernel

install-headers:
	mkdir -p $(DESTDIR)$(INCLUDEDIR)
	cp -R --preserve=timestamps incs/. $(DESTDIR)$(INCLUDEDIR)/.

install-kernel: myos.kernel
	mkdir -p $(DESTDIR)$(BOOTDIR)
	cp myos.kernel $(DESTDIR)$(BOOTDIR)

-include $(OBJS:.o=.d)

run:
	qemu-system-x86_64 -cdrom nixity.iso

debug:
	qemu-system-x86_64 -S -cdrom nixity.iso -gdb tcp::1234

clean:
	rm -rf gospel.kernel
	rm -f $(OBJS) *.o */*.o */*/*.o
	rm -f $(OBJS:.o=.d) *.d */*.d */*/*.d


fclean: clean
	rm -rf nixity.bin
	rm -rf iso
	rm -rf nixity.iso

re: fclean all iso
