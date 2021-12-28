# Libasm
# [Outer Circle] Libasm

- 목차
    1. [Instruction](#instruction)
        1. 어셈블리의 장점
        2. 어셈블리어는 언제 쓰이는가?
    2. [Three Section on Assembly](#three-section-on-assembly)
        1. Data section
        2. BSS section
        3. Text section
    3. [Register의 종류](#register-type)
        1. [General Registers](#general-registers)
            1. Data Registers
            2. Point Registers
            3. Index Registers
            4. 새롭게 알게된 사실
        2. [Control Registers](#control-registers)
        3. [Segment Registers](#segment-registers)
    4. [범용 레지스터 리뷰](#범용-레지스터-리뷰)
        1. RAX(Accumulator)
        2. RBX(Base)
        3. RCX(Count)
        4. RDX(Data)
        5. RSI(Source)
        6. RDI(Destination)
        7. RSP(Stack)
        8. RBP(Base)
        9. R8 ~ R15
    5. [Opcode(명령어) & Operand](#opcode명령어--operand)
        1. 조작 명령어
        2. 데이터 전송 관련 명령어
        3. 산술 명령어
        4. 추가 instruction
        5. 참고
    6. [어셈블리 문법](#어셈블리-문법)
        1. 기본 문법
        2. AT&T 와 Intel 문법
    7. [Intel Calling Convention](#intel-calling-convention)
        1. 16바이트 정렬 규칙
        2. prologue와 epilogue
        3. Caller와 Callee의 역할
    8. [기타 궁금한 점](#기타-궁금한-점)
        1. jmp VS call
        2. mov의 좌,우변 동시에 메모리 엑세스가 올 수 없는 이유?
        3. MOV vs XOR
        4. rcx 말고 다른레지스터로 루프에 증감하며 사용하면 안되나?
        5. Why push argument in reverse order?
    9. [과제 가이드](#과제-가이드)
        1. ft_write.s
        2. ft_read.s
        3. ft_strlen.s
        4. ft_strcpy.s
        5. ft_strcmp.s
        6. ft_strdup.s
    10. [이슈 트래킹](#이슈-트래킹)
        1. callee의 역할을 이해하지 못해 발생한 에러
    11. [참고자료](#참고자료)
    12. [assembly PDF](#assembly-pdf)

---

## Instruction

> 어셈블리의 장점
> 
- OS, 프로세서(CPU), BIOS(basic input output system)에 관련된 interface를 어떻게 프로그램할건지 알게 된다.
- 메모리와 다른 외부 장치에서 data가 어떻게 표현되는지 알게 된다.
- instruction을 어떻게 접근하고 실행하는 지 알게 된다.
- 어떻게 instruction들이 data에 접근하고 처리하는지
- 어떻게 외부 장치에 프로그램이 접근할 수 있는지

에 대해 전반적으로 알게 된다고 한다.

> 어셈블리어는 언제 쓰이는가?
> 
- 어셈블리어를 해석하는 어셈블러는 전처리기, 컴파일러 다음에 실행된다.
    
    ![assembler.png](%5BOuter%20Circle%5D%20Libasm%203fbdf3acfcde4a1ca17be71368492a34/assembler.png)
    
- 어셈블리를 알기 위해선
    - `3개의 section`
    - `레지스터의 종류 및 사용 용도`
    - `다양한 명령어`(operator)와 `operand`(피 연산자)
    - `문법`
    - `스택 프레임`
    - `calling convention`
- 을 기본적으로 알아가야 한다.
- 아래에서 위와 같은 내용을 알아보도록 하자.

## Three section on Assembly

> Data section
> 

```wasm
section.data
```

- 초기화 된 data나 상수값을 선언하는 공간이다.
- runtime동안 변경될 일이 없다.
- 여러 다양한 상수 값(constant value)나 file name, 또는 buffer size를 선언 해도 좋다.

> BSS section
> 

```wasm
section.bss
```

- 변수들을 선언할 때 이용한다.

> Text section
> 

```wasm
section.txt
	global _start

_start:
```

- code(Instrction, data, register 등)가 쓰여지는 공간이다.
- `global _start` 로 구역을 선언해야 하는데, 이는 kernel에게 프로그램 실행이 어디서부터 시작되는지를 알려주기 위함이다.

※ **Mac OS**는 다른 것 같다.

```wasm
section.txt
	global _main

_main:
```

- 위와 같이 **_main**이 분명하게 선언이 되어야 linker가 이를 인식할 수 있는 것 같다.
- 참고
    
    [👋 NASM으로 Hello World 출력하기](https://velog.io/@jbae/nasmhelloworld)
    

## Register Type

1. `General registers`(범용 레지스터)
    - Data registers
    - Pointer registers
    - Index registers
2. `Control registers`
3. `Segment registers`

### General Registers

| 64-bit register | Lower 32 bits | Lower 16 bits | Lower 8 bits | Higher 8 bits |
| --- | --- | --- | --- | --- |
| rax, r0 | eax, r0d | ax, r0w | al, r0b | ah |
| rbx, r1 | ebx, r1d | bx, r1w | bl, r1b | bh |
| rcx, r2 | ecx, r2d | cx, r2w | cl, r2b | ch |
| rdx, r3 | edx, r3d | dx, r3w | dl, r3b | dh |
| rsi, r4 | esi, r4d | si, r4w | sil, r4b |  |
| rdi, r5 | edi, r5d | di, r5w | dil, r5b |  |
| rbp, r6 | ebp, r6d | bp, r6w | bpl, r6b |  |
| rsp, r7 | esp, r7d | sp, r7w | spl, r7b |  |
| r8 | r8d | r8w | r8b |  |
| r9 | r9d | r9w | r9b |  |
| r10 | r10d | r10w | r10b |  |
| r11 | r11d | r11w | r11b |  |
| r12 | r12d | r12w | r12b |  |
| r13 | r13d | r13w | r13b |  |
| r14 | r14d | r14w | r14b |  |
| r15 | r15d | r15w | r15b |  |
- 위에 나온 Register 외에도 128bit의 크기를 가진 16개의 XMM Register도 존재한다고 한다.(XMM0 ... XMM15)
    - 이러한 register는 floating-point 연산에 사용하게 된다.
- r0 ~ r7(rsp)까지는 다른 이름으로 되어있는데, 이를 예약되어 있다 라고 하고, 이는 이미 주요하게 사용되는 역할이  정해져 있기 때문이다.
- 미리 예약된 resgisters에 대해 아래에 정리해본다.

> Data Registers
> 

![data_register.png](%5BOuter%20Circle%5D%20Libasm%203fbdf3acfcde4a1ca17be71368492a34/data_register.png)

- AX - Accmulator Register로 피 연산자의 결과에 대한 누산기로 사용된다. 따라서 return 값을 저장할 때에도 사용된다.
- BX - Base Register로 주소값에 대해 index하는 용도, 또는 데이터의 주소를 가리키는 포인터로 사용할 ㅅ 있다고 한다. SI, DI와 결합하여 index에 사용된다.
- CX - Count Register 로 반복 동작에서 루프에 대해 카운트 할 때 사용할 수 있다.
- DX - Data register로 산술 연산과 I/O 명령에서 사용한다.

> Point Registers
> 

![pointer_register.png](%5BOuter%20Circle%5D%20Libasm%203fbdf3acfcde4a1ca17be71368492a34/pointer_register.png)

- SP - Stack Pointer 로 스택의 최상단을 가리키는 포인터로 사용된다.
- BP - Stack Base Pointer 로 스택의 베이스를 가리키는 포인터로 사용된다.
- IP - Instruction Pointer 로 다음에 시행할 명령어가 저장된 메모리의 주소가 저장된다. 현재 명령어를 모두 실행한다음 IP 레지스터에 저장된 주소에 있는 명령어를 실행한다(특수 레지스터)

> Index Registers
> 

![index_register.png](%5BOuter%20Circle%5D%20Libasm%203fbdf3acfcde4a1ca17be71368492a34/index_register.png)

- SI - Source Index Register 로 소스를 가리키는 포인터 또는 index로 사용된다.
- DI - Deestination Index Register 로 목적지를 가리키는 포인터 또는 Index로 사용된다.

> 새롭게 알게된 사실
> 
- rax, eax, ax 등 같은 row에 있는 레지스터들은 모두 하나의 레지스터이다. rax의 크기가 64bit이고, 그 중 하위 32bit가 eax 레지스터로 접근 가능하고, 마찬가지로 eax의 하위 16비트에 ax로 접근 가능하게 된다.
    - 또한 ax의 상위 8bit는 ah, 하위 8bit는 al 레지스터로 접근할 수 있게 된다.
    - 따라서 `mov eax, 1` 을 하게 되면, eax, ax, al에 1이 들어가 있는 것이다. (ah는 상위8bit라 들어가있지 않다.)

### Control Registers

- 비교 연산 후, Flag의 상태에 따라 제어 흐름을 이동시키기 위해 사용된다.

| Flag | explanation |
| --- | --- |
| Overflow Flag (OF) | 부호있는 산술 연산 후 데이터의 상위 비트 (가장 왼쪽 비트)의 오버플로를 나타낸다. |
| Direction Flag (DF) | 문자열 데이터를 이동하거나 비교할 때 왼쪽 또는 오른쪽 방향을 결정합니다. DF 값이 0이면 문자열 연산은 왼쪽에서 오른쪽 방향을 취하고 값이 1로 설정되면 문자열 연산은 오른쪽에서 왼쪽 방향을 취한다. |
| Interrupt Flag (IF) | 키보드 입력 등과 같은 외부 인터럽트를 무시하거나 처리할지 여부를 결정합니다. 값이 0이면 외부 인터럽트를 비활성화하고 1로 설정하면 인터럽트를 활성화한다. |
| Trap Flag (TF) | 프로세서 작동을 single-step mode로 설정할 수 있습니다. DEBUG 프로그램은 Trap Flag를 설정하므로 한 번에 한 명령 씩 실행할 수 있다. |
| Sign Flag (SF) | 산술 연산 결과의 부호를 보여줍니다. 이 플래그는 산술 연산 후 데이터 항목의 부호에 따라 설정됩니다. 부호는 가장 왼쪽 비트의 높은 순서로 표시됩니다. 양수 결과는 SF 값을 0으로 지우고 음수 결과는 1로 설정한다. |
| Zero Flag (ZF) | 산술 또는 비교 연산의 결과를 나타냅니다. 0이 아닌 결과는 Zero Flag를 0으로 지우고 0 결과는 1로 설정한다. |
| Auxiliary Carry Flag (AF) | 산술 연산 후 비트 3에서 비트 4 로의 캐리를 포함합니다. 특수 산술에 사용됩니다. AF는 1 바이트 산술 연산으로 인해 비트 3에서 비트 4로 캐리가 발생할 때 설정한다.(It contains the carry from bit 3 to bit 4 following an arithmetic operation; used for specialized arithmetic. The AF is set when a 1-byte arithmetic operation causes a carry from bit 3 into bit 4.) |
| Parity Flag (PF) | 산술 연산에서 얻은 결과의 총 1 비트 수를 나타냅니다. 1 비트의 짝수는 패리티 플래그를 0으로 지우고 1 비트의 홀수는 패리티 플래그를 1로 설정한다. |
| Carry Flag (CF) | 산술 연산 후 상위 비트 (가장 왼쪽)에서 0 또는 1의 캐리를 포함합니다. 또한 이동 또는 회전 작업의 마지막 비트 내용도 저장한다. |
- 여기서 많이 사용했던 것이 Carry Flag와 Zero Flag였다.
- Carry flag는 시스템콜 호출 후, 에러가 날 시, Carry Flag의 비트에 1을 넣어준다는 것을 이용해 에러 매니징을 하였고, Zero Flag는 cmp 명령어, 또는 test 명령어의 연산 결과로 0이 들어올 때 jump를 해주는 식으로 조건 제어 흐름을 구성하기 위해 사용하였다.
- 이러한 flag들은 Rflags에 모두 한번에 담겨있다. 총 16비트를 차지하는 Flags Register(Control Register) 이다.
    
    ![스크린샷 2021-08-24 오후 5.50.30.png](%5BOuter%20Circle%5D%20Libasm%203fbdf3acfcde4a1ca17be71368492a34/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2021-08-24_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_5.50.30.png)
    
    - 확인해보기!
        
        ![스크린샷 2021-08-24 오후 5.41.39.png](%5BOuter%20Circle%5D%20Libasm%203fbdf3acfcde4a1ca17be71368492a34/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2021-08-24_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_5.41.39.png)
        
        - 해당 사진에서 일부로 write 시스템콜에 에러가 나게끔 fd값으로 -1을 넣어주었다.
        
        ![스크린샷 2021-08-24 오후 5.42.12.png](%5BOuter%20Circle%5D%20Libasm%203fbdf3acfcde4a1ca17be71368492a34/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2021-08-24_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_5.42.12.png)
        
        - 이 사진은 어셈블리 단위에서 system call을 호출하기 직전의 모습이다. 이부분에서 아래의 빨간색 rflags의 값 변화를 잘 봐야한다.
        
        ![스크린샷 2021-08-24 오후 5.42.37.png](%5BOuter%20Circle%5D%20Libasm%203fbdf3acfcde4a1ca17be71368492a34/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2021-08-24_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_5.42.37.png)
        
        - 시스템 콜을 호출한 직후이다.
        - 여기서 rflags는  206에서 207로 1이 증가하였다.
        - 여기서 알 수 있듯이 **system call이 에러가 날 시**에 flag의 `첫번째 bit인 carry flag가 1로` 바뀌는 것을 알 수 있다.

### Segment Registers

- Segment는 데이터, 코드, 스택을 포함하기 위해 프로그램에 정의되는 특정한 공간이라고 한다.
- 이는 써보질 못해서 중요성을 실감하지 않기에 따로 필요할 때 따로 찾아볼 것.

## 범용 레지스터 리뷰

> RAX(Accumulator)
> 
- 산술/논리 연산을 수행하는 레지스터.
- 함수의 return 값이 저장된다.
- 시스템 콜을 사용할 때, rax에 사용하고자 하는 system call 넘버를 넣고 syscall 을 호출한다.
    
    ```wasm
    mov         rax, 0x02000004     ; set system call for write
    mov         rdi, 1              ; set first argument for write(fd=1)
    mov         rsi, message        ; set second argument for wirte 
    mov         rdx, 13             ; set third argument for write
    syscall                         ; invoke operating system(write)
    ```
    

> RBX(Base)
> 
- 데이터의 주소를 저장하기 위한 용도로 사용된다.

> RCX(Count)
> 
- 문자열이나 루프의 카눝어로 사용 (i와 비슷한 용도)

> RDX(Data)
> 
- 다른 레지스터를 서포트하는 여분의 레지스터.
- I/O 주소를 지정할 때 사용되며, 산술 연산을 수행할 때 보조 레지스터로 사용

> RSI(Source)
> 
- 문자열 관련된 작업을 수행할 때 원본 문자열의 인덱스(위치)로 사용

> RDI(Destination)
> 
- 문자열에 관련된 작업을 수행할 때 목적지 문자열의 인덱스(위치)로 사용

> RSP(Stack)
> 
- 스택의 포인터로 사용

> RBP(Base)
> 
- 스택의 데이터에 접근할 때 데이터의 포인터로 사용
- 함수를 호출한 후, callee 함수는 자신의 지역변수와 받은 인자의 데이터를 모두 rbp 레지스터로 접근 가능하다.
- 예시:
    
    ![스크린샷 2021-08-18 오후 1.57.18.png](%5BOuter%20Circle%5D%20Libasm%203fbdf3acfcde4a1ca17be71368492a34/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2021-08-18_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_1.57.18.png)
    
    - [rbp+8] → 함수가 종료되고 돌아갈 주소이다.
    - [rbp+16] → 첫번째 인자에 접근하게 된다.
    - 위 사진은 e로 시작하는 레지스터(32bit) 이므로 ebp+8로 첫번째 인자에 접근이 가능한 것이다.

> R8 ~ R15
> 
- 64비트 시스템에서 추가된 레지스터이다. 다른 범용 레지스터와 같이 추가적인 데이터 저장 및 전달 시 사용된다.
- 용도가 정해져있지 않아 다양한 용도로 사용된다.

## Opcode(명령어) & Operand

> 조작 명령어
> 
- `nop`: 아무것도 하지 않는 1byte짜리 명령어이다. 4byte 단위로 align하기 위해 사용한다.
- 프로시저
    - `call`: 함수 호출
    - `ret`: call로 호출된 함수를 종료하고 그 다음 명령줄로 이동, 내부 동작으로는 함수호출 당시 rbp에 저장했던 실행 주소(return address)를 꺼내기 위해 rbp를 pop하여 RIP 레지스터(Program Counter)에 집어넣는다.
- 흐름제어
    - `jmp`: 분기(라벨) 실행.(if문 또는 while, for문에서 분기 시 사용)
    - 조건 jmp
        - `je`: cmp A B →  `A = B`일때 특정 라벨로 jmp
        - `jne`: cmp A B → `A ≠ B` 일 때 특정 라벨로 jmp
        - 부호 없는 부등호 연산
            - `ja`: cmp A B → `A > B`
            - `jb`: cmp A B → `A < B`
        - 부호 있는 부등호 연산
            - `jb`: cmp A B → `A > B`
            - `jl`: cmp A B → `A < B`
        - `jae`: cmp A B → `A ≥ B`
        - `jbe`: cmp A B → `A ≤ B`

> 데이터 전송 관련 명령어
> 
- `mov`: 두번째 operand의 값을 첫번째 operand에 대입
    - mov는 다음과 같은 규칙을 따른다.(중요)
        
        1. 피연산자는 **같은 크기**여야 한다.
        
        2. 피연산자는 **모두 메모리 피연산자일 수 없다**.
        
        3. **CS**, **EIP**, **IP**는 도착점 피연산자가 될 수 없다.
        
        4. 즉시값은 세그먼트 레지스터로 이동될 수 없다.
        
        - 출처: [https://clansim.tistory.com/35](https://clansim.tistory.com/35)
- `lea`: 두번째 operand의 주소값을 첫번째 operand에 대입
- `push`: 스택에 값을 넣음
- `pop`: 스택에서 값을 가져옴

> 산술 명령어
> 
- `inc`: 인자의 값을 1증가
- `dec`: 인자의 값을 1 감소
- `add`: 인자2의 값을 인자 1에 더함
- `sub`: 인자 2의 값을 인자 1에서 뺌
- `cmp`: 인자 1, 2의 값을 비교할 때 사용 → 위의 조건 jmp를 바로 아래 둠으로써 분기가 가능함
- `test`: 인자1과 인자2를 AND 연산한다. 이 연산의 결과는 ZF(zero flag)에만 영향을 미치고 operand 자체에는 영향을 미치지 않는다.
    - 보통 rax의 값이 0인지 확인할때 rax 0, 0 이런식으로 사용된다.
    - 만약 TEST의 연산 결과가 0이라면 ZF는 1로 세팅된다.
    - 참고 → [https://velog.io/@hidaehyunlee/libasm-어셈블리-명령어-opcode-정리](https://velog.io/@hidaehyunlee/libasm-%EC%96%B4%EC%85%88%EB%B8%94%EB%A6%AC-%EB%AA%85%EB%A0%B9%EC%96%B4-opcode-%EC%A0%95%EB%A6%AC)

> 추가 instruction
> 
- SYSCALL : 운영체제 루틴 호출
- db : A pseudo-instruction으로 해당 프로그램이 실행되었을 때, 메모리에 있어야 하는 byte들을 선언한다.

> 참고
> 
- [https://coding-factory.tistory.com/650](https://coding-factory.tistory.com/650)

## 어셈블리 문법

> 기본 문법
> 

```wasm
label:    opcode, operand1[, operand2...] ;comments
```

- 위와 같은 구조로 되어있다.
- opcode는 위에서 살펴봤던 instruction(명령어)이다.
- operand는 instruction의 인자로, 어떠한 값 또는 어떤 장소(메모리)로 값을 넣을 것인가에 대한 것이 온다.
- 예제:
    
    ```wasm
    _ft_write:
    						mov    rax, rdx            ;rax에 rdx값을 넣는 것이다.
    ```
    

> AT&T 와 Intel 문법
> 

```wasm
- Opcode: 명령어
- Operand: 피 연산자
```

1.  **숫자 표기 방식**
    - `Intel`: 1, 2, 3, 4, 5 와 같이 그래도 사용
    - `AT&T`: $1, $2, $3, $4, $5와 같이 $를 붙여서 사용
2. **레지스터 표기 방식**
    - `Intel`: eax, ebx, ebp 와 같이 명칭 그대로 사용
    - `AT&T`: %eax, %ebx, %ebp 와 같이 %를 붙여서 사용
3. **메모리 주소 참조 방식 & 크기 지시어**
    - `Intel`: `BYTE[eax]`, `[eax + 8]` 등과 같이 대괄호 안에 레지스터를 써준다.
        - 또한 대괄호 옆에 해당 레지스터의 기본 크기가 아닌 일부분을 참조하고 싶을 땐, 왼쪽의 BYTE와 같이 크기를 지정할 수 있다. → 값을 바로 이 메모리 주소에 넣을려고 한다면, 무조건 크기를 지정해주어야 한다.(레지스터 끼리는 크기가 다를 때만 적어주면 된다.)
        - byte(8비트), word(16비트), dword(32비트), qword(64비트) 등의 크기가 있다.
        - 또한 크기 지시자 옆에 ptr을 붙이는 경우가 있는데, 이는 nasm 등 컴파일마다 다른 것 같다.
        - nasm의 경우 ptr을 붙이지 않고 크기 지시어와 대괄호 만을 이용해서 메모리 주소를 참조하는 것 같다.
    - `AT&T`: `(%eax)`, `0x8(%ebp)`, `-0xc(%ebp)` 와 같이 중괄호를 이용해서 메모리를 참조하게 된다.
        - 앞에 붙는 수들은 각각 **ebp + 8byte 와 ebp - 12byte**라는 뜻이다.
        - 크기 지정은 operator 뒤에 접미사로 b(byte), w(word), l(long) 등을 붙인다.
            - `movw   foo, %ax`
4. **operand 순서**
- eax에 edx값을 옮기고 싶을 때
    - `Intel`: `mov    eax, edx`
    - `AT&T`: `movl    %edx, %eax`

## Intel Calling Convention

> 16바이트 정렬 규칙
> 
- 16바이트 정렬이 되어있어야 한다는 규칙이 있다.
- 이는 call 명령어를 호출하기 전, 스택의 상태를 봐야할 필요성을 제시해준다.
- 16바이트 정렬이 왜 필요한지에 대해선 의문을 갖지 말자.
- 프로그램 자체가 16바이트 정렬이 안되어 있을 시 에러가 나도록 설계가 되어있다는 것만 알고, 무조건 call을 호출 전에 16바이트 정렬을 꼭 해주자.

> prologue와 epilogue
> 
1. Prologue: 함수 내에서 사용할 스택을 설정한다.
    
    ```wasm
    push    rbp             ;return address를 저장한다.
    mov     rbp, rsp        ;rbp를 rsp까지 올리기(스택 초기화)
    sub     rsp, 0x20       ;rsp를 뻄으로써 스택 크기를 늘림(이때 무조건 16바이트 단위로 늘려야 한다.[16바이트 규칙때문])
    ```
    
2. Epilogue: 함수 내에서 사용한 스택을 정리하고 다음 실행되어야 할 주소로 점프한다.
    
    ```wasm
    mov     rsp, rbp        ;rsp를 rbp로 옮김으로써 스택이 크기를 0으로 만들기도 하고, 원래 위치로 복구 되는 것이기도 하다.
    pop     rbp             ;저장했던 return address를 rip레지스터에 넣어주기 위해 pop을 해준다.
    ```
    

> Caller와 Callee의 역할
> 

[x86 calling conventions - Wikipedia](https://en.wikipedia.org/wiki/X86_calling_conventions#Callee-saved_(non-volatile)_registers)

## 기타 궁금한 점

> jmp VS call
> 
- jmp instruction은 PC를 영구적으로 바꾸는 것이다. 즉 다른 메모리 영역에 있는 것에 access하게 되는 것.
- call instruction은 stack에 기존에 있던 것을 남겨두고, 그 다음에 다시 재개 될 수 있도록 하는 것이다.
- call instruction은 program control을 subroutine으로 전송하게 되는데, 이 때 main program으로 돌아올 것을 의도하며 전송하는 것이다. 따라서 sub routine으로 뻗어나가기 전에 다음 instruction에 대한 주소를 stack에 저장하게 된다.
- 더 알아보기
    1. A JMP instruction permanently changes the program counter. A CALL instruction leaves information on the stack so that the original program execution sequence can be resumed.
    2. CALL is an instruction that transfers the program control to a sub routine with the intention of coming back to the main program.
    3. Thus, in CALL 8086 saves the address of the next instruction in to the stack before branching to the sub routine.
    4. At the end of the sub routine, control transfers back to the main program using the return address of the stack. There are two types of CALL: Near CALL and Far CALL.
    5. **INTRA-segment (NEAR) CALL:**
    6. The new subroutine called must be in the same segment (hence intra segment).
    7. The CALL address can be specified directly in the instruction or indirectly through registers or memory locations.
    8. The following sequence is executed for a NEAR CALL-8086 will PUSH current IP in to the stack.Decrement SP by 2.New value loaded in to IP.Control transferred to a sub routine within the same segment.
    9. **INTER-segment (FAR) CALL:**
    10. The new sub routine called is in another segment (hence inter segment).
    11. Here CS and IP both get new values.
    12. The CALL address can be specified directly or through registers or memory locations.
    13. The following sequence is executed for a FAR CALL-PUSH CS in to the stack.Decrement SP by 2.PUSH IP in to the stack.Decrement SP by 2.Load CS with new segment address.Load IP with new offset address.Control transferred to a sub routine in the new segment.
    14. **JMP: INTRA segment (NEAR) JUMP-**The jump address is specified in two ways:
    - **INTRA segment direct jump-** The new branch location is specified directly in the instruction.
    - The new address is calculated by adding the 8 or 16 bit displacement to the IP. The CS does not change.
    - A positive displacement means that the jump is ahead in the program. A negative displacement means that the jump is behind in the program. It is also called relative jump.
    - **INTRA segment indirect jump-** The new branch address is specified indirectly through a register or a memory location. The value in the IP is replaced with the new value. The CS does not change.
    - **INTER segment (FAR) JUMP-**The jump address is specified in two ways:
    - **INTER segment direct jump**The new branch location is specified directly in the instruction. Both CS and IP get new values as this is an inter segment jump.
    - **INTER segment indirect jump**The new branch location is specified indirectly through a register or a memory location. Both CS and IP get new values as this is an inter segment jump.
    - For more information download this pdf [https://www.intel.com/content/dam/www/public/us/en/documents/manuals/64-ia-32-architectures-software-developer-instruction-set-reference-manual-325383.pdf](https://www.intel.com/content/dam/www/public/us/en/documents/manuals/64-ia-32-architectures-software-developer-instruction-set-reference-manual-325383.pdf)

> mov의 좌,우변 동시에 메모리 엑세스가 올 수 없는 이유?
> 
- 참고
    
    [[Assembly] mov와 lea의 차이점](https://velog.io/@kjh3865/movandlea)
    

> MOV vs XOR
> 
- mov instruction은 크기가 3~4라고 한다. 하지만 xor의 크기는 1~2라고 한다.
- 따라서 어떤 register에 0의 값을 대입하고 싶다면, mov보단 xor을 쓰는게 더 효율적이라고 했다.

```wasm
mov    rax, 0

xor    rax, rax ; 같은 게 오면 무조건 0
```

> rcx 말고 다른레지스터로 루프에 증감하며 사용하면 안되나?
> 
- rcx가 하드웨어 적으로 1씩 증감하는데에 유리하다(속도가 빠르다) 애초에 그런 목적으로 설계되있어서..?

> Why push argument in reverse order?
> 
- asm에서 인자를 넣는 순서는 우리가 인자를 쓴 방향의 반대방향부터 넣기 시작한다.
    
    `int sum(a, b, c, d, e);` 가 있으면,
    
    ```wasm
    mov r8, e
    mov rcx, d
    mov rdx, c
    mov rsi, b
    mov rdi, a
    ```
    
    이와 같은 순서로 인자를 넣어준다.
    
- 왜 이런식으로 거꾸로 넣어주는 걸까?
- 찾아본 결과
    
    > callee 입장에서 본다면?
    > 
    - 이는 호출을 하는 사람이 아닌, 호출당한 함수 입장에서 본다면 순서는 달라진다.
    - 말 그대로 스택에는 아래에서부터 쌓이는 거고, e부터 쌓아 올라가서 a까지, 스택에 인자를 미리 쌓아두고, 그다음 함수를 호출하게 되면, a 위부터 쌓이게 된다(정확히는 복귀 번지와 ebp 위에 쌓이게 된다.) 이때 호출된 함수 입장에선, 첫번째 인자는 무조건 위치가 고정되있으므로(ebp 보다 두칸 아래) 쉽게 접근이 가능하다.
        
        ![스크린샷 2021-08-15 오전 11.31.13.png](%5BOuter%20Circle%5D%20Libasm%203fbdf3acfcde4a1ca17be71368492a34/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2021-08-15_%E1%84%8B%E1%85%A9%E1%84%8C%E1%85%A5%E1%86%AB_11.31.13.png)
        

---

## 과제 가이드

> ft_write.s
> 
- 코드
    
    ```wasm
    extern	___error
    
    section	.text
    			global	_ft_write
    
    _ft_write:
    			mov		rax, 0x2000004		; save system call on rax
    			syscall						; invoke routine
    			jc		_error				; if error, jump to _error
    			ret
    
    _error:
    			sub		rsp, 8
    			mov		rdx, rax
    			call	___error
    			mov		[rax], rdx
    			mov		rax, -1
    			add		rsp, 8
    			ret
    ```
    
- 설명
    
    > extern	___error
    > 
    - `___error` 를 써주기 위해 extern으로 선언을 해주었다.
    
    > global	_ft_write
    > 
    - global instruction으로 ft_write를 밖에서 참조할 수 있도록 해주었다.
        - 어셈블리에서는 기본적으로 모든 코드가 private이라고 한다.
        - 다른 모듈이 해당 코드에 접근할 수 있게 하기 위해선 global instruction을 이용해서 심볼에 다른 코드가 접근할 수 있도록 해준다.
        - 이렇게 명시하지 않으면 링커에서 아무런 심볼을 찾을 수 없다는 오류가 발생한다.
        - 출처: [https://velog.io/@jbae/nasmhelloworld](https://velog.io/@jbae/nasmhelloworld)
    - 앞에 언더바를 붙여준 이유는 [https://heeyamsec.tistory.com/21](https://heeyamsec.tistory.com/21) 여기에 잘 나와있다. 간략히 말해서 c에서 호출할 수 있도록 하기 위해서이며 언더바를 붙이지 않은 함수는 어셈블리어끼리만 호출하도록 한다는 의미가 된다.
    
    > _ft_write:
    > 
    - `mov rax, 0x2000004` 는 rax 레지스터에 시스템콜을 담은 것이다. 즉, 0x2000004는 write 시스템 콜을 나타낸다(mac에서는 그러하고 linux에서나 다른 데에선 다르다).
    - `syscall` 을 호출하면 rax에 있는 시스템 콜이 호출된다.
    - `jc _error` : 이부분은 syscall에서 에러 발생 시, Carry Flag(CF) bit 가 1로 변경된다. 다음과 같이 확인할 수 있다.
        
        ![스크린샷 2021-08-20 오전 8.29.27.png](%5BOuter%20Circle%5D%20Libasm%203fbdf3acfcde4a1ca17be71368492a34/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2021-08-20_%E1%84%8B%E1%85%A9%E1%84%8C%E1%85%A5%E1%86%AB_8.29.27.png)
        
        - lldb를 이용해 si 명령어로 어셈 단위로 step over 하고 있다.
        - 현재 syscall을 호출하기 직전의 상황이다.
        - 현재 flag register의 모습은 다음과 같다.
            - 사진 보기
                
                ![스크린샷 2021-08-20 오전 8.31.25.png](%5BOuter%20Circle%5D%20Libasm%203fbdf3acfcde4a1ca17be71368492a34/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2021-08-20_%E1%84%8B%E1%85%A9%E1%84%8C%E1%85%A5%E1%86%AB_8.31.25.png)
                
        - rflags의 값이 206이다. 이는 다음과 같은 flags register table을 참고하자면 CF는 현재 0인 것을 알 수 있다.(맨 첫번째 bit) → CF가 0이면 짝수, 1이면 홀수가 되기 때문에 바로 알 수 있었다.
            
            ![스크린샷 2021-08-20 오전 8.32.46.png](%5BOuter%20Circle%5D%20Libasm%203fbdf3acfcde4a1ca17be71368492a34/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2021-08-20_%E1%84%8B%E1%85%A9%E1%84%8C%E1%85%A5%E1%86%AB_8.32.46.png)
            
        - 이제 si로 syscall을 호출한 후로 넘어가보자.
            
            ![스크린샷 2021-08-20 오전 8.30.34.png](%5BOuter%20Circle%5D%20Libasm%203fbdf3acfcde4a1ca17be71368492a34/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2021-08-20_%E1%84%8B%E1%85%A9%E1%84%8C%E1%85%A5%E1%86%AB_8.30.34.png)
            
        - 현재 flags register의 상황을 다음과 같다.
            - 사진 보기
                
                ![스크린샷 2021-08-20 오전 8.28.21.png](%5BOuter%20Circle%5D%20Libasm%203fbdf3acfcde4a1ca17be71368492a34/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2021-08-20_%E1%84%8B%E1%85%A9%E1%84%8C%E1%85%A5%E1%86%AB_8.28.21.png)
                
        - syscall에 에러가 난 코드를 실행한 거라, CF에 1이 들어와 홀수로 바뀐 것을 알 수 있다.
        - 따라서 jc는 CF가 1일 때 해당 label로 jump하도록 하므로 _error label로 점프해서 그 다음 코드를 실행하게 된다.
        
        > _error:
        > 
        
        ```wasm
        _error:
        			sub		rsp, 8
        			mov		rdx, rax
        			call	___error
        			mov		[rax], rdx
        			mov		rax, -1
        			add		rsp, 8
        			ret
        ```
        
        - `sub rsp, 8` : call ___error를 호출하기 위해선 call instruction 전에 16byte 로 정렬이 되어있어야 한다. 일종의 규칙이라고 한다. 아래 링크를 참고하면 될 것 같다.
            - [https://stackoverflow.com/questions/672461/what-is-stack-alignment](https://stackoverflow.com/questions/672461/what-is-stack-alignment)
            - [http://nickdesaulniers.github.io/blog/2014/04/18/lets-write-some-x86-64/](http://nickdesaulniers.github.io/blog/2014/04/18/lets-write-some-x86-64/) 중 16byte만을 검색해서 찾아볼것.
            - 만약 16byte 정렬을 맞추지 않았다면, call 직후 16byte가 되었는지 확인하는 코드에서 에러가 나게 되어 다음과 같은 오류를 뱉게 된다.
                
                ![스크린샷 2021-08-19 오후 9.08.44.png](%5BOuter%20Circle%5D%20Libasm%203fbdf3acfcde4a1ca17be71368492a34/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2021-08-19_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_9.08.44.png)
                
            - 또한 알고 있어야 할 사실은, call을 하게 되면 현재 가지고 있는 PC(rip 레지스터)가 스택에 저장된다. 즉, rsp를 8만큼 빼서 8byte 만큼 차지하게 된다.(jmp는 아무 영향도 끼치지 않는다. 따라서 je는 스택에 영향 X)
            - 이것으로 생각해봤을 때, main 에서 ft_write를 호출할 때 8byte만큼 스택이 늘어났고, 그 뒤로 스택에 영향을 주는 instruction이 없기 때문에 call ___error를 하는 시점에선 16byte 정렬이 되어있지 않게 된다. 따라서 8byte만큼 더 공간을 늘려줘서 총 rsp 가 16byte 늘어나있게 만들어 정렬이 되게끔 한다.
        - `mov rdx, rax` : rax에는 현재 syscall의 반환값이 들어가 있다. 즉, syscall은 에러일 시, errno의 값을 반환한다. 따라서 이 값을 rdx에 잠시 보관해둔다.(rax는 바로 다음에 또 함수의 리턴값을 받기 위해 사용할 것이기 때문에)
        - `call	___error` : ___error 함수는 errno의 주솟값이 담겨있다. (즉, 이 주소에 1이라는 값을 넣게 되면 errno가 1이 되는 것)
            - 이것이 rax에 들어오게 된다.
        - `mov	[rax], rdx` : rax의 주솟값, 즉 errno의 주솟값에 저장해놨던 errno 값을 넣기 위해 rdx를 대입해주었다.
        - `mov	rax, -1` : ft_write의 반환 값은 -1이어야 하므로 rax에 -1을 대입해주었다.
        - `add    rsp, 8` : ret을 하게 되면 해당 함수를 호출할 때 늘려줬던 스택의 8byte를 다시 빼서 찾아가기 때문에, 이전에 임의로 정렬을 맞추기 위해 늘려줬던 8byte를 다시 줄여줘야 저장했던 rip가 잘 복구된다.
        - 

> ft_read.s
> 
- read는 위에서 0x2000003으로만 시스템콜 넘버를 변경시켜주는 것 외에 모두 동일하다.

> ft_strlen.s
> 
- 코드
    
    ```wasm
    section		.text
    			global	_ft_strlen
    
    _ft_strlen:
    			mov		rcx, 0
    			jmp		loop
    
    loop:
    			cmp		BYTE[rdi + rcx], 0
    			je		end
    			inc		rcx
    			jmp		loop
    
    end:	mov		rax, rcx
    			ret
    ```
    
- 설명
    - `ft_strlen 레이블`에서 루프를 돌기 위해 index로 쓸 rcx를 0으로 초기화 시켜준다.
    - 여기서 잠깐! 왜 루프에 rcx를 써줘야 하는가?!
        - rcx가 1씩 증감하는 연산에 하드웨어적으로 최적화 되어있기 때문에, 루프를 구성할 때 사용하도록 설계된 것이다.
    - `loop 레이블` : 먼저 문자 하나하나를 넘기면서 rcx를 세줄 것이기 때문에 rdi에서 1byte씩 증가하며 루프를 돈다.
    - 이 때 루프 탈출 조건은 문자열이 맨 끝, 즉 널 값을 만날 때이므로 루프를 돌때마다 0과 비교를 해준다.
    - 이때 1byte식 비교해주는 것이므로 메모리 크기 지시자인 BYTE로 메모리를 1byte씩 참조하도록 해주었다.
    - je: 만약 0과 같다면 end로 jump, 아니라면 계속 rcx를 1씩 늘려가며 루프를 진행한다.
    - `end 레이블` : 문자 하나마다 1씩 늘린 rcx를 반환해주기 위해 rax에 담고 ret해준다.

> ft_strcpy.s
> 
- 코드
    
    ```wasm
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
    ```
    
- 설명
    - `loop 레이블`에선 위와 마찬가지로 문자 하나하나 비교해주기 위해 BYTE 크기 지시어를 써주었다.
    - rdi와 rsi에는 인자로 받은 두 문자열이 각각 들어가있다.
    - rsi의 문자열에서 rdi 문자열로 문자를 하나하나 copy해주기 위해 BYTE 크기 지시어를 써서 1byte짜리 레지스터를 매개로 이동을 시켜주었다.
    - `end 레이블`: 널문자까지는 복사가 안되었으므로 루프를 탈출 후에 문자열로 완성시키기 위해 맨 마지막에 널문자를 넣어주었다.
    - 그리고 반환해주기 위해 rax에 넣고 return 해주었다.

> ft_strcmp.s
> 
- 코드
    
    ```wasm
    section		.text
    			global	_ft_strcmp
    
    _ft_strcmp:
    			mov		rcx, 0
    			jmp		loop
    
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
    			xor		rdx, rdx
    			mov		al, BYTE[rdi + rcx]
    			mov		dl, BYTE[rsi + rcx]
    			cmp		rax, rdx
    			jb		plus
    			jl		minus
    			je		equal
    
    plus:
    			sub		rax, rdx
    			ret
    
    minus:
    			sub		rdx, rax
    			mov		rax, rdx
    			neg		rax
    			ret
    equal:
    			xor		rax, rax
    			ret
    ```
    
- 핵심
    - 위 루프의 break 조건:  두 문자열 중 하나라도 끝났으면 break, 두 문자열 비교 중 다른 문자가 나오면 break.
    - break 레이블: 멈춘 시점의 문자끼리 비교를 통해 그 차를 반환
        
        ```wasm
        cmp    rax, rdx
        jb     plus
        jl     minus
        je     equal
        ```
        
    - 위 코드는 다음과 같이 간편히 쓸 수 있다.
        
        ```wasm
        sub    rax, rdx
        ret
        ```
        
    - 첫번째 코드로 쓴 이유는 al과 dl 끼리의 차를 구할 때, 1byte 크기의 레지스터이므로 음수표현이 되질 않아 8바이트짜리 레지스터로 늘렸음에도 그 때는 8바이트 레지스터에까지 연장해서 음수표현이 안된다고 생각을 했었다.(잘 몰랐을 때)
    - 따라서 조건 루프로 길게 쓸 것이 아니라 바로 차를 구한 후 ret하면 훨씬 간단하게 구성할 수 있게 된다.

> ft_strdup.s
> 
- 코드
    
    ```wasm
    section		.text
    			global	_ft_strdup
    			extern	_malloc
    			extern	_ft_strlen
    			extern	_ft_strcpy
    			extern	___error
    
    _ft_strdup:
    			push	rbp         ; prologue
    			mov		rbp, rsp    ; prologue
    			sub		rsp, 20h    ; prologue
    
    			call	_ft_strlen
    
    			push	rdi
    			push	rax
    			mov		rdi, rax
    			add		rdi, 1
    			call	_malloc
    
    			cmp		rax, 0
    			je		error
    
    			mov		rdi, rax
    			pop		rsi
    			pop		rsi
    			call	_ft_strcpy
    			mov		rsp, rbp
    			pop		rbp
    			ret
    
    error:
    			mov		rdx, rax
    			call	___error
    			mov		[rax], rdx
    			mov		rax, 0
    			mov		rsp, rbp    ; epilogue
    			pop		rbp         ; epilogue
    			ret               ; epilogue
    ```
    
- 핵심
    - ft_strdup 레이블에선 call 명령어가 많기 때문에 **16바이트 정렬 규칙**을 조심해야 한다.
    - 따라서 간편하게 하기 위해 strdup함수에서 쓸 스택을 새로이 하기 위해 윗 세줄의 `프롤로그`를 구성했고, 또한 이를 위해 ret전에 `에필로그`를 구성하게 되었다.
    - `malloc 함수`는 에러 발생 시 NULL 포인터를 반환하는 것 뿐만 아니라 전역변수 errno도 설정해 준다.

## 이슈 트래킹

> callee의 역할을 이해하지 못해 발생한 에러
> 
- fsanitize=address 옵션이 없으면 괜찮은데 있으면 segv 에러가 남.
- lldb로 트래킹 해보는데, main함수 맨 마지막에서 에러가 남
    - 이게 코드가 아니라 괄호에서 난다.;;
    - 어셈 단위까지 봤는데, main에서 ret instruction까지 가고 그 이후에 에러가 난다.
- ft_strcmp에서 에러가 나는 것을 확인
    - 주석으로 하나씩 없애가면서 확인
- 하지만 그래도 어려웠던 점이 ft_strcmp는 놔두고 위에 있는 ft_strcpy를 지우니 정상 작동 함,,
- 해결 방법
    - `함수 호출 규약에 따라 Callee(호출당하는 함수)는 RBX, RSI, RDI, RBP를 사용 후 초기값으로 돌려놓아야 한다.`
    - [https://velog.io/@hey-chocopie/Libasm-2.-어셈블리어란-개념-및-특징-정리-명령어-정리](https://velog.io/@hey-chocopie/Libasm-2.-%EC%96%B4%EC%85%88%EB%B8%94%EB%A6%AC%EC%96%B4%EB%9E%80-%EA%B0%9C%EB%85%90-%EB%B0%8F-%ED%8A%B9%EC%A7%95-%EC%A0%95%EB%A6%AC-%EB%AA%85%EB%A0%B9%EC%96%B4-%EC%A0%95%EB%A6%AC)
    - 여기서도 그 이유를 알 수 없다.
    - 하지만 ft_strcmp에서 rbx를 다시 되돌리지 않았기에 이러한 현상이 발생했다.
    - 따라서 위와 같이 초기값으로 되돌려 놓는 것을 염두해 두어야 겠다.
    - rbx 대신 rdx를 쓰니 바로 해결,, → 왜 저렇게 초기값으로 돌려놔야 하는거지...?
    
    ![스크린샷 2021-08-21 오후 10.03.30.png](%5BOuter%20Circle%5D%20Libasm%203fbdf3acfcde4a1ca17be71368492a34/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2021-08-21_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_10.03.30.png)
    
    [x86 calling conventions - Wikipedia](https://en.wikipedia.org/wiki/X86_calling_conventions#Callee-saved_(non-volatile)_registers)
    
    - 여기에 나와있다.
    - rbx, rsp, rbp, r12-15 레지스터 빼고 나머지 레지스터는 전부 caller에서 저장을 해준다. 그래서 저 레지스터의 값을 보존하는 것은 오로지 callee의 책임이라 초기값을 유지하도록 해야 한다.

---

## 참고자료

- 참고 주소
    - 'assembly what is operand?'
        
        [어셈블리(Assembly) 언어_2](https://htst.tistory.com/52)
        
    - prologue & epilogue
        
        [Function prologue - Wikipedia](https://en.wikipedia.org/wiki/Function_prologue)
        
    - intel vs at&t 문법
        
        [Intel and AT&T Syntax](https://imada.sdu.dk/~kslarsen/dm546/Material/IntelnATT.htm)
        
        [[Assembly] 어셈블리어 기초 사용법 & 예제 총정리](https://coding-factory.tistory.com/651?category=990786)
        
    - 어셈블리 디버깅 시 참고
        
        [x32 x64 어셈블리 실행시 메모리 사용 .. 01_셋팅하기](https://yunreka.tistory.com/5?category=601357)
        
    - 비트연산, 논리연산, 형변환 등에 관해
        
        [[SYSTEM SECURITY]7.어셈블리(비트 연산, 논리연산, 형변환)](https://hyanghope.tistory.com/117)
        
    - mov, movzx, movsx, 그리고 mov의 규칙에 관하여
        
        [[어셈블리어] 데이터 전송 명령어 mov, movzx, movsx](https://clansim.tistory.com/35)
        
    - R format, MIPS, i format, Instruction Set Arcitecture(ISA) 등
        
        [명령어 (1) - 개요](https://gusdnd852.tistory.com/180?category=746557)
        
    - libasm tester
        
        [GitHub - cacharle/libasm_test: libasm test](https://github.com/cacharle/libasm_test)
        

## assembly pdf

- pdf
    
    [](http://csys.yonsei.ac.kr/lect/asm/a3-1.pdf)
    
    [](https://www.csie.ntu.edu.tw/~cyy/courses/assembly/12fall/lectures/handouts/lec13_x86Asm.pdf)
    
    [http://courses.ics.hawaii.edu/ReviewICS312/morea/DataSizeAndArithmetic/ics312_datasize.pdf](http://courses.ics.hawaii.edu/ReviewICS312/morea/DataSizeAndArithmetic/ics312_datasize.pdf)
