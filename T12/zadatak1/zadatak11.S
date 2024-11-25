.section .data
	poruka1: .ascii "Unesite string: \0"
	poruka1_len = . - poruka1
	unos_max = 50
	unos: .fill unos_max, 1, 42
	min: .ascii "9"
	max: .ascii "0"
	duzina: .long 0
	izlaz: .long 0
	cifra: .long 0 #da li je postojala barem 1 cifra
.section .text
.global main
main:
	#ispis
	movl $4, %eax
	movl $1, %ebx
	movl $poruka1, %ecx
	movl $poruka1_len, %edx
	int $0x80
	
	#unos
	movl $3, %eax
	movl $0, %ebx
	movl $unos, %ecx
	movl $unos_max, %edx
	int $0x80
	
	movl $0, %esi 			#i
	movl %eax, duzina 		#n
	
while: 
							#uslovi za nastavak
	cmpl duzina, %esi
	je kraj
	movb unos(, %esi), %al 	#trenutni k
	cmpb $'\n', %al
	je kraj
	
	#uslovi za broj
	cmpb $'0', %al
	jb nijebr
	cmp $'9', %al
	ja nijebr
	movl $1, cifra 			#ima cifra
	
							#provera vrednosti
	cmpb min, %al
	jl minimalni
	cmpb max, %al
	ja maksimalni
	incl %esi
	jmp while
	
minimalni:
	movb %al, min
	jmp while
	
maksimalni:
	movb %al, max
	jmp while

nijebr:
	incl %esi
	jmp while

kraj:
	cmpl $0, cifra
	je konacno
	movl min, %eax
	addl max, %eax
	movl %eax, izlaz
	
konacno:
	movl $1, %eax
	movl izlaz, %ebx
	int $0x80
