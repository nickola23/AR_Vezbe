.section .text
.globl maska
maska:
	pushl %ebp
	movl %esp, %ebp
	pushl %ebx
	pushl %esi
	pushl %edi
	
	movb 8(%ebp), %cl   # n
	movl 12(%ebp), %esi # v
	
	movl $0xfffffffe, %eax
	
	cmpl $1, %esi
	ja greska
	
	cmpb $31, %cl
	ja greska
	
	roll %cl, %eax
	
	cmpl $1, %esi
	jne kraj
	
	notl %eax
	jmp kraj
greska:
	movl $0, %eax
kraj:
	popl %edi
	popl %esi
	popl %ebx
	movl %ebp, %esp
	popl %ebp
	ret
