
#include <WProgram.h>
#include <Servo.h>

const static uint8_t LEFT_THRUSTER_PIN      = 9;
const static uint8_t RIGHT_THRUSTER_PIN     = 10;
const static uint8_t BUTTON                 = 2; // INT0

Servo leftThruster;
Servo rightThruster;

int8_t throttleLevel; // one level per click. signed to allow reverse in the future.

volatile uint8_t numPresses;
volatile long lastButtonPress;

const static long DEBOUNCE_TIMEOUT_MS     = 100;
const static long MAX_TIME_BETWEEN_MS     = 1000;

void buttonPress() {

	if ( millis() - lastButtonPress < DEBOUNCE_TIMEOUT_MS ) {
		return;
	}

	if ( millis() - lastButtonPress < MAX_TIME_BETWEEN_MS ) {
		numPresses++;
		lastButtonPress = millis();
		return;
	}

	if ( millis() - lastButtonPress > MAX_TIME_BETWEEN_MS ) {
		numPresses = 0;
		lastButtonPress = millis();
		return;
	}
}

void checkButtonTimeout() {
	if ( millis() - lastButtonPress > MAX_TIME_BETWEEN_MS ) {
		throttleLevel = numPresses;
	}
}

void setup() {
	Serial.begin(57600);

	leftThruster.attach(LEFT_THRUSTER_PIN);
	rightThruster.attach(RIGHT_THRUSTER_PIN);

	leftThruster.writeMicroseconds(1500);
	rightThruster.writeMicroseconds(1500);

	attachInterrupt(0,buttonPress,RISING);

	delay(1000);
}

void loop() {
	const static int16_t baseThrottle = 1500;

	checkButtonTimeout();

	int16_t throttle = throttleLevel*100;

	leftThruster.writeMicroseconds(baseThrottle+throttle);
	rightThruster.writeMicroseconds(baseThrottle+throttle);

	Serial.write(27);       // ESC command
	Serial.print("[2J");    // clear screen command
	Serial.write(27);
	Serial.print("[H");     // cursor to home command
	Serial.println("Aquateer Live Data");
	Serial.print("Throttle Output:    ");Serial.print(baseThrottle+throttle);Serial.println(" us");

	delay(500);
}