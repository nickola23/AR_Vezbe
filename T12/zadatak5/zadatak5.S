.section .data
	poruka1: .ascii "Unesite string: "
	poruka1_len = . - poruka1
	unos_max = 41
	unos: .fill unos_max, 1, 42
	brojac: .long 0
	duzina: .long 0
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
	
while:
	movb (%ecx), %al			#trenutni karakter
	cmpb $'\n', %al
	je kraj
	
	cmpb $'A', %al				#da li je veliko slovo
	jb dalje
	cmpb $'Z', %al
	ja dalje
	
	incl %ecx					#da li je sledeci ! ili ?
	cmpb $'!', (%ecx)
	je smanji
	cmpb $'?', (%ecx)
	je smanji
	
	jmp while
	
smanji:
	decl %ecx					#vrati se na prethodni i smanji ga
	addl $32, (%ecx)
	incl %ecx
	incl brojac
	jmp while
	
	
dalje:
	incl %ecx
	jmp while

kraj:
	incl %ecx
	movb $'\0', (%ecx)
	movl $4, %eax
	movl $1, %ebx
	movl $unos, %ecx
	movl duzina, %edx
	int $0x80

	movl $1, %eax
	movl brojac, %ebx
	int $0x80
