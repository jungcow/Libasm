section		.text
			global	_ft_strdup
			extern	_malloc
			extern	_ft_strlen
			extern	_ft_strcpy

_ft_strdup:
			push	rbp
			mov		rbp, rsp
			sub		rsp, 20h

			call	_ft_strlen

			push	rdi
			push	rax
			mov		rdi, rax
			add		rdi, 1
			call	_malloc

			mov		rdi, rax
			pop		rsi
			pop		rsi
			call	_ft_strcpy

			mov		rsp, rbp
			pop		rbp
			ret
