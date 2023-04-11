.include "/sdcard/Download/FWC/gate2/m328Pdef.inc"



ldi r17, 0b11110011 ;identifying output pins 2,3
out DDRD,r17 

ldi r17,0b11111111  ;  activating pull ups
out PORTD,r17

ldi r16,0b00000001
out DDRB,r16            ;declaring 8th pin as output

start:                   ;loop for reading the input from pins 2,3 continously

        in r17,PIND             ;reading the data from pins 2,3
;Taking q
        ldi r24,0b00000100
        mov r18,r17
        and r18,r24
        ldi r25,0b00000010
        loopq:  lsr r18
        dec r25
        brne    loopq
        .DEF q = r18
;Taking p
        mov r19,r17
        ldi r24,0b00001000
        and r19,r24
        ldi r25,0b00000011
        loopp:  lsr r19
        dec r25 
        brne loopp

        .DEF p = r19
        
        ldi r21,0x00
        ldi r22,0x00
        
        .DEF T1 = r21
        .DEF T2 = r22
        

        ;POS expression
        ;F =q'+p'(p+q)  

        mov T1,q 
	mov T2,p
	mov R1,q
	mov R2,p
        com R1
	com R2
	or T1,T2
	and T1,R2
	or T1,R1
       
      
        out PORTB,T1
       

        rjmp start
