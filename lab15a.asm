name file
page 65
title create and delete file

disp_msg macro msg
        lea dx,msg
        mov ah,09h
        int 21h
endm
.model small
.stack 64
.data
        msg1 db 10,13," Enter file name to create $"
        msg2 db 10,13," Enter file name to delete $"
        msg3 db 10,13," 1: Create",10,13,"2: Delete $"
        msg4 db 10,13,"Enter your choice $"
        msg5 db 10,13," Error $"
        file_name db 80 dup(0)
.code
        mov ax,@data
        mov ds,ax
        disp_msg msg3
        disp_msg msg4
        mov ah,1
        int 21h
        cmp al,'1'
        jz create_file
        cmp al,'2'
        jz delete_file
error:  disp_msg msg5
        mov ah,4ch
        int 21h

create_file:    disp_msg msg1
        call read
        mov cx,0
        mov ah,3ch
        lea dx,file_name
        int 21h
        jc error
        mov ah,4ch
        int 21h

delete_file:    disp_msg msg2
        call read
        lea dx,file_name
        mov ah,41h
        int 21h
        jc error
        mov ah,4ch
        int 21h

read proc
        mov ah,01h
        lea si,file_name
back:   int 21h
        cmp al,0dh
        jz done
        mov [si],al
        inc si
        jmp back
done:   ret
read endp
end

