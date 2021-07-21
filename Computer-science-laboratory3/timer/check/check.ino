const int LED = 9;
const int SWITCH = 2;
const int CdS = 0;
int c;
int flag = 0;

void setup() {
  Serial.begin(9600);
  pinMode(LED, OUTPUT);
}

  void loop() {
    int val;
    char c = '1';
    val = analogRead(CdS);
    int v = digitalRead(SWITCH);
    if(v == LOW){
      Serial.println(-1);
      for(int i=0;i < 50;i++){
        digitalWrite(LED, HIGH);
        delay(100);
        digitalWrite(LED, LOW);
        delay(100);
      }
    }
    Serial.println(val);
    switch (Serial.read()) {

      case 'a':
        digitalWrite(LED, HIGH);
        break;

      case 'b':
        digitalWrite(LED, LOW);
        break;
    }
    delay(1000);
  }
