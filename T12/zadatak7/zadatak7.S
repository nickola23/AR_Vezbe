.section .data
	poruka1: .ascii "Unesite string: "
	poruka1_len = . - poruka1
	unos_max = 51
	unos: .fill unos_max, 1, 42
	izlaz: .long 0
	suma: .long 0
	broj: .long 0
.section .text
.global main
main:
	movl $4, %eax
	movl $1, %ebx
	movl $poruka1, %ecx
	movl $poruka1_len, %edx
	int $0x80
	
	movl $3, %eax
	movl $0, %ebx
	movl $unos, %ecx
	movl $unos_max, %edx
	int $0x80
	
	movl $0, %eax
	
while:
	movb (%ecx), %al
	cmpb $'\n', %al
	je kraj
	
	cmpb $'0', %al
	jb dalje
	cmpb $'9', %al
	ja dalje
	
	movl $1, broj 		#ima brojeva
	addl %eax, suma
	incl %ecx
	jmp while
	
	
dalje:
	incl %ecx
	jmp while

kraj:
	cmpb $0, broj
	je krajbezbroja
	
	movl $suma, izlaz
	
krajbezbroja:
	movl $2, izlaz
	
krajkraj:

	movl $1, %eax
	movl izlaz, %ebx
	int $0x80
