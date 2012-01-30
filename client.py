from time import sleep
import socket

def set_pin(pin, mode):
  client_socket = socket.socket()
  client_socket.connect(('192.168.95.44', 50001))
  message = '%s%s' % (pin, mode)
  client_socket.send(message)
  client_socket.close()
  
def set_all(mode):
  for pin in [0, 1, 2, 3]:
    set_pin(pin, mode)
    
def angry_robot():
  set_all(6)


# set_pin(0, 2)
# set_pin(1, 0)
# set_pin(2, 2)
# set_pin(3, 0)

# set_pin(0, 0)
# set_pin(1, 4)
# set_pin(2, 0)
# set_pin(3, 4)

set_all(4)
