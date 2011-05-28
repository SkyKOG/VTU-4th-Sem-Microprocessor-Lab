name readecho
page 43
title read a string and display at a specified position after clearing screen
.model small
.stack 40
.data
        myname db 20 dup('$')
        enter db 10,13,"enter  your name: $"
        msg db 10,13,"what is your name? $"
.code
start:  mov ax,@data
        mov ds,ax
        lea dx,enter
        mov ah,09h
        int 21h
        xor ch,ch
        lea si,myname
lp:     mov ah,01h
        int 21h
        cmp al,0dh
        jz cont
        mov [si],al
        inc si
        inc cx
        jmp lp
cont:   mov ah,0fh
        int 10h
        mov ah,00h
        int 10h
        mov ah,02h
        mov bh,00h
        mov dh,20
        mov dl,30
        int 10h
        lea dx,msg
        mov ah,09h
        int 21h
        lea dx,myname
        mov ah,09h
        int 21h
        mov ah,4ch
        int 21h
end

