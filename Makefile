# Automatically generate lists of sources using wildcards
C_SOURCES = $(wildcard kernel/*.c drivers/*.c)
HEADERS = $(wildcard kernel/*.h drivers/*.h)

# TODO: Make sources dep on all header files

# Convert *.c filenames to *.o to give list of object files to build
OBJ = ${C_SOURCES:.c=.o}

# Default make target
all: os-image

# Run bochs to simulate booting of our code
run: all
	bochs

# Actual disk image that our computer loads,
# i.e. a combination of compiled boot sector and kernel
os-image: boot/boot_sector.bin kernel.bin
	cat $^ > os-image	

# Build the kernel binary from two object files
# - kernel_entry which jumps to main() in our kernel
# - compiled C kernel
# $^ is substituted with all of the target's dependency files
kernel.bin: kernel/kernel_entry.o ${OBJ}
	ld -o $@ -Ttext 0x1000 $^ --oformat binary

# Generic rule for compiling C code to an object file
# For simplicity, we C files depend on all header files
%.o: %.c ${HEADERS}
	gcc -ffreestanding -c $< -o $@

# Build the kernel entry object file
%.o: %.asm
	nasm $< -f elf -o $@

# Assemble boot sector to raw machine code
# -I options tell nasm where to find our included assembly routines
##### %.bin: %.asm
	#####nasm $< -f bin -o $@	

boot/boot_sector.bin: boot/boot_sect_21.asm
	# nasm $< -f bin -I ’../../16 bit/’ -o $@
	nasm $< -f bin -o $@	

clean:
	rm -fr *.bin *.dis *.o os-image
	rm -fr kernel/*.o boot/*.bin drivers/*.o

# Disassemble kernel -- can be useful for debugging
kernel.dis: kernel.bin
	ndisasm -b 32 $< > $@

# Print value of a variable:
# make print-VARIABLE
print-%  : ; @echo $* = $($*)
