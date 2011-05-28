name add_sub
page 118
title scan 3*8 keypad and simulate add subtract operation
.model small
.stack
.data
        row db 1
        col db 1
        msg1 db 10,13,"enter the first number : $"
        msg2 db 10,13,"enter the second number : $"
        msg3 db 10,13,"enter the operator : $"
        m db 10,13,"result is : $"
        key1 db ?
        op db ?
.code
        mov ax,@data
        mov ds,ax

        mov dx,123h
        mov al,92h
        out dx,al

        lea dx,msg1
        mov ah,09h
        int 21h
        call read
        call disp

        mov key1,cl
        mov ah,01h
        int 21h

        lea dx,msg3
        mov ah,09h
        int 21h
        call read
        call disp

        mov op,cl
        mov ah,01h
        int 21h

        lea dx,msg2
        mov ah,09h
        int 21h
        call read
        call disp

        cmp op,0bh
        jne subt
        add key1,cl
        jmp next
subt:   sub key1,cl
next:   mov cl,key1
        lea dx,m
        mov ah,09h
        int 21h
        call disp
        mov ah,4ch
        int 21h

read proc
start:  mov bh,03h
        mov row,01
        mov cl,00h
        mov al,01h
        mov bl,al

back:   mov dx,122h
        out dx,al

        mov dx,120h
        in al,dx

        cmp al,00h
        jnz key_found
        add cl,08h
        mov al,bl
        rol al,01h
        mov bl,al
        add row,01
        dec bh
        jnz back
        jmp start

key_found:ror al,1
        jc exit
        inc cl
        inc col
        jmp key_found
exit:   ret
read endp

disp proc
        mov dl,cl
        and dl,0f0h
        mov al,dl
        ror al,01
        ror al,01
        ror al,01
        ror al,01
        mov dl,al
        cmp dl,09
        jbe next2
next2:  add al,30h
        mov dl,cl
        and dl,0fh
        mov ah,02h
        cmp dl,9
        jbe next1
        add dl,7
next1:  add dl,30h
        int 21h
        ret
disp endp
end

