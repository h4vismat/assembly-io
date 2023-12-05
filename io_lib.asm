section .data
	text: db "hello, world", 0

section .bss
len resb 1

section .text
global _start

exit:
	mov rax, 60
	mov rdi, 0
	syscall

str_length:
	xor rax, rax
	
	.loop:
		cmp byte[rdi + rax], 0
		je .end ; jumps if null byte is found

		inc rax ; goes to next byte on string array
		jmp .loop
	
	.end:
		ret
		

print_char:
	mov rax, 1
	
	mov rdi, 1
	mov rdx, 1
	
	syscall
	ret

print_string:
	mov rdi, rsi ; move rsi para rdi para extrair o tamanho da string 
	call str_length
	mov [len], rax ; salva o tamanho da string em len 

	mov rax, 1
	mov rdi, 1
	mov rdx, [len] ; utiliza len para passar o valor ao registrador de tamanho

	syscall

	ret

print_newline:
	mov rsi, 10
	call print_char

	ret


_start:	
	mov rsi, text
	call print_string
	call print_newline

	call exit
