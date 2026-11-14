;
; SET AMPLITUDE
;
; A = Amplitude 0-255
; Y = Oscillator Selector, b4,b5 = Chip 0-2, b0,b1 = Channel 0-2
;
95C0-   4A          LSR   			  ; A=Amplitude -> 1/16
95C1-   4A          LSR   
95C2-   4A          LSR   
95C3-   4A          LSR   
95C4-   85 A5       STA   $A5     ; Save amplitude for PSG
;
95C6-   98          TYA   			  ; Y=PSG selection by b4, b5
95C7-   29 30       AND   #$30
95C9-   85 A1       STA   $A1			; PSG Chip Select + PSG INACTIVE(IAB)
95CB-   18          CLC   
95CC-   69 02       ADC   #$02
95CE-   85 A2       STA   $A2			; PSG Chip select + PSG WRITE(DWS)
95D0-   69 01       ADC   #$01
95D2-   85 A3       STA   $A3			; PSG Chip select + PSG LATCH ADDRESS(INTAK)
;
95D4-   98          TYA   
95D5-   29 03       AND   #$03			; OSC Select 0..2
95D7-   18          CLC   
95D8-   69 08       ADC   #$08			; Register address 8..10
95DA-   8D D1 C0    STA   $C0D1			;  set to PSG BUS (Port A)
95DD-   A5 A3       LDA   $A3			; PSG Chip select + PSG LATCH ADDRESS(INTAK)
95DF-   8D D0 C0    STA   $C0D0			;  set to PSG Control(Port B)
95E2-   A5 A1       LDA   $A1			; PSG Chip Select + PSG INACTIVE(IAB)
95E4-   8D D0 C0    STA   $C0D0			;  set to PSG Control(Port B)
95E7-   A5 A5       LDA   $A5			; Amplitude (4bit)
95E9-   8D D1 C0    STA   $C0D1			;  set to PSG BUS (Port A)
95EC-   A5 A2       LDA   $A2			; PSG Chip select + PSG WRITE(DWS)
95EE-   8D D0 C0    STA   $C0D0			;  set to PSG Control(Port B)
95F1-   A5 A1       LDA   $A1			; PSG Chip Select + PSG INACTIVE(IAB)
95F3-   8D D0 C0    STA   $C0D0			;  set to PSG Control(Port B)
95F6-   60          RTS   
