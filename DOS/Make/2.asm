assume cs:codesg,ss:stacksg
stacksg segment
        dw 0,0,0,0,0,0,0,0
stacksg ends
data segment
        dw 0,0
data ends
codesg segment
start:  
        mov ax,stacksg
        mov ss,ax
        mov sp,0

        mov ax,data
        mov ds,ax

        mov ax,4240h    ;被除数低16位
        mov dx,000fh     ;被除数高16位
        mov cx,0ah
        call divdw

        mov ax,4c00h
        int 21h

divdw:  push ax

        mov ax,dx
        mov dx,0
        div cx          ;商在AX中,余数在DX中

        mov bx,ax       ;商在BX中
        pop ax
        div cx
        push dx
        mov dx,bx

        pop cx

        ret
codesg ends
end start