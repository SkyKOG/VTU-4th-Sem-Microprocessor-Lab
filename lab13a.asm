name counter
page 58
title decimal up counter from 00 to 99
.model small
.stack
.data
        msg db 10,13,"press any key to quit $"
.code
        mov ax,@data
        mov ds,ax
        lea dx,msg
        mov ah,09h
        int 21h
        mov al,0
nextnum:push ax
        call setcursor
        call disp
        call delay
        mov ah,01h
        int 16h
        jnz exit
        pop ax
        add al,1
        daa
        cmp al,0
        jnz nextnum
exit:   mov ah,4ch
        int 21h
setcursor proc
        mov ah,02h
        mov dh,12
        mov dl,40
        int 10h
        ret
setcursor endp
disp proc
        mov bl,al
        mov dl,al
        mov cl,4
        shr dl,cl
        add dl,30h
        mov ah,2
        int 21h
        mov dl,bl
        and dl,0fh
        add dl,30h
        int 21h
        ret
disp endp
delay proc
        mov bx,00ffh
b2:     mov cx,0ffffh
b1:     loop b1
        dec bx
        jnz b2
        ret
delay endp
end

