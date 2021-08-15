section	.text
			global	_ft_write

_ft_write:	
			push	rbp
			mov		rbp, rsp
			mov		rax, 0x2000004
			mov		rdi, [rbp+16]
			mov		rsi, [rbp+24]
			mov		rdx, [rbp+32]
			syscall
			jc		_error
			mov		rsp, rbp
			pop		rbp
			ret

_error:		
			push	rax
			call	___error
			pop		rdx
			mov		[rax], rdx
			mov		rax, -1
			ret
