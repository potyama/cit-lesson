const int CdS = 0;

void setup() {
  Serial.begin(9600);
}

void loop() {
  int val;
  val = analogRead(CdS);
  Serial.println(val);
  delay(1000);
}