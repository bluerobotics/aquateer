AQUATEER
========

Software and hardware for a mermaid conversion kit.

![Aquateer Concept](https://raw.githubusercontent.com/bluerobotics/aquateer/master/images/concept.png "Aquateer Concept")

##Aquateering

The thruster speed is controlled through logical use of the reed switch. A magnet can be used to "tap" the switch like a button. 

* *1 tap:* Thrusters off
* *2-5 taps:* Thrusters on, 5 for full throttle

The taps have to be performed in short succession to be detected properly.

##Hardware

* Arduino (micro)
* Reed Switch + magnet for control through waterproof case
* 10K resistor for reed switch pull-down
* 2 x BlueRobotics T100 Thrusters
* 2 x BlueRobotics basic ESCs

##Software

The software is a very simple Arduino sketch that controls the thrusters via ESCs. Commands are provided through a reed switch for simplicity and to eliminate the need for a waterproof switch.

##Releases
