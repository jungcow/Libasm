section		.text

			global	_ft_strcpy

_ft_strcpy:
			mov		rcx, 0
			jmp		loop

loop:
			cmp		BYTE[rsi + rcx], 0
			je		end
			mov		dl, BYTE [rsi + rcx]
			mov		BYTE[rdi + rcx], dl
			inc		rcx
			jmp		loop

end:
			mov		BYTE[rdi + rcx], 0
			mov		rax, rdi
			ret
