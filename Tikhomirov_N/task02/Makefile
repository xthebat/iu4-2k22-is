OUT_DIR := out
ASM := nasm
ASM_FLAGS := -fwin64

default:
	$(MAKE) all

prepare:
	mkdir -p out

build:
	$(ASM) $(ASM_FLAGS) strnlen.asm -o $(OUT_DIR)/strnlen.o
	$(ASM) $(ASM_FLAGS) strncpy.asm -o $(OUT_DIR)/strncpy.o
	$(ASM) $(ASM_FLAGS) chksum.asm -o $(OUT_DIR)/chksum.o

all:
	$(MAKE) build