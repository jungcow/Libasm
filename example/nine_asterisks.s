global start

			section	.text

start:		mov		rax, 0x2000004
			mov		rdx, 10
			mov		rsi, stars
			mov		rdi, 1
			syscall
			mov		rax, 0x2000001
			xor		rdi, rdi
			syscall

			section	.data
stars		db		"*********"
