.section .data
	unos_max = 50
	unos: .fill unos_max, 1, 42
	poruka1: .ascii "Unesite string: \0"
	poruka1_len = . - poruka1
	poruka2: .ascii "Rezultujuci string: \0"
	poruka2_len = . - poruka2
	novarec: .fill unos_max, 1, 42
	duzina: .long 0
	povecaj: .long 0
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
	subl $1, duzina
	movl $0, %esi
	
while:
	cmpl duzina, %esi
	je kraj
	movb unos(, %esi, 1), %al
	cmpb $'\n', %al
	je kraj
	
	#da li je tacka
	cmpb $'.', %al
	je tacka
	
	#da li je slovo
	cmpb $'a', %al
	jb upisislovo
	cmpb $'z', %al
	ja upisislovo
	
nastavi:
	#da li treba da se poveca slovo
	cmpl $1, povecaj
	je povecajslovo
	
upisislovo:
	movb %al, novarec(, %esi, 1)
	incl %esi
	jmp while
	
proverislovo:
	cmpb $'A', %al
	jb upisislovo
	jmp nastavi
	
povecajslovo:
	#da li je malo slovo
	cmpb $'a', %al
	jb upisislovo
	cmpb $'z', %al
	ja upisislovo
	
	#prebaci u veliko slovo
	subb $'a', %al
	addb $'A', %al
	movl $0, povecaj
	jmp upisislovo

tacka:
	movl $1, povecaj
	jmp upisislovo

kraj:
	movl $4, %eax
	movl $1, %ebx
	movl $poruka2, %ecx
	movl $poruka2_len, %edx
	int $0x80
	
	movl $4, %eax
	movl $1, %ebx
	movl $novarec, %ecx
	movl duzina, %edx
	int $0x80

	movl $1, %eax
	movl $0, %ebx
	int $0x80
