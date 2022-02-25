 ## Ce fichier est un .xdc modifié pour le CmodA7 rev. B et le projet digital clock

set_property IOSTANDARD LVCMOS33 [get_ports rx]
set_property IOSTANDARD LVCMOS33 [get_ports FULL]
set_property IOSTANDARD LVCMOS33 [get_ports EMPTY]
set_property IOSTANDARD LVCMOS33 [get_ports BTN1]
set_property IOSTANDARD LVCMOS33 [get_ports BTN0]
set_property IOSTANDARD LVCMOS33 [get_ports afficheur_5]
set_property IOSTANDARD LVCMOS33 [get_ports afficheur_4]
set_property IOSTANDARD LVCMOS33 [get_ports afficheur_3]
set_property IOSTANDARD LVCMOS33 [get_ports afficheur_2]
set_property IOSTANDARD LVCMOS33 [get_ports afficheur_1]
set_property IOSTANDARD LVCMOS33 [get_ports afficheur_0]
set_property IOSTANDARD LVCMOS33 [get_ports {SEG[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SEG[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SEG[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SEG[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SEG[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SEG[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SEG[6]}]

## Broches GPIO
set_property PACKAGE_PIN M3 [get_ports {SEG[0]}]
set_property PACKAGE_PIN L3 [get_ports {SEG[1]}]
set_property PACKAGE_PIN A16 [get_ports {SEG[2]}]
set_property PACKAGE_PIN K3 [get_ports {SEG[3]}]
set_property PACKAGE_PIN C15 [get_ports {SEG[4]}]
set_property PACKAGE_PIN H1 [get_ports {SEG[5]}]
set_property PACKAGE_PIN A15 [get_ports {SEG[6]}]
set_property PACKAGE_PIN W6 [get_ports afficheur_0]
set_property PACKAGE_PIN U3 [get_ports afficheur_1]
set_property PACKAGE_PIN U7 [get_ports afficheur_2]
set_property PACKAGE_PIN W7 [get_ports afficheur_3]
set_property PACKAGE_PIN U8 [get_ports afficheur_4]
set_property PACKAGE_PIN V8 [get_ports afficheur_5]
set_property PACKAGE_PIN U2 [get_ports {Leds_etat_1s[0]}]
set_property PACKAGE_PIN U5 [get_ports {Leds_etat_1s[1]}]
set_property PACKAGE_PIN W4 [get_ports {Leds_etat_1s[2]}]
set_property PACKAGE_PIN V5 [get_ports {Leds_etat_1s[3]}]

## Boutons
set_property PACKAGE_PIN A18 [get_ports BTN0]
set_property PACKAGE_PIN B18 [get_ports BTN1]

## LED
set_property PACKAGE_PIN A17 [get_ports EMPTY]
set_property PACKAGE_PIN C16 [get_ports FULL]

##UART
set_property PACKAGE_PIN J17 [get_ports rx]

## DEL RVB
set_property PACKAGE_PIN B16 [get_ports {LD0[0]}]
set_property PACKAGE_PIN C17 [get_ports {LD0[1]}]
set_property PACKAGE_PIN B17 [get_ports {LD0[2]}]

set_property IOSTANDARD LVCMOS33 [get_ports {LD0[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LD0[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LD0[2]}]

set_property IOSTANDARD LVCMOS33 [get_ports {Leds_etat_1s[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Leds_etat_1s[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Leds_etat_1s[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Leds_etat_1s[3]}]

set_property DRIVE 4 [get_ports {Leds_etat_1s[3]}]
set_property DRIVE 4 [get_ports {Leds_etat_1s[2]}]
set_property DRIVE 4 [get_ports {Leds_etat_1s[1]}]
set_property DRIVE 4 [get_ports {Leds_etat_1sEG[0]}]

set_property DRIVE 16 [get_ports {SEG[6]}]
set_property DRIVE 16 [get_ports {SEG[5]}]
set_property DRIVE 16 [get_ports {SEG[4]}]
set_property DRIVE 16 [get_ports {SEG[3]}]
set_property DRIVE 16 [get_ports {SEG[2]}]
set_property DRIVE 16 [get_ports {SEG[1]}]
set_property DRIVE 16 [get_ports {SEG[0]}]
set_property DRIVE 16 [get_ports afficheur_0]
set_property DRIVE 16 [get_ports afficheur_1]
set_property DRIVE 16 [get_ports afficheur_2]
set_property DRIVE 16 [get_ports afficheur_3]
set_property DRIVE 16 [get_ports afficheur_4]
set_property DRIVE 16 [get_ports afficheur_5]
set_property DRIVE 16 [get_ports EMPTY]
set_property DRIVE 16 [get_ports FULL]


