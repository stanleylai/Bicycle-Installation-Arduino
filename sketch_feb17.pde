/*******************************************************

  Sublime Bicycle Installation Arduino Code
  by Stanley Lai
  for Rachel Law
  
  
  version 1.3
  17 February 2011
  
  Changelog
  == Version 1.3 ==
  Increased TX Delay. Code is pretty much final.
  
  == Version 1.2 ==
  Added an extra analog input, for a total of 3 reed switches
  
  == Version 1.1 ==
  Uses analog input rather then digital.
  Uses digital 7/8 for debug purposes 
  
  
  Takes Analog Sensor input from Reed Switches
  and passes them along the serial connection.


*******************************************************/
// Signalling Constants
const char DATA_REED1 = 'A';      // Signals that Reed 1 is triggered
const char DATA_REED2 = 'B';      // Signals that Reed 2 is triggered
const char DATA_REED3 = 'C';      // Signals that Reed 3 is triggered
const int DATA_FLAG_INDEX = 1;    // Constant for index position of data
const int TX_DELAY = 25;         // Delay between serial sends. in milliseconds
const int TX_SPEED = 9600;        // Baud speed for serial connection

// Pin Out Constants
const int reed1Pin = 0;           // Analog pin for Reed 1
const int reed2Pin = 2;           // Aanalog pin for Reed 2
const int reed3Pin = 5;           // Analog pin for Reed 3
const int led1Pin = 11;            // Digital pin for LED 1 (debug)
const int led2Pin = 12;            // Digital pin for LED 2 (debug)
const int led3Pin = 13;           // Digital pin for LED 3 (debug)

// Debug
int lightLED = 0;



/*******************************************************
  Initialization Setup Method
*******************************************************/
void setup() {
  Serial.begin(TX_SPEED);
  pinMode(led1Pin, OUTPUT);
  pinMode(led2Pin, OUTPUT);
  pinMode(led3Pin, OUTPUT);
}



/*******************************************************
  Main Program Loop
*******************************************************/
void loop() {
  int reed1Value = analogRead(reed1Pin);
  int reed2Value = analogRead(reed2Pin);
  int reed3Value = analogRead(reed3Pin);
  
  
  // Debug Test
  /*
  Serial.print("reed1Value = ");
  Serial.println(reed1Value);
  Serial.print("reed2Value = ");
  Serial.println(reed2Value);
  Serial.print("reed3Value = ");
  Serial.println(reed3Value);
  */
  
  if (reed1Value > 250) {
    // If Reed 1 Triggered...
    sendToServer(DATA_REED1);
    digitalWrite(led1Pin, HIGH);
 
  } else if (reed2Value > 250) {
    // If Reed 2 Triggered...
    sendToServer(DATA_REED2);
    digitalWrite(led2Pin, HIGH);
  
  } else if (reed3Value > 250) { 
    // If Reed 3 Triggered...
    sendToServer(DATA_REED3);
    digitalWrite(led3Pin,HIGH);
  } else {
    // If no Reeds Triggered...
    digitalWrite(led1Pin, LOW);
    digitalWrite(led2Pin, LOW);
    digitalWrite(led3Pin, LOW);
  };

  delay(TX_DELAY);

}



/*******************************************************
  Write data to serial in appropriate protocol
*******************************************************/
void sendToServer(char flag) {
  Serial.print(flag);
}
