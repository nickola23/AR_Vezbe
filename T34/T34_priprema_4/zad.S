#autor: Nikola Millanović INDEX sv53-2024
#int InvertBits(unsigned int* indeksi, int n);
.section .text
.global InvertBits
InvertBits:
	pushl %ebp
	movl %esp, %ebp
	pushl %esi
	pushl %edi
	pushl %ebx
	
	movl 8(%ebp), %ebx			#adresa niza
	
	movl $0, %eax				#povratna vrednost
	movl $0, %esi				#clan niza
	
while:
	cmpl %esi, 12(%ebp)			#da li je kraj niza
	je kraj
	
	movl $0, %edi				#pozicija bita
	movl $1, %ecx				#maska
	
pomeri:
	cmpl %edi, (%ebx, %esi, 4)	#da li je na odgovarajucem bitu
	je zameni
	
	incl %edi					#predji na sledeci element
	shll %ecx
	jmp pomeri
	
zameni:
	orl %ecx, %eax				#promeni bit na 1
	incl %esi
	jmp while
	
kraj:
	popl %ebx					#kraj
	popl %edi
	popl %esi
	movl %ebp, %esp
	popl %ebp
	ret
