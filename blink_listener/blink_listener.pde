#include <SPI.h>
#include <Ethernet.h>

int PERIOD = 1000;
int PIN_OUT[] = {3, 5, 6, 9};
  
long start_time = 0;

void setup() {
  // Set up serial output
  Serial.begin(9600);

  // Set each LED pin to output mode
  for (int pin_number = 0; pin_number < 4; pin_number++) {
    pinMode(pin_number, OUTPUT);
  }
}

void loop() {
  // We run in cycles, each one PERIOD long. If our current time is greater
  // than our start time plus our PERIOD, we've gone an entire PERIOD and need
  // to start the loop again.
  unsigned long current_time = millis();
  if (current_time > start_time + PERIOD) {
    // Start a new loop!
    start_time = current_time;
  }

  int percent_time_elapsed = (current_time - start_time) / PERIOD;
  
  // Run though each output pin
  for (int led_number = 0; led_number < 4; led_number++) {
    blink(led_number, percent_time_elapsed);
  }
}

int led_on(int led_number) {
  analogWrite(PIN_OUT[led_number], 255);
}

int led_off(int led_number) {
  analogWrite(PIN_OUT[led_number], 0);
}

int blink(int led_number, int percent_elapsed) {
  // We toggle on/off every 10% of time elapsed
  if (even(int(percent_elapsed/10))) {
    led_on(led_number);
  } else {
    led_off(led_number);
  }
}

bool even(int number) {
  return ((number % 2) == 0);
}
