name nCr
page 47
title compute nCr using recursive procedure
.model small
.stack
.data
        n dw 9
        r dw 4
        ncr dw 0
.code
        mov ax,@data
        mov ds,ax
        mov ax,n
        mov bx,r
        call ncrpro
        int 3
        align 16

ncrpro proc near
        cmp bx,ax
        je res1
        cmp bx,0
        je res1
        cmp bx,1
        je resn
        dec ax
        cmp bx,ax
        je incr
        push ax
        push bx
        call ncrpro
        pop bx
        pop ax
        dec bx
        push ax
        push bx
        call ncrpro
        pop bx
        pop ax
        ret
res1:   inc ncr
        ret
incr:   inc ncr
resn:   add ncr,ax
        ret
ncrpro endp
end




