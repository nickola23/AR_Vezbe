.section .data
	poruka1: .ascii "Unesite string: "
	poruka1_len = . - poruka1
	unos_max = 41
	unos: .fill unos_max, 1, 42
	brojac: .long 0
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
	
	cmpb $' ', %al
	je ukloni
	cmpb $' ', %al
	je dalijerec
	
	incl %ecx
	jmp while
	
dalijerec:
	decl %ecx
	cmpb $'a', (%ecx)
	je povecajbr
	
	addl $2, %ecx
	jmp while
	
povecajbr:
	incl brojac
	addl $2, %ecx
	jmp while

kraj:
	movl $1, %eax
	movl brojac, %ebx
	int $0x80
