name set_cursor
page 44
title to move the cursor to the specified position on the screen
.model small
.stack
.data
        msg1 db 10,13,"enter row number(min:00 max:24):$"
        msg2 db 10,13,"enter column number(min:00 max:79):$"
        msg3 db 10,13,"press any key to quit $"
        row db ?
        col db ?
.code
        mov ax,@data
        mov ds,ax
        include c:\masm\disp.mac
        disp msg1
        call read
        mov row,al
        disp msg2
        call read
        mov col,al
        disp msg3
        mov ah,02h
        mov dh,row
        mov dl,col
        int 10h
        mov ah,08h
        int 21h
        mov ah,4ch
        int 21h

read proc
        mov ah,1
        int 21h
        and al,0fh
        mov bl,al
        mov ah,1
        int 21h
        and al,0fh
        mov ah,bl
        aad
        ret
read endp
end



