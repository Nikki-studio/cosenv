ASM = nasm # assembler
source = src/bootloader.asm #source
target = build/bootloader.img # bootloader

.PHONY:all $(target) clean always

all: $(target)

$(target): $(source)
	$(ASM) $(source) -f bin -o $(target)
	

always:
	mkdir -p $(build_directory)

clean:
	rm -rf $(build_directory)
