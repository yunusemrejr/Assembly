org 100h
MOV DX, OFFSET msg
MOV AH, 9H
INT 21H    
ret
msg DB "Hi there this is an example of 8086 assemby code. I'm yunus e.v. $"