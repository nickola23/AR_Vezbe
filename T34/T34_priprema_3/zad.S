#autor: Imenko Prezimić INDEX ra1234-2018
#int BitSwitch(unsigned int* vrednost, int n)
.section .text
.global BitSwitch
BitSwitch:
	pushl %ebp
	movl %esp, %ebp
	pushl %ebx
	pushl %esi
	pushl %edi
	
	movl 8(%ebp), %eax			#adresa niza
	movl $0, %esi				#i
	movl $0, %edi				#broj invertovanih bita

while:
	cmpl %esi, 12(%ebp)			
	je kraj
	
	movl $1, %ecx				#maska
	movl $2, %edx				#maska za invertovanje
	
menjaj:
	andl %ecx, %ecx
	jz sledeci
	andl %edx, %edx
	jz sledeci
	
	testl %ecx, (%eax, %esi, 4)
	jnz invertuj
	
sledeci_bit:
	shll %ecx
	shll %edx
	jmp menjaj
	
invertuj:
	xorl %edx, (%eax, %esi, 4)
	incl %edi
	jmp sledeci_bit

sledeci:
	incl %esi
	jmp while

kraj:
	movl %edi, %eax
	
	popl %edi
	popl %esi
	popl %ebx
	movl %ebp, %esp
	popl %ebp
	ret
