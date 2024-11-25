.section .data
	poruka1: .ascii "Unesite string: "
	poruka1_len = . - poruka1
	unos_max = 41
	unos: .fill unos_max, 1, 42
	izlaz: .fill unos_max, 1, 42
	duzina: .long 0
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
	
	movl %eax, duzina
	movl $0, %eax
	movl $0, %esi
	
while:
	movb (%ecx), %al
	cmpb $'\n', %al
	je kraj
	
	cmpb $' ', %al
	je ukloni
	
	movb %al, izlaz(, %esi, 1)
	
	incl %esi
	incl %ecx
	jmp while
	
ukloni:
	incl %ecx
	incl brojac
	jmp while

kraj:
	movl $4, %eax
	movl $1, %ebx
	movl $izlaz, %ecx
	movl %esi, %edx
	int $0x80
	
	movl $1, %eax
	movl $0, %ebx
	int $0x80
