name ascii
page
title read char and display its ASCII
.model small
.stack 64
.data
        msg db 10,13,"enter a  character $"
        char db 0
.code
        mov ax,@data
        mov ds,ax
        lea dx,msg
        mov ah,09h
        int 21h
        mov ah,01h
        int 21h
        mov char,al
        and al,0f0h
        mov cl,04h
        ror al,cl
        mov cl,al
        mov ah,0fh
        int 10h
        mov ah,00h
        int 10h
        mov ah,02h
        mov bh,00h
        mov dh,20
        mov dl,30
        int 10h
        call disp
        mov al,char
        and al,0fh
        mov cl,al
        call disp
        mov ah,4ch
        int 21h

disp proc
        mov dl,cl
        cmp dl,09h
        jle addec
        sub dl,0ah
        add dl,41h
        jmp printno
addec:  add dl,30h
printno:mov ah,02h
        int 21h
        ret
disp endp
end





        



