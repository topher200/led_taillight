'''Control for the taillight with LEDs in it

Usage:
  from farsounder import taillight
  taillight.set_leds(3, FAST_FLASH)
'''
import socket

TAILLIGHT_IP = '192.168.95.44'
TAILLIGHT_PORT = 50001

# LED numbers and Modes for parameters:
LEDS = [0, 1, 2, 3]
OFF, ON, SLOW_FLASH, NORMAL_FLASH, FAST_FLASH, PULSE = range(7)


def set_leds(mode):
  '''Sets all LEDs to the given mode

  mode: One of the mode constants provided by this file. Example: PULSE.
  '''
  client_socket = socket.socket()
  client_socket.connect((TAILLIGHT_IP, TAILLIGHT_PORT))
  message = '%s' % mode
  client_socket.send(message)
  client_socket.close()
