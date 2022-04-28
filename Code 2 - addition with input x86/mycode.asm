.MODEL SMALL
.STACK 100H
.DATA
 

 
MSG3  DB      10,13,   10,13,       'enter first number:$'
MSG4    DB     10,13,               'enter second number:$'
MSG8      DB     10,13,    10,13,       '-yunus emre vurgun 2022 |||| the result is:$ '
       



NUM1 DB ?
NUM2 DB ?
RESULT DB ?
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    
    
    MOV AH,1
    INT 21H
    MOV BH,AL
    SUB BH,48
    
    CMP BH,1
    JE ADD
    

    
    
    
 ADD:
 
 
 LEA DX,MSG3  
 MOV AH,9
 INT 21H
 
 MOV AH,1
 INT 21H
 MOV BL,AL
 
 LEA DX,MSG4        
 MOV AH,9
 INT 21H       
 
 
 MOV AH,1
 INT 21H
 MOV CL,AL
 
 ADD AL,BL
 MOV AH,0
 AAA
 
 
 MOV BX,AX
 ADD BH,48
 ADD BL,48
 
 
 LEA DX,MSG8
 MOV AH,9
 INT 21H
 
 MOV AH,2
 MOV DL,BH
 INT 21H
 
 MOV AH,2
 MOV DL,BL
 INT 21H
     
 EXIT:
 
 END MAIN