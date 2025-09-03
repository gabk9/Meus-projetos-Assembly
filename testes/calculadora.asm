global main
extern printf
extern scanf
extern system

section .data
    tittle db "======Calculator======", 10, 0
    options db "[1] Multiplication", 10, "[2] Division", 10, "[3] Addition", 10, "[4] Subtraction" ,10, "[0] Exit program", 10, 0

    choice db "Choose an option: ", 0
    choice_in db "%d", 0

    err db 10, "Error: Operation not permitted!", 10, 0
    end db 10, "Terminating program, bye!!", 10, 0
    cmd db "pause", 0

    n1 db "Type-in the 1st number: ", 0
    n1_in db "%d", 0

    n2 db "Type-in the 2nd number: ", 0
    n2_in db "%d"

    div_or db 10, "or", 10, 0
    div_err db 10, "Cant divide by 0!!", 10, 0
    
    multi db 10, "%d x %d = %d", 10, 0
    division db 10, "%.2f / %.2f = %.2f", 10, 0
    division2 db 10, "%d / %d = %d with remainder: %d", 10, 0
    sum db 10, "%d + %d = %d", 10, 0
    min db 10, "%d - %d = %d", 10, 0

section .bss
    num resd 2
    op resd 1

section .text
main:
    sub rsp, 56

main_menu:
    lea rcx, [rel tittle]
    call printf
    lea rcx, [rel options]
    call printf
    lea rcx, [rel choice]
    call printf
    lea rcx, [rel choice_in]
    lea eax, [rel op]
    call scanf

    cmp eax, 1
    je multiplication_menu

    cmp eax, 2
    je division_menu

    cmp eax, 3
    je addition_menu

    cmp eax, 4
    je main_menu

    cmp eax, 0
    je endif

    jmp invalid_option

Subtraction_menu:
    jmp main_menu
    ; TODO implement subtraction

addition_menu:
    jmp main_menu
    ; TODO implement addition

division_menu:
    jmp main_menu
    ; TODO implement division

multiplication_menu:
    jmp main_menu
    ; TODO implement multiplication

invalid_option:
    lea rcx, [rel err]
    call printf
    lea rcx, [rel cmd]
    xor rax, rax
    call system
    jmp main_menu

endif:
    lea rcx, [rel end]
    call printf
    lea rcx, [rel cmd]
    xor rax, rax
    call system
    
    add rsp, 56
    xor eax, eax
    ret