section		.text
			global	_ft_strlen

_ft_strlen:
			mov		rcx, 0
			jmp		loop

loop:
			cmp		BYTE[rdi + rcx], 0
			je		end
;			inc		rdi
			inc		rcx
			jmp		loop

end:		mov		rax, rcx
			ret
