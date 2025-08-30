global main
extern printf

section .data
    msg db "Hello World", 10, 0

section .text
main:
    sub rsp, 40         ; reserves 40 bytes 
    mov rcx, msg        ; moves the string address into rcx
    xor rax, rax        ; RAX = 0
    call printf         ; calls printf
    add rsp, 40         ; free 40 bytes
    xor eax, eax        ; return 0
    ret                 ; terminated successfully
