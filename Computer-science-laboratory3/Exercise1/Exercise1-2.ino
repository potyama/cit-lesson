const int SWITCH = 2;
const int LED = 9;
int state = 0;
int level, old_level;

void setup() {
  pinMode(SWITCH, INPUT);
  pinMode(LED, OUTPUT);
}

void loop() {
  level = digitalRead(SWITCH);

  if(level == HIGH && old_level == LOW){
    state = 1 - state;
   }
   old_level = level;
   
    if(state == 1){
      digitalWrite(LED, HIGH);
    }else{
      digitalWrite(LED, LOW);
   }
   delay(10);
}
