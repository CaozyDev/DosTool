assume cs:codesg,ds:data
data segment
   db 'Hello, DaDuanDuan.'
data ends

codesg segment
   mov ax,0b800h
   mov ds,ax
   mov si,0
   mov ax,cs
   mov es,ax
   mov di,data
   mov cx,18
s:
   mov al,es:[di]
   mov ds:[si],al
   loop s
   mov ax,4c00h
   int 21h
codesg ends
end
