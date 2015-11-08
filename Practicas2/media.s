.section .data
	.macro linea
		#.int  1,-2,1,-2
		#.int 1,2,-3,-4
		#.int 0x7FFFFFFF
		#.int 0x80000000
		#.int  0xF0000000,0xE0000000,0xE0000000,0xD0000000
		.int  -1,-1,-1,-1
		
	.endm

	.macro linea0 #sistema para la primera linea distinta
		.int 0,-1,-1,-1
		#.int 0,-2,-1,-1
		#.int 1,-2,-1,-1
		#.int 10,-2,-1,-1
		#.int 32,-2,-1,-1
		#.int 60,-2,-1,-1
		#.int 63,-2,-1,-1
		#.int 64,-2,-1,-1
		#.int 80,-2,-1,-1
		#.int 95,-2,-1,-1
		#.int -31,-2,-1,-1
		#.int -20,-2,-1,-1
		#.int 0,-2,-1,-1
 	.endm

	



lista:	
		linea0 
	.irpc i,1234567#8
		linea
	.endr

longlista:	
	.int (.-lista)/4

media:
	.int 0x00000000

resto:
	.int 0x00000000

formato:	
	.ascii "Media =   %8d \t resto=  %8d \n"
	.ascii "hexadec 0x%08x \t resto=0x%08x \n\0" #formato para 64bits signed

.section .text
#_start:	.global _start
main: .global main
	mov $lista, %ebx
	mov longlista, %ecx
	call media_f
	mov %eax,media
	mov %edx,resto

	push resto
	push media
	push resto
	push media
	push $formato
	call printf

	add $20, %esp	

	mov $1, %eax
	mov $0, %ebx
	int $0x80

media_f:
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
	idiv %ecx
	ret
