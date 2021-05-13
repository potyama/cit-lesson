 const int SENSOR = 0; 
 const int LED = 9; 

 void setup() {
 Serial.begin(9600); 
 pinMode(LED, OUTPUT);
 }

 void loop() {
 int v;
 v = analogRead(SENSOR);
 Serial.println(v); 
 analogWrite(LED, v); 
}
