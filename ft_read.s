extern	___error

section	.text
			global	_ft_read

_ft_read:
			push	rbp
			mov		rax, 0x2000003
			syscall
			jc		_error
			pop		rbp
			ret

_error:
			mov		rdx, rax
			call	___error
			mov		[rax], rdx
			mov		rax, -1
			pop		rbp
			ret
