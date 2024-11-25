.section .data
	input_msg: .ascii "Unesite string: "
	input_msg_len = . - input_msg
	unos_max = 30
	unos: .fill unos_max, 1, 42
	output: .fill unos_max, 1, 42
.section .text
.global main
main:
	movl $4, %eax
	movl $1, %ebx
	movl $input_msg, %ecx
	movl $input_msg_len, %edx
	int $0x80
	
	movl $3, %eax
	movl $0, %ebx
	movl $unos, %ecx
	movl $unos_max, %edx
	int $0x80
	
	movl $0, %esi				#brojac za output
	
while:
	cmpb $'\n', (%ecx)			#da li je enter
	je kraj
	cmpb $'i', (%ecx)			#da li je i
	je reverse
	
	movb (%ecx), %bl			#premesti u output
	movb %bl, output(,%esi, 1)
	incl %esi
	incl %ecx
	jmp while

reverse:

kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
