.section .text
.globl saberi_niz
saberi_niz:
	pushl %ebp				#premesti na stack
	movl %esp, %ebp
	pushl %ebx
	pushl %esi
	pushl %edi
	
	movl 8(%ebp), %eax 		#adresa niza a
	movl 12(%ebp), %ebx 	#adresa niza b
	movl 16(%ebp), %ecx 	#adresa niza c
	movl 20(%ebp), %edi 	#n
petlja:
	cmpl $0, %edi			#da li je kraj
	je kraj_ok

	movl (%eax), %edx 		#sabiranje nizih
	addl (%ebx), %edx
	movl %edx, (%ecx)	
							
	movl 4(%eax), %edx 		#sabiranje visih
	adcl 4(%ebx), %edx
	jc greska
	movl %edx, (%ecx)
	
	addl $8, %eax 			#prelazak na nizi deo sledeceg elementa 
	addl $8, %ebx 			#prelazak na nizi deo sledeceg elementa
	addl $8, %ecx			#prelazak na nizi deo sledeceg elementa
	
	decl %edi 				#brojac elemenata
	jmp petlja
	
greska:
	movl $1, %eax			#vrati gresku u return
	jmp kraj
	
kraj_ok:
	movl $0, %eax			#return bez greske
	
kraj:						#kraj
	popl %edi
	popl %esi
	popl %ebx
	movl %ebp, %esp
	popl %ebp
	ret
