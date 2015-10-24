.data
msg:    .string "hola, mundo!\n"
tam:    .int . - msg

.text
        .global _start

write:  mov   $1, %rax    # write
        mov   $1, %rdi    # stdout
        mov   $msg, %rsi  # texto
        mov   tam,  %rdx  # tamaño
        syscall           # llamada al sistema
        ret               # retorno

exit:   mov   $60,  %rax  # exit
        xor   %rdi, %rdi  # 0
        syscall           # llamada al sistema

_start: call  write       # llamada a función
        call  exit        # llamada a función

