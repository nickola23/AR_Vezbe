.section .text
.global maska64
maska64:
	pushl %ebp
	movl %esp, %ebp
	pushl %esi
	pushl %edi
	pushl %ebx
	
	movl 8(%ebp), %eax		#n
	movl 12(%ebp), %ebx		#v
	
	movl $1, %esi			#maska
	movl $0, %edi			#i
	
	cmpl $63, %eax			#greska
	ja greska_unos
	cmpl $1, %ebx
	ja greska_unos
	
	cmpl $32, %eax			#dvostruka
	ja dvostruka
	
while:
	cmpl %edi, %eax
	je kraj_bez_greske
	
	shll %esi
	incl %edi
	jmp while
	
kraj_bez_greske:			#bez greske <32
	movl $0, %edx
	movl %esi, %eax
	jmp kraj
	
dvostruka:					#dvostruka
	subl $32, %eax
	cmpl %edi, %eax
	je kraj_bez_greske_dvostruka
	
	shll %esi
	incl %edi
	jmp while
	
kraj_bez_greske_dvostruka:	#bez greske <64
	movl $0, %eax
	movl %esi, %edx
	jmp kraj

greska_unos:				#greska unos
	movl $0, %eax
	movl $0, %edx
	movl $1, %ebx
	jmp kraj
	
negiraj:					#negiraj
	notl %eax
	notl %edx
	movl $1, %ebx
	jmp kraj

kraj:						#kraj
	cmpl $0, %ebx
	je negiraj

	popl %ebx
	popl %edi
	popl %esi
	movl %ebp, %esp
	popl %ebp
	ret
