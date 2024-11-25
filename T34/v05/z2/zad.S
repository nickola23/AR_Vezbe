.section .text
.globl fibonaci
fibonaci:
	pushl %ebp
	movl %esp, %ebp
	pushl %ebx
	pushl %esi
	pushl %edi
	
	movl 8(%ebp), %ecx #broj elementa
	movl 12(%ebp), %edx #greska
	
	cmpl $2, %ecx
	ja rekurzija
	
	movl $1, %eax
	movl $0, (%edx)
	jmp kraj
rekurzija:
	movl %ecx, %esi
	
	decl %ecx
	pushl %edx
	pushl %ecx
	call fibonaci
	addl $8, %esp
	
	movl %eax, %edi
	
	subl $2, %esi
	pushl %edx
	pushl %esi
	call fibonaci
	addl $8, %esp
	
	addl %edi, %eax
	jc greska_kraj
	jmp kraj
greska_kraj:
	movl $1, (%edx)
	popl %edi
	popl %esi
	popl %ebx
	movl %ebp, %esp
	popl %ebp
	ret
kraj:
	movl $0, (%edx)
	popl %edi
	popl %esi
	popl %ebx
	movl %ebp, %esp
	popl %ebp
	ret
