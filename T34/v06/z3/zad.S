.section .text
.global SetParity
SetParity:
	pushl %ebp
	movl %esp, %ebp
	pushl %esi
	pushl %edi
	pushl %ebx
	
	movl $0, %ecx
	movw 8(%ebp), %cx		#n
	
	movw $1, %bx			#maska
	movl $0, %eax			#i
	movl $0, %esi
	
while:
	cmpl $15, %esi
	ja kraj
	
	testw %cx , %bx
	jz dalje
	
	incl %eax
dalje:
	shlw %bx
	incl %esi
	jmp while
	
nula:
	movl $0, %eax
	jmp nuladalje
	
kraj:						#kraj
	cmpl $0, %eax
	je nula
	movl $0, %edx
	movl $2, %edi
	divl %edi				#da li je paran
	movl %edx, %eax
	
nuladalje:
	cmpl $0, %edx
	je ubaci_nula
	
	orw $0b1000000000000000, %cx

ubaci_nula:
	andw $0b0111111111111111, %cx

	movw %cx, 8(%ebp)
	popl %ebx
	popl %edi
	popl %esi
	movl %ebp, %esp
	popl %ebp
	ret
