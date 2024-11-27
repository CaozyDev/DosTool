;显示一个用0结束的字符串
;(DH)=行号 (DL)-列号 (CL)=颜色
;DS:SI指向字符串首地址
assume cs:code
code segment
install:
        mov ax,cs
        mov ds,ax
        mov si,offset pro_start

        mov ax,0
        mov es,ax
        mov di,200h

        mov cx,offset pro_end - pro_start
        cld
        rep movsb

        mov ds,ax
        mov ax,200h
        mov ds:[7ch*4],ax
        mov ax,0
        mov ds:[7ch*4+2],ax

        mov ax,4c00h
        int 21h
pro_start:
        push ds
        push si
        push bx
        
        mov ax,0b800h
        mov es,ax
        mov bx,0
    s:  mov ax,0
        mov al,[si+bx]
        cmp ax,0
        je ok
        push ax
        ;计算---------
        mov al,dh
        mov ah,160
        mul ah
        mov di,ax

        mov al,dl
        mov ah,2
        mul ah
        add di,ax

        mov al,bl
        mov ah,2
        mul ah
        add di,ax
        ;计算--------

        pop ax
        mov es:[di],al
        mov es:[di+1],cl
        
        add bl,1
        jmp short s

    ok:
        pop bx
        pop si
        pop ds
        iret
pro_end:
        nop
code ends
end install