# Task 01

## Problem

Write on `x86_64` ASM functions:
- `memset` ([description](https://www.cplusplus.com/reference/cstring/memset/))
- `memcpy` ([description](https://www.cplusplus.com/reference/cstring/memcpy/))
- `strlen` ([description](https://www.cplusplus.com/reference/cstring/strlen/))
- `strstr` ([description](https://www.cplusplus.com/reference/cstring/strstr/))

Use calling conventions and callee-saved registers (function behaviour must not change caller environment).

# Calling convention

[Calling convention table](https://en.wikipedia.org/wiki/X86_calling_conventions#List_of_x86_calling_conventions)

The program has been written for Linux, therefore, `System V AMD64 ABI` calling convention has been used.

`RDI, RSI, RDX, RCX, R8, R9` for arguments.
`RBX, RSP, RBP, and R12–R15` as callee-saved registers.

# Testing

`make test` will build, link and execute the program

# Project Structure

`nasm` has been used

- `main.asm` contains core code with the functions
- `test.asm` contains tests data
- `start.asm` contains some code for executing the program
