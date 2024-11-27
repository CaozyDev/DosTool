assume cs:codesg
codesg segment
copy:   
        ;安装0号中断处理程序
        mov ax,codesg
        mov ds,ax
        mov si,offset s0
        mov ax,0
        mov es,ax
        mov di,200h
        mov cx,offset pro_end - offset s0
        cld
        rep movsb

        ;设置中断向量表
        mov ax,0
        mov ds,ax
        mov word ptr ds:[0],200h
        mov word ptr ds:[2],0
        
        mov ax,4c00h
        int 21h

s0:     jmp short pro
        ;定义一个字符串，作为后面的显示内容
        db 'Divide Error!'

pro:    
        mov ax,0b800h
        mov ds,ax
        mov di,12*160+36*2

        mov ax,cs
        mov es,ax
        mov si,202h

        mov cx,13
    s:  mov al,es:[si]
        mov ds:[di],al

        add di,2
        inc si
        loop s

        mov ax,4c00h
        int 21h

pro_end:
        nop

codesg ends
end copy