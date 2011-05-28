name binary
page
title convert a 16-bit binary value to BCD and display left to right and right to left


initds  macro
        mov ax,@data
        mov ds,ax
endm

init8255 macro
        mov al,cw
        mov dx,cr
        out dx,al
endm

outpb macro
        mov dx,pb
        out dx,al
endm

outpc macro
        mov dx,pc
        out dx,al
endm
.model small
.stack
.data
        pb equ 121h
        pc equ 122h
        cr equ 123h
        cw db 80h
        m1 db 10,13,"press any key to exit $"
        msg db 0ffh,0ffh,0ffh,0ffh,?,?,?,?,0ffh,0ffh,0ffh,0ffh
        table db 0c0h,0f9h,0a4h,0b0h,99h,92h,82h,0f8h,80h,98h
        bcd db 5 dup (?)
        num dw 0ffffh
.code
        initds
        init8255
        lea dx,m1
        mov ah,9
        int 21h
        call bin_ssc
start:  mov bh,10
        lea  di,msg
back:   mov si,di
        push bx
        call disp_msg
        call delay
        call kbhit
        pop bx
        inc di
        dec bh
        jnz back
        mov bh,10
        lea di,msg+9
back1:  mov si,di
        push bx
        call disp_msg
        call delay
        call kbhit
        pop bx
        dec di
        dec bh
        jnz back1
        jmp start

bin_ssc proc
        lea si,bcd
        mov ax,num
        mov bx,10000
        call conv
        mov bx,1000
        call conv
        mov bx,100
        call conv
        mov bx,10
        call conv
        mov [si],dl
        lea si,bcd
        lea di,msg+8
        lea bx,table
        mov cx,5
next:   mov al,[si]
        xlat
        mov [di],al
        dec di
        inc si
        loop next
        ret
bin_ssc endp

conv proc
        mov dx,0
        div bx
        mov [si],al
        mov ax,dx
        inc si
        ret
conv endp

kbhit proc
        mov ah,1
        int 16h
        jnz exit
        ret
exit:   mov ah,4ch
        int 21h
kbhit endp

disp_msg proc
        mov cx,4
next_char:      mov bl,8
        mov al,[si]
nxtbit: rol al,1
        outpb
        push ax
        mov al,00h
        outpc
        mov al,11h
        outpc
        pop ax
        dec bl
        jnz nxtbit
        inc si
        loop next_char
        ret
disp_msg endp

delay proc
        mov bx,05ffh
b2:     mov cx,0ffffh
b1:     loop b1
        dec bx
        jnz b2
        ret
delay endp
end







