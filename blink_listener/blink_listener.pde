#include <SPI.h>
#include <Ethernet.h>

byte MAC_ADDRESS[] = {0x90, 0xA2, 0xDA, 0x00, 0xCD, 0x38};  
byte IP[] = {192, 168, 95, 44};
int PERIOD = 4000;  // ms
int PIN_OUT[] = {3, 5, 6, 9};

int mode[] = {0, 0, 0, 0};
long start_time = 0;

EthernetServer server = EthernetServer(50001);


void setup() {
  // Set up serial output
  Serial.begin(9600);
  
  // initialize the ethernet device
  Ethernet.begin(MAC_ADDRESS, IP);

  // start listening for clients
  server.begin();

  // Set each LED pin to output mode
  for (int pin_number = 0; pin_number < 4; pin_number++) {
    pinMode(pin_number, OUTPUT);
  }
}

void loop() {
  // if an incoming client connects, there will be bytes available to read:
  EthernetClient client = server.available();
  if (client) {
    if (client.available() >= 2) {
      int read_pin = get_single_digit_int(client);
      Serial.print("pin: ");
      Serial.println(read_pin);
      int read_mode = get_single_digit_int(client);
      Serial.print("mode: ");
      Serial.println(read_mode);
      if (read_pin >= 0) {
        if (read_pin < 4) {
          if (read_mode >= 0) {
            if (read_mode <= 6) {
              mode[read_pin] = read_mode;
            }
          }
        }
      }
    }
    client.stop();
  }
  
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
    case 5:
      pulse(led_number, percent_time_elapsed);
      break;
    default:
      led_off(led_number);
      break;
  }
}


////// LED DESIGN FUNCTIONS
bool blink(int led_number, int percent_elapsed) {
  // We toggle on/off every 10% of time elapsed
  blink_base(led_number, percent_elapsed/2);
}

bool blink_fast(int led_number, int percent_elapsed) {
  blink_base(led_number, percent_elapsed);
}

bool blink_slow(int led_number, int percent_elapsed) {
  blink_base(led_number, percent_elapsed/5);
}

bool pulse(int led_number, int percent_elapsed) {
  // Take the percentage of the sin wave we've completed, scaled up to 10-60%
  // 3.14 * 2 = 6.28
  led_on(led_number, int(((sin(percent_elapsed/100.0 * 6.28) + 1) * 25) + 10));
}


////// HELPER FUNCTIONS

bool blink_base(int led_number, int number) {
  if (even(number)) {
    led_on(led_number);
  } else {
    led_off(led_number);
  }
}

bool led_on(int led_number) {
  led_on(led_number, 100);
}

bool led_on(int led_number, int power_percentage) {
  analogWrite(PIN_OUT[led_number], int(power_percentage * 2.55));
}

bool led_off(int led_number) {
  analogWrite(PIN_OUT[led_number], 0);
}

bool even(int number) {
  return ((number % 2) == 0);
}

int get_single_digit_int(EthernetClient stream) {
  // ascii("0") == decimal 48
  return stream.read() - 48;
}
