.section .data
	.macro linea
		.int -1,-1,-1,-1
		#.int 0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF
		#.int  1,-2,1,-2
		#.int  1,2,-3,-4
		#.int  0x7FFFFFFF,0x7FFFFFFF,0x7FFFFFFF,0x7FFFFFFF
		#.int  0x80000000,0x80000000,0x80000000,0x80000000
		#.int  0x04000000,0x04000000,0x04000000,0x04000000
		#.int  0x08000000,0x08000000,0x08000000,0x08000000
		#.int  0xFC000000,0xFC000000,0xFC000000,0xFC000000
		#.int  0xF8000000,0xF8000000,0xF8000000,0xF8000000
		#.int   0xF0000000,0xE0000000,0xE0000000,0xD0000000
	.endm


lista:		
	.irpc i,12345678
		linea
	.endr

longlista:	
	.int (.-lista)/4

resultado:	
	.quad 0x123456789ABCDEF

formato:	
	.ascii "suma = %lld = %llx hex\n\0" #formato para 64bits signed

.section .text
#_start:	.global _start
main: .global main
	mov    $lista, %ebx
	mov longlista, %ecx
	call suma
	mov %eax, resultado
	mov %edx, resultado+4
	
	push resultado+4
	push resultado
	push resultado+4
	push resultado
	push $formato
	call printf
	add $20, %esp	

	mov $1, %eax
	mov $0, %ebx
	int $0x80

suma:
	mov $0, %edi
	mov $0, %ebp
	mov $0, %esi
bucle:
	mov (%ebx,%esi,4), %eax
	cltd		#extender signo a edx:eax
	add %eax, %edi	#sumar LSBs
	adc %edx, %ebp  #sumar MSBs con (posible) acarreo
	inc %esi	#incrementar indice
	cmp %esi, %ecx  #comparar con longitud
	jne bucle 	#si no son iguales, seguir acumulando

	mov %edi, %eax  #devolver resultado 
	mov %ebp,%edx
	ret

