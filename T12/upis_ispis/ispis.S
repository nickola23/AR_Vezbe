.section .data
	str: .ascii "Neki tekst\n\0"
	str_len = . - str
.section .text
.global main
main:
	movl $4, %eax
	movl $1, %ebx
	leal str, %ecx
	movl $str_len, %edx
	int $0x80
kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
