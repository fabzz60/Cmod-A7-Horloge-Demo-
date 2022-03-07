Cmod A7-35T digital clock Demo

for description open   ***CMOD A7 Horloge demo support.pdf***

This project is a Vivado demo using the Cmod A7's LEDs, pushbuttons, and USB UART bridge, written in VHDL. When programmed onto the board, the pushbuttons adjust the digital clock and USB-UART update the clock by writing hour minute second with the keyboard and the enter key to validate the time.

To use the USB-UART bridge feature of this demo, the ***Cmod A7-35T*** must be connected to a serial terminal on the computer it is connected to over the MicroUSB cable. For more information on how to set up and use a serial terminal, such as Tera Term or PuTTY, refer to this tutorial. 
Connect a terminal program with the settings 9600 baud rate, 8 bits, one stop bit, and no parity bit. 

Download and extract the most recent release ZIP archive from this repository's Releases Page.
Open the project in ***Vivado 2020.1*** by double clicking on the included XPR file found at "<archive extracted location>/vivado_proj/Vivado_2021_1_TP_CmodA7_HM.xpr.zip".
 
[<img alt="alt_text" width="40px" src="images/image.PNG" />]  
  
In the Flow Navigator panel on the left side of the Vivado window, click Open Hardware Manager.
Plug the Cmod A7-35T into the computer using a MicroUSB cable.
Open a serial terminal emulator (such as TeraTerm) and connect it to the Cmod A7-35T's serial port, using a baud rate of 9600.
In the green bar at the top of the Vivado window, click Open target. Select Auto connect from the drop down menu.
In the green bar at the top of the Vivado window, click Program device.
In the Program Device Wizard, enter "<archive extracted location>vivado_proj/Vivado_2021_1_TP_CmodA7_HM.runs/impl_1/design_1_wrapper.bit" into the "Bitstream file" field. Then click Program.
The demo will now be programmed onto the Cmod A7-35T. See the Description section of this README to learn how to interact with this demo.
  
Next Steps
This demo can be used as a basis for other projects, either by adding sources included in the demo's release to those projects, or by modifying the sources in the release project.

Check out the Cmod A7-35T's Resource Center to find more documentation, demos, and tutorials.

For technical support or questions, please post on the Digilent Forum.
