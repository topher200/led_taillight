int TIMEOUT = 30;
int PIN_OUT[] = {3, 5, 6, 9};
int BRIGHTNESS_INCREASE = 5;
int pin_brightness[] = {0, 30, 60, 90};

void setup() {
  // Set up ethernet with DHCP
  byte mac_address[] = { 0x90, 0xA2, 0xDA, 0x00, 0xCD, 0x38 };  
  Ethernet.begin(mac_address);

  // Send the IP address over USB
  Serial.begin(9600);
  Serial.print('ip_address: ');
  Serial.println(localIP());
  
  // Set each LED pin to output mode
  for (int pin_number = 0; pin_number < 4; pin_number++) {
    pinMode(pin_number, OUTPUT);
  }
}

void loop() {
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
