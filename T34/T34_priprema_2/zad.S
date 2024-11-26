# autor: Nikola Milanović INDEX sv53-2024
# int prebrojPalindrome(unsigned long long* niz, int n);
.section .text
.global prebrojPalindrome
prebrojPalindrome:
	pushl %ebp
	movl %esp, %ebp
	pushl %ebx
	pushl %edi
	pushl %esi
	
	movl 8(%ebp), %eax				#adresa niza
	
	movl $0, %esi					#trenutni element
	movl $0, %edi					#broj palindroma
	
while:
	cmpl %esi, 12(%ebp)				#da li je kraj niza
	je kraj
	movl $1, %ecx					#maska za nizi deo
	movl $0x80000000, %edx			#maska za visi deo
	
palindrom:
	andl %ecx, %ecx					#ako je kraj maske
	jz sledeci						#predji na sledeci element niza
	andl %edx, %edx
	jz sledeci

	testl %ecx, (%eax, %esi, 8)		#uporedi vrednost nizeg dela elementa
	jz oba_nula
	
	testl %edx, 4(%eax, %esi, 8)				
	jnz isti						#da li su oba 1
	jmp nisu_isti					#ako nisu oba 1 nisu isti
	
oba_nula:							#da li su oba 0
	testl %edx, 4(%eax, %esi, 8)	#uporedi visi deo sa maskom
	jz isti							#ako su nula isti su
	jmp nisu_isti
	
isti:								#ako su isti predji
	shll %ecx						#na sledeci bit
	shrl %edx
	jmp palindrom
	
nisu_isti:							#ako nisu isti predji
	incl %esi						#na sledecu element
	jmp while
	
sledeci:							#jeste polindrom i
	incl %edi						#predji na sledeci
	incl %esi
	jmp while

kraj:
	movl %edi, %eax					#premesti br palindroma
									#u return  
	popl %esi
	popl %edi
	popl %ebx
	movl %ebp, %esp
	popl %ebp
	ret
