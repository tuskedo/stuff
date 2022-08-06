; https://github.com/tuskedo/stuff
; nasm -f elf32 asknumberstack.asm  -o asknumberstack.o
; ld -m elf_i386 asknumberstack.o -o asknumberstack

global _start

section .text


_start:
xor esi, esi

loop:
add esi, 1

mov eax, 4
mov ebx, 1
mov ecx, msgaskcontinue
mov edx, len_msgaskcontinue
int 80h

mov eax, 3
mov ebx, 0
mov ecx, answer
mov edx, 2
int 80h

cmp byte [answer], 0x6E
je show_nums

mov eax, 4
mov ebx, 1
mov ecx, msgtypenum
mov edx, len_msgtypenum
int 80h

sub esp, 0x10

mov eax, 3
mov ebx, 0
mov ecx, num
mov edx, 2
int 80h
mov  al, [num]
mov [esp], al


jmp loop

show_nums:
cmp esi, 0
je exitf
mov eax, 4
mov ebx, 1
mov ecx, esp
mov edx, 2
int 80h

add esp,0x10
sub esi, 1

jmp show_nums
exitf:
mov eax, 1  ; sys_write syscall
mov ebx, 0  ; return_code (0 success)
int 0x80


section .data

msgaskcontinue db 'Do you want to continue? [y/n] '
len_msgaskcontinue: equ $-msgaskcontinue

msgtypenum db 'Type a number from 0-9. '
len_msgtypenum: equ $-msgtypenum

section .bss

answer resb 2
num resb 2
