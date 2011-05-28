name multiplication
page 71
title read the status from logic controller and multiply

initds macro
        mov ax,@data
        mov ds,ax
endm
init8255 macro
        mov al,cw
        mov dx,cr
        out dx,al
endm
inpb macro
        mov dx,pb
        in al,dx
endm

outpa macro
        mov dx,pa
        out dx,al
endm
disp_msg macro msg
        mov ah,9
        lea dx,msg
        int 21h
endm
exit macro
        mov ah,4ch
        int 21h
endm

.model small
.stack
.data
        m1 db 10,13,"set value for X,then press any key $"
        m2 db 10,13,"set value for Y,then press any key $"
        pa equ 120h
        pb equ 121h
        cr equ 123h
        cw db 82h

.code
        initds
        init8255
        disp_msg m1
        mov ah,8
        int 21h
        inpb
        mov bl,al
        disp_msg m2
        mov ah,8
        int 21h
        inpb
        mul bl
        outpa
        call delay
        mov al,ah
        outpa
        exit

delay proc
        mov bx,0fffh
b2:     mov cx,0ffffh
b1:     loop b1
        dec bx
        jnz b2
        ret
delay endp
end




