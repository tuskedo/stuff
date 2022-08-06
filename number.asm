; https://github.com/tuskedo/stuff
; nasm -f elf32 number.asm  -o number.o
; ld -m elf_i386 number.o -o number

global _start

section .text
_start:

mov ecx, msgaskfirst
mov edx, len_msgaskfirst
call print_screen

mov ecx, num1
mov edx, 2
call read_keyboard

mov ecx, msgasksecond
mov edx, len_msgasksecond
call print_screen

mov ecx, num2
mov edx, 2
call read_keyboard

mov al, [num1]
cmp byte al, [num2]

jg firstbigger
jb secondbigger
je equal

firstbigger:
mov ecx, msgfirstbigger
mov edx, len_msgfirstbigger
call print_screen
jmp exitf

secondbigger:
mov ecx, msgsecondbigger
mov edx, len_msgsecondbigger
call print_screen
jmp exitf

equal:
mov ecx, msgequal
mov edx, len_msgequal
call print_screen
jmp exitf

exitf:
mov eax, 1
mov ebx, 0
int 0x80

;inputs: ecx address location of bytes to print | edx number of bytes to print
;modified: eax, ebx
print_screen:
mov eax, 4
mov ebx, 1
int 80h
ret

;inputs: typed bytes will be stored at ecx address | edx max bytes to store
;modified: eax, ebx
read_keyboard:
mov eax, 3
mov ebx, 0
int 80h
ret
section .data

msgaskfirst db 'Write first number from 0-9 '
len_msgaskfirst: equ $-msgaskfirst

msgasksecond db 'Write second number from 0-9 '
len_msgasksecond: equ $-msgasksecond

msgfirstbigger db 'First number is bigger'
len_msgfirstbigger: equ $-msgfirstbigger

msgsecondbigger db 'Second number is bigger'
len_msgsecondbigger: equ $-msgsecondbigger

msgequal db 'Numbers are equal'
len_msgequal: equ $-msgequal


section .bss
num1 resb 2
num2 resb 2
