section	.text
   global _start         ;must be declared for using gcc
	
_start:
	call func
	mov eax, 1
	mov ebx, 0
	int 0x80

func:
	push ebp
	mov ebp, esp

	; Open file
	mov eax, 5
	mov ebx, file_name
	mov ecx, 0
	mov edx, 0777
	int 0x80

	mov [fd_in], eax

	; Read file
	mov eax, 3
	mov ebx, [fd_in]
	mov ecx, info
	mov edx, 24

	; Print to stdout
	mov eax, 4
	mov ebx, 1
	mov ecx, info
	mov edx, 24
	int 0x80

	mov esp, ebp
	pop ebp
	ret


section	.data
file_name db '/home/jeffrey_t_sharpe/jeffcore_project/jeffcore/base_calc.jeff'
len 24

section .bss
fd_out resb 1
fd_in  resb 1
info resb  24
	
