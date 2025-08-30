global main
extern printf

section .data
    msg db "42", 10, 0

section .text
main:
    sub rsp, 40
    mov rcx, msg
    xor rax, rax
    call printf
    xor eax, eax
    ret 