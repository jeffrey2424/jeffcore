global _start

section .text
_start:
	mov ebx, 1
	mov ecx, 4
	mov eax, 1

loop:
	add ebx, ebx
	sub ecx, 1
	cmp ecx, 0
	jg loop
	int 0x80
	
