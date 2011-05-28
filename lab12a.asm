title read system time and display in standard format
page 36
name  time
.model small
.stack
.data
        msg db 10,13,"current time is $"
.code
start:  mov ax,@data
        mov ds,ax
        lea dx,msg
        mov ah,09h
        int 21h
        mov ah,2ch
        int 21h
        mov al,ch
        call disp
        mov dl,":"
        mov ah,2
        int 21h
        mov al,cl
        call disp
        mov ah,4ch
        int 21h
disp proc near
        aam
        add ax,3030h
        mov bx,ax
        mov dl,bh
        mov ah,2
        int 21h
        mov dl,bl
		mov ah,2
        int 21h
        ret
disp endp
end
