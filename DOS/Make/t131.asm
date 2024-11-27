assume cs:codesg
codesg segment
copy:   
        mov ax,codesg
        mov ds,ax
        mov si,offset pro_start
        mov ax,0
        mov es,ax
        mov di,200h              
        ;设置串传送的基地址和目标地址

        mov cx,offset pro_end - offset pro_start
        ;设置串传送的长度

        cld     
        rep movsb

        mov ax,0
        mov ds,ax
        mov word ptr ds:[7ch*4+2],0
        mov word ptr ds:[7ch*4],200h
        ;修改中断向量表

        mov ax,4c00h
        int 21h

pro_start:
        push si

        ;该程序实现类似jmp near ptr的功能，BX中存放偏移量
        mov ax,sp
        mov si,ax
        add word ptr ss:[si+2],bx

        pop si
        iret

pro_end:
        nop
codesg ends
end copy