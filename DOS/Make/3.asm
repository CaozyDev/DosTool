assume cs:code
data segment
        db 16 dup (0)
data ends
stack segment
        dw 16 dup (0)
stack ends
code segment
start:  mov ax,stack
        mov ss,ax
        mov sp,16

        mov ax,data
        mov ds,ax 
        mov si,0
        mov ax,12666
        call dtoc
        mov si,0

        mov dh,11       ;行号
        mov dl,25       ;列号
        mov cl,2        ;颜色
        call show_str

        mov ax,4c00h
        int 21h
show_str:
        mov ax,0b800h
        mov es,ax
        mov bx,0
s:      push cx
        mov ch,0
        mov cl,[si]
        jcxz ok
        pop cx

        mov al,160
        mul dh
        mov di,ax
        push dx
        mov dh,0
        add di,dx
        add di,dx
        pop dx

        mov al,[si]
        mov byte ptr es:[di+bx],al
        inc bx
        mov byte ptr es:[di+bx],cl
        inc bx
        inc si
        jmp short s

ok:     ret

dtoc:   push ax
        push bx
        push cx
        push dx
        push si
        push di         ;寄存器入栈，子程序调用结束后出栈，防止寄存器冲突

        mov si,0        ;si此处充当计数器
    s1: mov dx,0
        mov bx,10
        div bx
        mov cx,dx
        jcxz order
        add dx,30h
        push dx
        inc si
        jmp short s1

order:  mov di,0
        mov cx,si
    s2: pop ax
        mov byte ptr ds:[di],al
        inc di
        loop s2

        pop di
        pop si
        pop dx
        pop cx
        pop bx
        pop ax          ;寄存器出栈
        ret             ;子程序返回
code ends

end start