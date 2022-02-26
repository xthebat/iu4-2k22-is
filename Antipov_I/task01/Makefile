OUT_DIR := out
ASM := nasm
ASM_FLAGS := -felf64

default:
	$(MAKE) all

prepare:
	mkdir -p out

build:
	$(ASM) $(ASM_FLAGS) memset.asm -o $(OUT_DIR)/memset.o
	$(ASM) $(ASM_FLAGS) memcpy.asm -o $(OUT_DIR)/memcpy.o
	$(ASM) $(ASM_FLAGS) strlen.asm -o $(OUT_DIR)/strlen.o
	$(ASM) $(ASM_FLAGS) strstr.asm -o $(OUT_DIR)/strstr.o

all:
	$(MAKE) build
