;
; SET FREQUECNY
;
; A = Division ratio(Lower 8bit), upper 4bit is in $06
; X = Oscillator Selector, b4,b5 = Chip 0-2, b0,b1 = Channel 0-2
;
9550-   85 A5       STA   $A5			; Save Lower 8-bit of frequecny setting
9552-   8A          TXA   			  ; X= Osc selection
9553-   29 30       AND   #$30
9555-   85 A1       STA   $A1			; PSG Chip Select + PSG INACTIVE(IAB)
9557-   18          CLC   
9558-   69 02       ADC   #$02
955A-   85 A2       STA   $A2			; PSG Chip select + PSG WRITE(DWS)			
955C-   69 01       ADC   #$01
955E-   85 A3       STA   $A3			; PSG Chip select + PSG LATCH ADDRESS(INTAK)
; Determine the two consecutive PSG register numbers for the oscillator
;  The PSG's frequency-divider registers are 12 bits wide, and 
;   there are three sets of two consecutive registers per chip.
9560-   8A          TXA   
9561-   29 03       AND   #$03
9563-   85 A4       STA   $A4
9565-   C9 02       CMP   #$02
9567-   D0 04       BNE   $956D
9569-   E6 A4       INC   $A4
956B-   E6 A4       INC   $A4
956D-   C9 01       CMP   #$01
956F-   D0 02       BNE   $9573
9571-   E6 A4       INC   $A4
9573-   A5 A4       LDA   $A4
9575-   E6 A4       INC   $A4			  ; A=Reg0/2/4, $A4=Reg1/3/5, based on selected Ch
9577-   8D D1 C0    STA   $C0D1			;  set to PSG BUS (Port A)
957A-   A5 A3       LDA   $A3			; PSG Chip select + PSG LATCH ADDRESS(INTAK)
957C-   8D D0 C0    STA   $C0D0			;  set to PSG Control(Port B)
957F-   A5 A1       LDA   $A1			; PSG Chip Select + PSG INACTIVE(IAB)
9581-   8D D0 C0    STA   $C0D0			;  set to PSG Control(Port B)
9584-   A5 A5       LDA   $A5			; OSC Frequency (Lower 8bit)
9586-   8D D1 C0    STA   $C0D1			;  set to PSG BUS (Port A)
9589-   A5 A2       LDA   $A2			; PSG Chip select + PSG WRITE(DWS)
958B-   8D D0 C0    STA   $C0D0			;  set to PSG Control(Port B)
958E-   A5 A1       LDA   $A1			; PSG Chip Select + PSG INACTIVE(IAB)
9590-   8D D0 C0    STA   $C0D0			;  set to PSG Control(Port B)
;
9593-   A5 A4       LDA   $A4			; Next register
9595-   8D D1 C0    STA   $C0D1			;  set to PSG BUS (Port A)
9598-   A5 A3       LDA   $A3			; PSG Chip select + PSG LATCH ADDRESS(INTAK)
959A-   8D D0 C0    STA   $C0D0			;  set to PSG Control(Port B)
959D-   A5 A1       LDA   $A1			; PSG Chip Select + PSG INACTIVE(IAB)
959F-   8D D0 C0    STA   $C0D0			;  set to PSG Control(Port B)
95A2-   A5 06       LDA   $06			; OSC Frequency (Upper 4bit)
95A4-   8D D1 C0    STA   $C0D1			;  set to PSG BUS (Port A)
95A7-   A5 A2       LDA   $A2			; PSG Chip select + PSG WRITE(DWS)
95A9-   8D D0 C0    STA   $C0D0			;  set to PSG Control(Port B)
95AC-   A5 A1       LDA   $A1			; PSG Chip Select + PSG INACTIVE(IAB)
95AE-   8D D0 C0    STA   $C0D0			;  set to PSG Control(Port B)
95B1-   60          RTS   
