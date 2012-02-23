# LED Taillight on Arduino

## Introduction
The LED Taillight is a resurrected taillight (yes, from a car) that has been
outfitted with new LEDs and an ethernet Arduino. Users can cause the Taillight
to blink again by sending messages to the Arduino's network server.

## Blog post
A blog post explaining the origin of the project is available here:
http://blog.tophernet.com/2012/02/hardware-hackathon-arduino-led.html. If
you're still confused, it even has pictures.

## Network Spec
Our network server listens on 192.168.95.44:50001. Open a socket to that port
to send messages to the Taillight.

Clients talking to our network control the LED status through a character
stream message consisting of a four one-digit integers. Each integer
represents the new mode for one of the LEDS.

### Modes
> 0: Off
>
> 1: Steady on
>
> 2: Blink slowly
>
> 3: Blink normal speed
>
> 4: Blink fast
>
> 5: Pulse

### Example
For example, if I wished to pulse all the LEDs, I would send the message
'5555'.

Turning on LEDs #0 and #1, pulsing #2, and turning off #3 would be '1150'.


## Changelog 
v1.01: New network spec - one must send new modes for all LEDs with every
message, instead of setting each one at a time.

v1.00: Initial release!


## Source
The source for this project is available on Github:
https://github.com/topher200/led_taillight


## License
Copyright Topher Brown <topher200@gmail.com>, 2012. Released under the MIT 
license.
