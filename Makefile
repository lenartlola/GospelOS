BOOT_SRC_DIR = src/boot
KERNEL_SRC_DIR = src/kernel
SRC = src

BUILD_DIR = build
OBJS_DIR = build/objs

CFLAGS = -m32 -std=gnu99 -fno-use-cxa-atexit -nostdlib -fno-builtin -fno-rtti -fno-exceptions -fno-leading-underscore -ffreestanding -O2 -Wall -Wextra
AFLAGS = --32
LFLAGS = -m elf_i386 -nostdlib

OBJS = boot.o
SRC_OBJS = kernel.o init_screen_vga.o print_text_vga.o utils_vga.o

all: build install

build:
	mkdir -p build

$(BUILD_DIR)/%.o: $(BOOT_SRC_DIR)/%.S
	as $(AFLAGS) -o $@ $<

$(BUILD_DIR)/%.o: $(KERNEL_SRC_DIR)/%.c
	echo "BUILD SRC"
	gcc -I includes/ $(CFLAGS) -o $@ -c $<

nixity.bin: $(SRC)/linker.ld $(BUILD_DIR)/boot.o $(BUILD_DIR)/kernel.o
	ld $(LFLAGS) -T $< -o $@ $(BUILD_DIR)/boot.o $(BUILD_DIR)/kernel.o

install: nixity.bin iso
	grub-file --is-x86-multiboot $<

iso:
	mkdir -p iso
	mkdir -p iso/boot
	mkdir -p iso/boot/grub
	cp nixity.bin iso/boot/
	cp src/grub.cfg iso/boot/grub/
	grub-mkrescue -o nixity.iso iso/

run:
	qemu-system-x86_64 -cdrom nixity.iso

debug:
	qemu-system-x86_64 -S -cdrom nixity.iso -gdb tcp::1234

#	sudo cp $< /boot/nixity.bin

clean:
	rm -rf build

fclean: clean
	rm -rf nixity.bin
	rm -rf iso
	rm -rf nixity.iso

re: fclean all iso
