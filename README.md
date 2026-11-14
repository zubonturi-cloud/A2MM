# A2MM
This is a reproduction of a 9-voice synthesizer card that was widely available in the 1980s as a peripheral card for Apple II clones.  
Its core components are a 6522 (VIA) and three AY-3-8910 (PSG) chips.  
The analog circuitry is optimized for the PSG chips manufactured by General Instrument (GI); consequently, it will not function correctly with PSG chips produced by Microchip.  
While the hardware is compatible with software designed for the "VISTA Music Machine 9," the origins of that software remain unclear.  
However, given that it can also play music files intended for entirely different hardware—specifically, systems from ALF Products—it is almost certain that the "VISTA" software is a modified version of the software originally developed by ALF.  

## Features
In terms of performance, this card had certain drawbacks compared to the MC16—a flagship model from ALF Products—such as the inability to output an accurate 440Hz tone (due to its master clock being tied to the Apple II’s 1.023MHz system clock, whereas the MC16 used a 1.782MHz crystal), a lower 12-bit resolution for its PSG counters, and a D/A converter with only 16 output levels. However, it offered a significant advantage: it could produce 9-voice output using just a single card, a task that would have required three MC16 units.

At the time, ALF Products had already released a successor, the "MC1," which was also capable of nine-voice polyphony on a single card. The MC1, however, did not employ a dedicated crystal oscillator; furthermore, while the SN76489 chip it used featured a specialized noise generator, its frequency resolution was inferior to that of the AY-3-8910. Consequently, in terms of performance, the VISTA card occupied a position between the MC16 and the MC1. Additionally, the card’s VIA (Versatile Interface Adapter) included a built-in timer; when paired with appropriate software, this allowed for continuous, automated playback without the need to reduce the number of active voices—a limitation that would have been necessary on the MC16.

### Performance Comparison

| Feature / Specification | A2MM (VISTA Music Machine 9) | ALF Products MC16 | ALF Products MC1 |
| :--- | :--- | :--- | :--- |
| **Sound Chip(s)** | 3× GI AY-3-8910 (PSG) | Custom / Discrete logic | 3× TI SN76489 (DCSG) |
| **Polyphony (per card)** | **9 voices** | 3 voices *(3 cards needed for 9 voices)* | **9 voices** |
| **Master Clock** | 1.023 MHz *(Apple II system clock)* | **1.782 MHz** *(Dedicated crystal)* | Apple II system clock *(No dedicated crystal)* |
| **440Hz Pitch Accuracy** | Inaccurate | **Accurate** | Inaccurate |
| **Frequency Resolution** | 12-bit | **Higher than 12-bit** | Lower than AY-3-8910 |
| **D/A Converter / Volume** | 16 output levels (4-bit) | **Higher resolution** | 16 output levels (4-bit) |
| **Noise Generator** | Standard (built into AY-3-8910) | — | **Specialized noise generator** |
| **Hardware Timer** | **Yes** *(6522 VIA built-in timer)* | No *(Requires voice reduction for automated playback)* | — |
| **Overall Positioning** | **Mid-range** *(Balanced polyphony & features)* | **Flagship** *(Superior sound quality & pitch)* | **Cost-effective** *(High polyphony, lower pitch resolution)* |
