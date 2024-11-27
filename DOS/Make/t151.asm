assume cs:code
stack segment
    db 128 dup (0)
stack ends
data segment
    dw 0,0
data ends
code segment
start:
    mov ax,data
    mov ds,ax

    mov ax,stack
    mov ss,ax
    mov sp,128

    mov ax,0
    mov es,ax

    push es:[9*4]
    pop ds:[0]
    push es:[9*4+2]
    pop ds:[2]

    mov word ptr es:[9*4],offset int9
    mov word ptr es:[9*4+2],cs

    mov ax,0b800h
    mov ds,ax

    mov al,'a'
s:  mov ds:[160*12+2*40],al
    call w
    inc al
    cmp al,'z'
    jna s

    mov ax,data
    mov ds,ax

    mov ax,0
    mov es,ax

    cli
    push ds:[0]
    pop es:[9*4]
    push ds:[2]
    pop es:[9*4+2]
    sti

    mov ax,4c00h
    int 21h

w:  push ax
    push dx
    mov ax,0
    mov dx,10h
w1: sub ax,1
    sbb dx,0
    cmp ax,0
    jne w1
    cmp dx,0
    jne w1

    pop dx
    pop ax
    ret

int9:
    push ax
    push bx
    push ds
    push es

    in al,60h

    mov bx,data
    mov ds,bx

    pushf
    call dword ptr ds:[0]

    cmp al,2
    jne ok

    mov ax,0b800h
    mov es,ax
    inc byte ptr es:[160*12+2*40+1]


ok: pop es
    pop ds
    pop bx
    pop ax
    iret
code ends
end start