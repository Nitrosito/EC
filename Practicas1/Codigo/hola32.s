.data
msg:    .string "hola, mundo!\n"
tam:    .int . - msg

.text                     # sección de código
        .globl _start     # punto de entrada

write:  movl  $4, %eax    # write
        movl  $1, %ebx    # salida estándar
        movl  $msg, %ecx  # cadena
        movl  tam, %edx   # longitud
        int   $0x80       # llamada al sistema
        ret               # retorno a _start

exit:   movl  $1, %eax    # exit
        xorl  %ebx, %ebx  # 0
        int   $0x80       # llamada al sistema

_start: call  write       # llamada a función
        call  exit        # llamada a función

