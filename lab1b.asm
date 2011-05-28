name parity
page 65
title reading from logic controller and display parity
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
.code
        initds
        init8255
        inpb
        mov bl,al
        mov bh,0
        mov cx,8
nextbit:ror al,1
        jnc next
        inc bh
next:   loop nextbit
        mov al,bl
        or al,al
        jpe dispff
        mov al,00h
disp:   outpa
        call delay
        mov al,bh
        outpa
        exit
dispff: mov al,0ffh
        jmp disp

delay proc
        mov ax,07ffh
b2:     mov cx,0ffffh
b1:     loop b1
        dec ax
        jnz b2
        ret
delay endp
end



