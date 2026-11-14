# A2MM
This is a reproduction of a 9-voice synthesizer card that was widely available in the 1980s as a peripheral card for Apple II clones.  
Its core components are a 6522 (VIA) and three AY-3-8910 (PSG) chips.  
The analog circuitry is optimized for the PSG chips manufactured by General Instrument (GI); consequently, it will not function correctly with PSG chips produced by Microchip.  
While the hardware is compatible with software designed for the "VISTA Music Machine 9," the origins of that software remain unclear.  
However, it is almost certain that the "VISTA" software is a modified version of the software originally developed by ALF.  

## Features
In terms of performance, this card had certain drawbacks compared to the MC16—a flagship model from ALF Products—such as the inability to output an accurate 440Hz tone (due to its master clock being tied to the Apple II’s 1.023MHz system clock, whereas the MC16 used a 1.782MHz crystal), a lower 12-bit resolution for its PSG counters, and a D/A converter with only 16 output levels. However, it offered a significant advantage: it could produce 9-voice output using just a single card, a task that would have required three MC16 units.

At the time, ALF Products had already released a successor, the "MC1," which was also capable of nine-voice polyphony on a single card. The MC1, however, did not employ a dedicated crystal oscillator; furthermore, while the SN76489 chip it used featured a specialized noise generator, its frequency resolution was inferior to that of the AY-3-8910. Consequently, in terms of performance, the VISTA card occupied a position between the MC16 and the MC1. Additionally, the card’s VIA (Versatile Interface Adapter) included a built-in timer; when paired with appropriate software, this allowed for continuous, automated playback without the need to reduce the number of active voices—a limitation that would have been necessary on the MC16.

### Performance Comparison

| Feature / Specification | A2MM (VISTA Music Machine 9) | ALF Products MC16 | ALF Products MC1 |
| :--- | :--- | :--- | :--- |
| **Sound Chip(s)** | 3× GI AY-3-8910 (PSG) | 3x (i8253 + DAC-76) | 3× TI SN76489 (DCSG) |
| **Polyphony (per card)** | **9 voices** | 3 voices *(3 cards needed for 9 voices)* | **9 voices** |
| **Master Clock** | 1.023 MHz *(Apple II system clock)* | **1.782 MHz** *(Dedicated crystal)* | Apple II system clock *(No dedicated crystal)* |
| **440Hz Pitch Accuracy** | Inaccurate | **Accurate** | Inaccurate |
| **Frequency Resolution** | 12-bit | **16-bit** | 10-bit |
| **D/A Converter / Volume** | 16 output levels (4-bit) | **256 output levels** | 16 output levels (4-bit) |
| **Noise Generator** | 5-bit period selectable | — | **Pitch-tracked noise generator** |
| **Hardware Timer** | **Yes** *(6522 VIA built-in timer)* | No *(Requires voice reduction for automated playback)* | — |
| **Overall Positioning** | **Mid-range** *(Balanced polyphony & features)* | **Flagship** *(Superior sound quality & pitch)* | **Cost-effective** *(High polyphony, lower pitch resolution)* |

## Structure
The Apple II was designed to facilitate the creation of peripheral cards; one such feature is the DEVICE_SELECT(/DEVSEL) signal.

The Apple II’s expansion slots provide a unique `/DEVSEL` signal for each slot, which is used to manage I/O operations on peripheralcards.  
By utilizing this signal, there is no need for the card itself to decode the upper bits of the address; instead, a 16-byte memory space—determined by the slot number `n` and spanning the range `$C0n0` through `$C0nF`—is made available for controlling the card inserted into that specific slot.  
For slot numbers `n = 0` through `7`, this memory space consists of 16 bytes beginning at the address `$C080 + n * 16`.

On this synthesizer card, a 6522 (VIA) is assigned to this address, and all access to the synthesizer takes place through this VIA. (The PSG is not connected directly to the Apple II bus.)
An 8-bit internal bus, originating from Port A of the VIA, outputs data to the PSG, while two signals from the lower nibble of Port B (PB0 and PB1) directly control the PSG. Two signals from the upper nibble of Port B (PB4 and PB5) are decoded by a 74LS42 to select one of the three PSGs.
PSG control can be performed solely by writing from the VIA to the PSG.
Notably, the IRQ signal from the VIA is connected to the IRQ lines of the peripheral slots. This allows the VIA’s internal timer to trigger periodic interrupts for an Apple II program that is currently running.

The 6522 is a functionally enhanced version of the 6821 (PIA); in addition to two I/O ports with handshaking, it includes features such as two timers and a shift register. 
The control registers of the 6522 are as follows:
• $0 - $1: Port B (ORB/IRB) and Port A (ORA/IRA, with handshake).
• $2 - $3: Data Direction Registers for Port B (DDRB) and Port A (DDRA) (1 = output, 0 = input).
• $4 - $7: Timer 1 counters and latches (T1C-L, T1C-H, T1L-L, T1L-H).
• $8 - $9: Timer 2 low-order byte/counter (T2C-L) and high-order counter (T2C-H).
• $A - $C: Shift Register (SR), Auxiliary Control Register (ACR), and Peripheral Control Register (PCR).
• $D - $E: Interrupt Flag Register (IFR) and Interrupt Enable Register (IER).
• $F: Port A without handshake (ORA/IRA).
