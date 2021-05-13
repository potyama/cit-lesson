const int LED = 9;

void setup() {
  Serial.begin(9600);
  pinMode(LED, OUTPUT);
}

void loop() {
  char c;
  if(Serial.available() > 0){
    c = Serial.read();
    if(c =='a'){
      digitalWrite(LED, HIGH);
    }else if(c == 'b'){
      digitalWrite(LED, LOW);
    }
  }
}
