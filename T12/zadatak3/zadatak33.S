.section .data
	poruka1: .ascii "Unesite string: "
	poruka1_len = . - poruka1
	unos_max = 30
	unos: .fill unos_max, 1, 42
	prosla: .byte 0
	izlaz: .long 0
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
	
	movl $unos, %esi 	#pokazivac na niz
	movl $1, %eax 		#rezultat
	movl $0, %ebx		#brisemo prethodnu vrednost
	
while:
	movb (%esi), %bl 	#trenutni
	cmpb $'\n', %bl		#da li je kraj
	je kraj_bez_greske
	
	cmpb $'0', %bl		#da li je cifra
	jb sledeca
	cmpb $'9', %bl
	ja sledeca
	
	cmpb prosla, %bl	#da li je veca
	ja veca
						#manja
	movb %bl, prosla
	movl $0, %edx		#restartuj ostatak
	divl %ebx			#podeli
	cmpl $0, %edx		#da li je ostatak 0
	je greska_deljenje
	jmp sledeca
	
veca:
	movb %bl, prosla
	mull %ebx
	jc greska_mnozenje
	jmp sledeca
	
sledeca:
	incl %esi
	jmp while

greska_deljenje:
	movl $45, izlaz
	jmp kraj
	
greska_mnozenje:
	movl $54, izlaz
	jmp kraj
	
kraj_bez_greske:
	movl $0, %edx
	movl $128, %ebx
	divl %ebx
	movl %edx, izlaz

kraj:
	movl $1, %eax
	movl izlaz, %ebx
	int $0x80
