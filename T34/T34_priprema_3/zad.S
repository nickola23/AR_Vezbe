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
	andl %ecx, %ecx				#ako je kraj maske
	jz sledeci					#predji na sledeci element niza
	andl %edx, %edx
	jz sledeci
	
	testl %ecx, (%eax, %esi, 4) #da li je trenutni bit 0
	jnz invertuj
	
sledeci_bit:					#sledeci bit
	shll %ecx
	shll %edx
	jmp menjaj
	
invertuj:						#ako je 1 invertuj
	xorl %edx, (%eax, %esi, 4)	#invertuj sledeci bit
	incl %edi					#broj invetovanih ++
	jmp sledeci_bit

sledeci:						#sledeci element niza
	incl %esi
	jmp while

kraj:							#kraj
	movl %edi, %eax				#premesti broj invertovaih 
								#u return
	popl %edi
	popl %esi
	popl %ebx
	movl %ebp, %esp
	popl %ebp
	ret
