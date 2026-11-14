;
; A table for converting musical intervals into frequency division ratios
;
; In the PSG, a 1/16 prescaler is placed before the pitch register;
; therefore, with a master clock of 1.023 MHz of Apple II, the frequency 
; division ratio must be set to correspond to 63,937.5 Hz.
;
; As with the one from ALF, this table shows 24 frequency-division ratios, 
; in increments of quarter-tones (50 cents).
;
0A76- 15 09	; 2325	27.499Hz (A0)
0A78- D3 08
0A7A- 92 08
0A7C- 54 08
0A7E- 17 08
0A80- DC 07 
0A82- A3 07
0A84- 6B 07
0A86- 35 07
0A88- 01 07 
0A8A- CD 06 
0A8C- 9C 06 
0A8E- 6C 06
0A90- 3D 06 
0A92- 0F 06 
0A94- E4 05 
0A96- B8 05
0A98- 8F 05 
0A9A- 66 05 
0A9C- 3F 05 
0A9E- 18 05
0AA0- F4 04 
0AA2- CF 04 
0AA4- AD 04
