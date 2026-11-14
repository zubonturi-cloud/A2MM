;
; INITIALIZE A2MM
;
; This program assumes that a synthesizer card is installed in slot #5.
; ($C0D0-$C0DF)
;
94F0-   A9 FF       LDA   #$FF
94F2-   8D D2 C0    STA   $C0D2			; DDRB, Set Port B to output
94F5-   8D D3 C0    STA   $C0D3			; DDRA, Set Port A to output
;
; Control words for managing the PSG selection and bus state are prepared in $A1 through $A3
; Abbreviations such as IAB and DWS appear in the manual for the AY-3-8910 and represent bus states for the CP1610, 
; a family of computer chips from General Instrument (GI)—to which the PSG chip originally belongs.
;
94F8-   A9 00       LDA   #$00			; Select PSG0, IAB
94FA-   85 A1       STA   $A1
94FC-   A9 02       LDA   #$02			; Select PSG0, DWS
94FE-   85 A2       STA   $A2
9500-   A9 03       LDA   #$03
9502-   85 A3       STA   $A3			  ; Select PSG0, INTAK
9504-   20 28 95    JSR   $9528
;
9507-   A9 10       LDA   #$10			; Select PSG1, IAB
9509-   85 A1       STA   $A1
950B-   A9 12       LDA   #$12			; Select PSG1, DWS
950D-   85 A2       STA   $A2
950F-   A9 13       LDA   #$13			; Select PSG1, INTAK
9511-   85 A3       STA   $A3
9513-   20 28 95    JSR   $9528
;
9516-   A9 20       LDA   #$20			; Select PSG2, IAB
9518-   85 A1       STA   $A1
951A-   A9 22       LDA   #$22			; Select PSG2, DWS
951C-   85 A2       STA   $A2
951E-   A9 23       LDA   #$23			; Select PSG2, INTAK
9520-   85 A3       STA   $A3
9522-   20 28 95    JSR   $9528
9525-   4C 70 0C    JMP   $0C70     ; Sets the oscillator volumes to zero for each of three consecutive slots then RTS
;
; NOISE OFF, TONE ON
;
9528-   A5 A1       LDA   $A1			  ; PSG INACTIVE state		(IAB)
952A-   8D D0 C0    STA   $C0D0			;  set to PSG Control port	(VIA Port B)
952D-   A9 07       LDA   #$07			; Select PSG Reg#7 Mixer Control
952F-   8D D1 C0    STA   $C0D1			;  set to PSG BUS		(VIA Port A)
9532-   A5 A3       LDA   $A3			  ; PSG LATCH ADDRESS state	(INTAK)
9534-   8D D0 C0    STA   $C0D0			;  set to PSG Control port	(VIA Port B)
9537-   A5 A1       LDA   $A1			  ; PSG INACTIVE state		(IAB)
9539-   8D D0 C0    STA   $C0D0			;  set to PSG Control port	(VIA Port B)
953C-   A9 38       LDA   #$38			; TURN OFF Noise, Turn ON Tone
953E-   8D D1 C0    STA   $C0D1			;  set to PSG BUS 		(VIA Port A)
9541-   A5 A2       LDA   $A2			  ; PSG WRITE state		(DWS)
9543-   8D D0 C0    STA   $C0D0			;  set to PSG Control port	(VIA Port B)
9546-   A5 A1       LDA   $A1			  ; PSG INACTIVE state		(IAB)
9548-   8D D0 C0    STA   $C0D0			;  set to PSG Control port	(VIA Port B)
954B-   60          RTS
