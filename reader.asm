section	.text
   global _start         ;must be declared for using gcc
	
_start:
	call func
	mov eax, 1
	mov ebx, 0
	int 0x80

func:


section	.data
file_name db ''
	
