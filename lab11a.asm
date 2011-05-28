name fibonacci
page 37
title genereate first n fibonacci number
.model small
.stack
.data
        x db "enter 1st number $"
        y db 10,13,"enter 2nd number $"
        z db 10 dup()
.code
        mov ax,@data
        mov ds,ax
        lea si,z
        lea dx,x
        mov ah,09h
        int 21h
        mov ah,01h
        int 21h
        sub al,30h
        mov [si],al
        lea dx,y
        mov ah,09h
        int 21h
        mov ah,01h
        int 21h
        sub al,30h
        mov [si+1],al
        mov cx,08
up:     mov al,[si]
        inc si
        add al,[si]
        daa
        mov [si+1],al
        loop up
        int 3
        align 16
end

