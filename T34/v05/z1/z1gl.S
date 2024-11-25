.section .text
.global fibonaci
fibonaci:
	pushl %ebp				#premesti na stack
	movl %esp, %ebp
	pushl %esi
	pushl %edi
	pushl %ebx
	
	movl 8(%ebp), %eax		#n
	movl 12(%ebp), %ebx		#rezultat
	
	movl $1, %esi			#trenutni
	movl $1, %edi			#prosli
	movl $0, %edx			#temp
	movl $2, %ecx			#i
	
while:
	cmpl %ecx, %eax			#da li je kraj
	je kraj_bez_greske
	
	movl %esi, %edx
	addl %edi, %esi
	jc greska				#ako izadje van opsega
	movl %edx, %edi
	
	incl %ecx
	jmp while
	
greska:
	movl $1, %eax			#vrati gresku u return
	jmp kraj
	
kraj_bez_greske:
	movl $0, %eax			#return bez greske
	movl %esi, (%ebx)
		
kraj:						#kraj
	popl %ebx
	popl %edi
	popl %esi
	movl %ebp, %esi
	popl %ebp
	ret
