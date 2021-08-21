extern	___error

section	.text
			global	_ft_write

_ft_write:	
			push	rbp
			mov		rax, 0x2000004	
			syscall	
			jc		error
			pop		rbp
			ret

error:		
			mov		rdx, rax
			call	___error
			mov		[rax], rdx
			mov		rax, -1
			pop		rbp
			ret
