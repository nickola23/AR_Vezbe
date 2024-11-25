.section .text
.globl maska64
maska64:
	pushl %ebp
	movl %esp, %ebp
	pushl %ebx
	pushl %esi
	pushl %edi
	
	movb 8(%ebp), %cl   # n
	movl 12(%ebp), %esi # v
	
	movl $0xfffffffe, %eax
	movl $0xffffffff, %edx
	
	cmpl $1, %esi
	ja greska
	
	cmpb $63, %cl
	ja greska
	
	cmpb $31, %cl
	ja dvostruko
	
	roll %cl, %eax
	
	cmpl $1, %esi
	jne kraj
	
	notl %eax
	notl %edx
	jmp kraj
dvostruko:
	movl $0xffffffff, %eax
	movl $0xfffffffe, %edx
	
	subb $32, %cl
	roll %cl, %edx
	
	cmpl $1, %esi
	jne kraj
	
	notl %eax
	notl %edx
	jmp kraj
greska:
	movl $0, %eax
	movl $0, %edx
kraj:
	popl %edi
	popl %esi
	popl %ebx
	movl %ebp, %esp
	popl %ebp
	ret
