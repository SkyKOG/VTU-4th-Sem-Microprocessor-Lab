name factorial
page 34
title factorial of positive integer using recursive procedure
.model small
.stack
.data
        num dw 4
        result dw ?
.code
        mov ax,@data
        mov ds,ax
        mov ax,01
        mov cx,num
        cmp cx,0
        je exit
        mov bx,cx
        call fact
exit:   mov result,ax
        int 3
        align 16

fact proc near
        cmp bx,1
        jz st01
        push bx
        dec bx
        call fact
        pop bx
        mul bx
        ret
st01:   mov ax,1
        ret
fact endp
end


