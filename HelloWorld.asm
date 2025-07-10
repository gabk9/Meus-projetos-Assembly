extern printf
extern getchar
extern system

section .data
    pedir_msg db "Digite algo: ", 0
    output_fmt db "Voce digitou: %s", 10, 0
    pause_cmd db "pause", 0


section .bss
    buffer resb 1024

section .text
    global main

main:
    sub rsp, 40

    ; printf("Digite algo: ")
    lea rcx, [rel pedir_msg]
    call printf

    ; prepara ponteiro para buffer
    lea rdi, [rel buffer]
    mov rcx, 1024            ; tamanho max

.read_loop:
    ; getchar()
    call getchar
    mov bl, al              ; armazena caractere em bl

    cmp bl, 10              ; \n?
    je .fim_leitura

    cmp bl, 0               ; caractere nulo? (não deve ocorrer)
    je .fim_leitura

    ; armazena caractere no buffer
    mov [rdi], bl
    inc rdi

    ; decrementa limite e verifica se chegou a 0
    dec rcx
    jz .fim_leitura

    jmp .read_loop

.fim_leitura:
    ; adiciona terminador nulo
    mov byte [rdi], 0

    ; printf("Você digitou: %s\n", buffer)
    lea rcx, [rel output_fmt]
    lea rdx, [rel buffer]
    call printf

    ; system("pause")
    lea rcx, [rel pause_cmd]
    call system

    xor eax, eax
    add rsp, 40
    ret
