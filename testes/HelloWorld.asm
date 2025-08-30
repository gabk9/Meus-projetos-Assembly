extern printf
section .data
    msg db "Hello World", 10, 0

section .text
    global main

main:
    sub rsp, 40
    lea rcx, [msg]
    call printf
    add rsp, 40

    mov eax, 0
    ret