OUT_DIR := out
ASM := nasm
ASM_FLAGS := -felf64

default:
	$(MAKE) all

prepare:
	mkdir -p out

build:
	$(ASM) $(ASM_FLAGS) main.asm -o $(OUT_DIR)/main.o
	$(ASM) $(ASM_FLAGS) main_additional.asm -o $(OUT_DIR)/main_additional.o
	$(ASM) $(ASM_FLAGS) start.asm -o $(OUT_DIR)/start.o
	$(ASM) $(ASM_FLAGS) tests.asm -o $(OUT_DIR)/tests.o

link:
	$(LD) \
	-dynamic-linker /lib64/ld-linux-x86-64.so.2 \
	-o $(OUT_DIR)/main \
	$(OUT_DIR)/main.o \
	$(OUT_DIR)/main_additional.o \
	$(OUT_DIR)/start.o \
	$(OUT_DIR)/tests.o \
	-L/lib/x86_64-linux-gnu/ \
	-lc

all:
	$(MAKE) prepare
	$(MAKE) build
	$(MAKE) link

test:
	$(MAKE) all
	printf "\n\n=== Running app ===\n\n"
	./$(OUT_DIR)/main
