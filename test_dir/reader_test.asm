section	.text
   global _start         ;must be declared for using gcc
	
_start:                  ;tell linker entry point
   ;create the file
   mov  eax, 8
   mov  ebx, file_name
   mov  ecx, 0666        ;read, write and execute by all
   int  0x80             ;call kernel
	
   mov [fd_out], eax
    
   ; write into the file
   mov	edx, 20          ;number of bytes
   mov	ecx, msg         ;message to write
   mov	ebx, [fd_out]    ;file descriptor 
   mov	eax, 4            ;system call number (sys_write)
   int	0x80             ;call kernel

	mov eax, 4
	mov ebx, 1
	mov ecx, file_name
	mov edx, 5
	int 0x80


   ; close the file
   mov eax, 6
   mov ebx, [fd_out]
    
       
   mov	eax,1             ;system call number (sys_exit)
   int	0x80              ;call kernel

section	.data
file_name db 'myfile.txt'
msg_fake db 'This should not be here'
msg db 'Welcome to Tutorials Point'


section .bss
fd_out resb 1
fd_in  resb 1
info resb  26
