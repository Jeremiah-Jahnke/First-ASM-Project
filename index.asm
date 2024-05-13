default rel
global main
extern printf
extern exit

section .data
    message: db "Hello, World!", 0

section .text
    main:
        sub rsp, 28h
        lea rcx, [message]
        call printf

        xor edi, edi
        call exit

        add rsp, 28h
        hlt
