assume cs:codesg
stack segment
        db 128 dup (0)
stack ends

data segment
        dw 0,0
data ends

codesg segment
install:
        mov ax,stack
        mov ss,ax
        mov sp,128

        mov ax,data
        mov ds,ax
        
        mov ax,0
        mov es,ax

        push es:[9*4]
        pop ds:0
        push es:[9*4+2]
        pop ds:2

        mov ax,offset program
        mov es:[9*4],ax
        mov es:[9*4+2],cx

        mov ax,4c00h
        int 21h
program:
        
codesg ends
end install