#include <SPI.h>
#include <Ethernet.h>

int PERIOD = 1000;
int PIN_OUT[] = {3, 5, 6, 9};

int mode[] = {0, 0, 0, 0};
long start_time = 0;

void setup() {
  // Set up serial output
  Serial.begin(9600);

  // Set each LED pin to output mode
  for (int pin_number = 0; pin_number < 4; pin_number++) {
    pinMode(pin_number, OUTPUT);
  }

  mode = {0, 1, 2, 3};
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

  int percent_time_elapsed = 100 *
      ((current_time - start_time) / float(PERIOD));
  
  for (int led_number = 0; led_number < 4; led_number++) {
    run_mode(mode[led_number], led_number, percent_time_elapsed);
  }
}

bool run_mode(int mode, int led_number, int percent_time_elapsed) {
  switch (mode) {
    case 0:
      led_off(led_number);
      break;
    case 1:
      led_on(led_number);
      break;
    case 2:
      blink_slow(led_number, percent_time_elapsed);
      break;
    case 3:
      blink(led_number, percent_time_elapsed);
      break;
    case 4:
      blink_fast(led_number, percent_time_elapsed);
      break;
    default:
      led_off(led_number);
  }
}


////// LED DESIGN FUNCTIONS
bool blink(int led_number, int percent_elapsed) {
  // We toggle on/off every 10% of time elapsed
  blink_base(led_number, percent_elapsed/10);
}

bool blink_fast(int led_number, int percent_elapsed) {
  blink_base(led_number, percent_elapsed/5);
}

bool blink_slow(int led_number, int percent_elapsed) {
  blink_base(led_number, percent_elapsed/25);
}


////// HELPER FUNCTIONS

int blink_base(int led_number, int number) {
  if (even(number)) {
    led_on(led_number);
  } else {
    led_off(led_number);
  }
}
int led_on(int led_number) {
  analogWrite(PIN_OUT[led_number], 255);
}

int led_off(int led_number) {
  analogWrite(PIN_OUT[led_number], 0);
}

bool even(int number) {
  return ((number % 2) == 0);
}
