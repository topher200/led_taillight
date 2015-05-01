'''Control for the taillight with LEDs in it

Usage:
  import led_taillight.controller as taillight
  taillight.set_leds(taillight.FAST_FLASH)
'''
import socket

TAILLIGHT_IP = '192.168.95.44'
TAILLIGHT_PORT = 50001

# LED numbers and Modes for parameters:
OFF, ON, SLOW_FLASH, NORMAL_FLASH, FAST_FLASH, PULSE = range(6)


def set_leds(mode):
  '''Sets all LEDs to the given mode

  mode: One of the mode constants provided by this file. Example: PULSE.
  '''
  message = '%s%s%s%s' % (mode, mode, mode, mode)
  _send_message(message)


def _send_message(message):
  client_socket = socket.socket()
  client_socket.connect((TAILLIGHT_IP, TAILLIGHT_PORT))
  client_socket.send(message.encode('utf-8'))
  client_socket.close()
