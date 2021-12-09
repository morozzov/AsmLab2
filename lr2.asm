section .bss
array resb 6
range resb 2
result resb 7

section .text
global _start

_start:
mov eax, 3
mov ebx, 2
mov ecx, array
mov edx, 7
int 0x80

mov eax, 3
mov ebx, 2
mov ecx, range
mov edx, 3
int 0x80

mov eax, 0	;current array element
mov ecx, 0	;current array position
mov edx, 0	;current result position

cycle:
mov al, array[ecx]
test al, BYTE 1
jz even
inc ecx
cmp ecx, 6
je end
jne cycle

even:
cmp al, range[0]
jl not_in_range

cmp al, range[1]
jg not_in_range

mov result[edx], al
inc edx
inc ecx
cmp ecx, 6
je end
jne cycle

not_in_range:
inc ecx
cmp ecx, 6
je end
jne cycle

end:
inc edx
mov result[edx], BYTE 0x0A
inc edx

mov eax, 4
mov ebx, 1
mov ecx, result
int 0x80

mov eax, 1
mov ebx, 0
int 0x80
