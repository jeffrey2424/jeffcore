global main
extern printf

section .data
	message db "Testing for jeff %i", 0x0a, 0x00

main:
	push ebp
	mov ebp, esp
	push 123
	push message
	call printf
	mov eax, 0
	mov esp, ebp
	pop ebp
	ret
