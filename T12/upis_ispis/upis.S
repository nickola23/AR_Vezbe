.section .data
	str_max = 40
	str: .fill str_max,1,42
.section .text
.global main
main:
	movl $3, %eax
	movl $0, %ebx
	leal str, %ecx
	movl $str_max, %edx
	int $0x80
kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
