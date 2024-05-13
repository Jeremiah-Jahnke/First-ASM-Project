# First ASM Project
This is my first ASM project. It is a simple program that prints "Hello, World!" to the console.

## How to run
1. Download or Clone using `Github Desktop` or `Git`
2. Open in `vscode` or whatever editor you use
3. Open folder in `terminal/cmd prompt`
4. Run the following commands:
```bash
> nasm -f win32 index.asm
> gcc index.obj
> a.exe
```
5. You should see `"Hello, World!"` in the console

## How it works
This program uses the Windows API to print to the console. It uses the following instructions:
```asm
default rel     ; use relative addressing
global main     ; make main function visible to linker
extern printf   ; import printf function from msvcrt.dll
extern exit     ; import exit function from msvcrt.dll

section .data
    message: db "Hello, World!", 0 ; the format string for printf

section .text
    main:
        sub rsp, 28h ; allocate space for printf arguments
        lea rcx, [message] ; load the address of the format string into rcx
        call printf ; call printf(message)

        xor edi, edi ; set exit code to 0
        call exit ; call exit(0)

        add rsp, 28h ; deallocate space for printf arguments
        hlt ; halt the program
```

## Instructions breakdown
- `default rel` - This tells the assembler to use relative addressing by default. This is important because the Windows API uses relative addressing.
- `global main` - This makes the `main` function visible to the linker. This is required for the program to run.
- `extern printf` - This imports the `printf` function from `msvcrt.dll`. This is the function we will use to print to the console.
- `extern exit` - This imports the `exit` function from `msvcrt.dll`. This is the function we will use to exit the program.
- `section .data` - This is the data section where we define our variables.
- `message: db "Hello, World!", 0` - This defines a null-terminated string `message` with the value `"Hello, World!"`. The `0` at the end is the null terminator required by `printf`.
- `section .text` - This is the code section where we define our instructions.
- `main:` - This is the entry point of our program.
- `sub rsp, 28h` - This allocates space on the stack for the arguments to `printf`. The `28h` is the hexadecimal value for `28`, which is the number of bytes we need to allocate.
- `lea rcx, [message]` - This loads the address of the `message` string into the `rcx` register. This is the first argument to `printf`.
- `call printf` - This calls the `printf` function with the `message` string as the argument.
- `xor edi, edi` - This sets the exit code to `0`. This is the return value of the program.
- `call exit` - This calls the `exit` function with the exit code `0`.
- `add rsp, 28h` - This deallocates the space on the stack that we allocated earlier.
- `hlt` - This halts the program. This isn't needed, but it's good practice.