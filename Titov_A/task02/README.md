# Task 02

## Problem

Write on `x86_64` ASM functions:
- `strncpy` ([description](https://www.cplusplus.com/reference/cstring/strncpy/))
- `strnlen` ([description](https://www.cplusplus.com/reference/cstring/strnlen/))

Use calling conventions and callee-saved registers (function behaviour must not change caller environment).

# Task 02 (additional)

By the way, there is [a table of jump instructions](https://stackoverflow.com/a/27284932/14142236)

## Problem

I have made, hmmmm, a bit complicated task pseudocode.
However, now it will not collide with anyone's solution, I guess.

```c
size_t checksum(u8 *data, size_t size)
{
    size_t result = 0;

    for (u64 i = 0; i < size; i += sizeof(size_t)) {
        result ^= *((size_t *) &data[i]);
    }

    u8 cache[sizeof(size_t)];
    *((size_t *) cache) = 0;
    
    size_t loop_finish = size % 8;
    size_t base = size  - loop_finish;
    for (u64 i = 0; i < loop_finish; ++i) {
        cache[i] = data[base + i];
    }

    return result ^ *((size_t *) cache);
}
```

Usually ~~(and I think not always beacause it's Intel)~~, in x86_64 architecture the `size_t` equals to 8 bytes.

Looks difficult, right?
Additional features:
- XOR instead of SUM
- Loop with step of 4
- "Type conversions"
- Stack memory allocation (see `cache` variable)
- Arithmetic division

Update: by the way, `memcpy` can be used instead of the second loop.

# Calling convention

[Calling convention table](https://en.wikipedia.org/wiki/X86_calling_conventions#List_of_x86_calling_conventions)

The program has been written for Linux, therefore, `System V AMD64 ABI` calling convention has been used.

`RDI, RSI, RDX, RCX, R8, R9` for arguments.
`RBX, RSP, RBP, and R12–R15` as callee-saved registers.

# Testing

`make test` will build, link and execute the program

## Test cases

### strncpy

- strncpy [must not null-terminate the end](https://stackoverflow.com/questions/1453876/why-does-strncpy-not-null-terminate)
- Source string is zero-length
- Source string is larger than max_size
- Source string is smaller than max_size

### strnlen

- Zero length string
- Source string is larger than max_size
- Source string is smaller than max_size

# Project Structure

`nasm` has been used

- `main.asm` contains core code with the functions
- `test.asm` contains tests data
- `start.asm` contains some code for executing the program
