.section .text
.global saberi_niz
saberi_niz:
	pushl %ebp
	movl %esp, %ebp
	pushl %esi
	pushl %edi
	pushl %ebx
	
	movl 8(%ebp), %eax 		#a
	movl 12(%ebp), %ebx 	#b
	movl 16(%ebp), %ecx 	#c
	movl 20(%ebp), %esi 	#n
	
	movl $0, %edx			#sum
	
while:
	cmpl $0, %esi			#da li je kraj
	je pravi_kraj
	
	movl (%eax), %edx		#saberi donje delove
	addl (%ebx), %edx
	movl %edx, (%ecx)
	
	movl 4(%eax), %edx		#saberi vise delove
	adcl 4(%ebx), %edx
	jc greska
	movl %edx, 4(%ecx)
	
	addl $8, %eax			#predji na sledeci
	addl $8, %ebx
	addl $8, %ecx
	
	decl %esi
	jmp while
	
greska:
	movl $1, %eax
	jmp kraj
	
pravi_kraj:
	movl $0, %eax
	
kraj:						#kraj
 	popl %ebx
 	popl %edi
 	popl %esi
 	movl %ebp, %esp
 	popl %ebp
 	ret
