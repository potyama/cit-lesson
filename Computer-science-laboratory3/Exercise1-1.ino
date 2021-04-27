const int SWITCH = 2;
const int R_LED = 9;
const int B_LED = 6;

int state = 0;
int level, old_level;

void setup() {
  pinMode(SWITCH, INPUT);
  pinMode(R_LED, OUTPUT);
  pinMode(B_LED, OUTPUT);
}

void loop() {
  level = digitalRead(SWITCH);

  if(level == HIGH && old_level == LOW){
    state = 1 - state;
   }
   old_level = level;
   
    if(state == 1){
      digitalWrite(R_LED, HIGH);
      digitalWrite(B_LED, LOW);
    }else{
      digitalWrite(B_LED, HIGH);
      digitalWrite(R_LED, LOW);
   }
   delay(10);
}
