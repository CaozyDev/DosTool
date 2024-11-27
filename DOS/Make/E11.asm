assume cs:codesg

datasg segment
        db "Beginner's All-purpose Symbolic Instruction Code.",0
datasg ends

codesg segment
begin:  
        mov ax,datasg
        mov ds,ax
        mov si,0
        call letterc

        mov ax,4c00h
        int 21h

letterc:
        push ax
        push bx
        push cx
        push dx
        push si
        push di
        
    s:  mov cl,[si]
        mov ch,0
        jcxz ok         ;如果为0，跳转到ok标号处

        cmp byte ptr [si],97
        jb next
        cmp byte ptr [si],122
        ja next         ;判断是否为小写

        mov al,[si]
        sub al,32
        mov [si],al     ;转大写

    next:
        inc si
        jmp short s
        
    ok: pop di
        pop si
        pop dx
        pop cx
        pop bx
        pop ax
        
        ret

codesg ends
end begin