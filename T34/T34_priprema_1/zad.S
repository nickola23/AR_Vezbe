# autor: Nikola Milanović INDEX sv53-2024
# int prebrojNajviseUzastopnih(unsigned long long* vrednost)
.section .text
.global prebrojNajviseUzastopnih
prebrojNajviseUzastopnih:
	pushl %ebp
	movl %esp, %ebp
	pushl %edi
	pushl %esi
	pushl %ebx

	movl 8(%ebp), %eax			#adresa broja
	movl (%eax), %ebx			#niza vrednost broja
	#movl 4(%eax)				visi deo broja
	
	movl $0, %esi				#i - trenutni broj nula
	movl $0, %edi				#max - max broj nula
	movl $1, %edx				#maska
	movl $0, %ecx				#da li je visi deo broja
	
while:
	testl %edx, %edx			#da li je kraj maske
	jz visi_deo					#predji na visi deo

	testl %edx, %ebx			#da li je  nula
	jnz nije_nula
	
	incl %esi					#i++
	
dalje:
	shll %edx					#pomeri masku
	jmp while

nije_nula:
	cmpl %edi, %esi				#da li je i > max
	jb manji
	
	movl %esi, %edi				#prebaci i u max
	
manji:
	movl $0, %esi				#ako je manji preskoci
	jmp dalje
	
visi_deo:						#predji na visi deo
	cmpl $0, %ecx
	jne nije_visi				#ako je vec bio visi preskoci
	
	movl $1, %edx
	movl 4(%eax), %ebx
	movl $1, %ecx				#vise nece prolaziti kroz visi deo
	jmp while
	
nije_visi: 
	cmpl %edi, %esi				#za kraj proveri da li je i > max
	jb dalje_nije_visi
	
	movl %esi, %edi				#premesti i u max
	
dalje_nije_visi:
	movl %edi, %eax				#premesti max u return

kraj:							#kraj
	popl %ebx
	popl %esi
	popl %edi
	movl %ebp, %esp
	popl %ebp
	ret
