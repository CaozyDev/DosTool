;完成loop指令的功能，(CX)=循环次数 (BX)=位移
assume cs:code
code segment
install:
        mov ax,cs
        mov ds,ax
        mov si,offset program

        mov ax,0
        mov es,ax
        mov di,200h

        mov cx,pro_end-program
        cld
        rep movsb
        
        mov ax,0
        mov ds,ax

        mov ax,200h
        mov ds:[7ch*4],ax
        mov ax,0
        mov ds:[7ch*4+2],ax

        mov ax,4c00h
        int 21h

program:
        cmp cx,0
        je ok

        mov si,sp
        mov ax,ss:[si]
        add ax,bx
        mov ss:[si],ax

        dec cx

ok:     iret
pro_end:
        nop
code ends
end install