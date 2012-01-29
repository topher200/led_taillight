#include <SPI.h>
#include <Ethernet.h>

int TIMEOUT = 300;
int PIN_OUT[] = {3, 5, 6, 9};
int BRIGHTNESS_INCREASE = 5;
int pin_brightness[] = {0, 30, 60, 90};

byte MAC_ADDRESS[] = {0x90, 0xA2, 0xDA, 0x00, 0xCD, 0x38};  
byte IP[] = {10, 1, 30, 210};

EthernetServer server = EthernetServer(50001);

void setup() {
  // Set up serial output
  Serial.begin(9600);
  Serial.println("attempting to connect to ethernet");

  // Set up ethernet
  Ethernet.begin(MAC_ADDRESS, IP);
  Serial.print("connected! ip_address: ");
  Serial.println(Ethernet.localIP());
  
  // Set each LED pin to output mode
  for (int pin_number = 0; pin_number < 4; pin_number++) {
    pinMode(pin_number, OUTPUT);
  }
}

void loop() {
  // Print the message if we have a client
  EthernetClient client = server.available();
  if (client) {
    Serial.print("message: ");
    Serial.println(client.read());
  }
  
  // Run though each output pin
  for (int pin_number = 0; pin_number < 4; pin_number++) {
    // Increase the pin's brightness. If it's over 255, drop it back to zero
    pin_brightness[pin_number] =
        pin_brightness[pin_number] + BRIGHTNESS_INCREASE;
    if (pin_brightness[pin_number] > 255) {
      pin_brightness[pin_number] = 0;
    }
    
    // Write the brightness to the pin
    analogWrite(PIN_OUT[pin_number], pin_brightness[pin_number]);    
  }
  
  delay(TIMEOUT);                            
}

void generate_pulse() {
}

