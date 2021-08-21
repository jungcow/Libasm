section		.text
			global	_ft_strcmp

_ft_strcmp:
			mov		rcx, 0
			jmp		nullcheck1

nullcheck1:
			test	rdi, rdi
			jne		nullcheck2
			test	rsi, rsi
			jne		destnull
			mov		rax, 0
			ret
nullcheck2:
			test	rsi, rsi
			jz		srcnull
			jmp		loop

destnull:
			xor		rax, rax
			mov		al, BYTE[rsi]
			neg		rax
			ret
srcnull:
			xor		rax, rax
			mov		al, BYTE[rdi]
			ret

loop:
			cmp		BYTE[rdi + rcx], 0
			je		break
			cmp		BYTE[rsi + rcx], 0
			je		break
			mov		al, BYTE[rsi + rcx]
			cmp		BYTE[rdi + rcx], al
			jne		break
			inc		rcx
			jmp		loop

break:
			xor		rax, rax
			xor		rbx, rbx
			mov		al, BYTE[rdi + rcx]
			mov		bl, BYTE[rsi + rcx]
			cmp		rax, rbx
			jb		plus
			jl		minus
			je		equal

plus:
			sub		rax, rbx
			ret

minus:
			sub		rbx, rax
			mov		rax, rbx
			neg		rax
			ret
equal:
			xor		rax, rax
			ret
