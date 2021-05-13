const int R_LED = 9;
const int B_LED = 8;

void setup() {
  Serial.begin(9600);
  pinMode(R_LED, OUTPUT);
  pinMode(B_LED, OUTPUT);
}

void loop() {
  char c;
  if(Serial.available() > 0){
    c = Serial.read();
    if(c == 'r'){
      digitalWrite(R_LED, HIGH);
      digitalWrite(B_LED, LOW);
    }else if(c == 'b'){
      digitalWrite(B_LED, HIGH);
      digitalWrite(R_LED, LOW);      
    }else if(c == 'a'){
      digitalWrite(R_LED, HIGH);
      digitalWrite(B_LED, HIGH);
    }else{
      digitalWrite(R_LED, LOW);
      digitalWrite(B_LED, LOW);
    }
  }
}
