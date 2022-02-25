Cmod A7-35T GPIO Demo
Description
This project is a Vivado demo using the Cmod A7's LEDs, RGB LED's, pushbuttons, and USB UART bridge, written in VHDL. When programmed onto the board, the pushbuttons are tied to the LEDs. Every time a button is pressed, the corresponding LED will light up. The RGB LED smoothly transitions between colors.

To use the USB-UART bridge feature of this demo, the Cmod A7-35T must be connected to a serial terminal on the computer it is connected to over the MicroUSB cable. For more information on how to set up and use a serial terminal, such as Tera Term or PuTTY, refer to this tutorial. On reset, the Cmod A7-35T sends the line “CMOD A7 GPIO/UART DEMO!” to the serial terminal. Whenever one of the buttons is pressed, the line “Button press detected!” is sent.
