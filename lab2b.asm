name counter
page 97
title BCd up-down and ring counter using logic controller

initds macro
        mov ax,@data
        mov ds,ax
endm
init8255 macro
        mov al,cw
        mov dx,cr
        out dx,al
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
        pa equ 120h
        pb equ 121h
        cr equ 123h
        cw db 82h
        msg1 db 10,13,"1 BCD up-down counter",10,13,"2 Ring counter $"
        msg2 db 10,13,"enter your choice $"
        msg3 db 10,13,"press any key to exit $"
        msg4 db 10,13,"invalid choice",10,13,'$'

.code
        initds
        init8255
        disp_msg msg1
        disp_msg msg2
        mov ah,1
        int 21h
        cmp al,'1'
        je bcd_updn
        cmp al,'2'
        je ring
        disp_msg msg4
        exit
bcd_updn: disp_msg msg3
        mov al,0
up:     outpa
        call delay
        call kbhit
        add al,1
        daa
        cmp al,99h
        jne up
down:   outpa
        call delay
        call kbhit
        add al,099h
        daa
        cmp al,099h
        jne down
        exit
ring:   disp_msg msg3
        mov al,01h
next:   outpa
        call delay
        call kbhit
        rol al,1
        jmp next

delay proc
        mov bx,04ffh
b2:     mov cx,0ffffh
b1:     loop b1
        dec bx
        jnz b2
        ret
delay endp

kbhit proc
        push ax
        mov ah,1
        int 16h
        jnz done
        pop ax
        ret
done:   exit
kbhit endp
end

