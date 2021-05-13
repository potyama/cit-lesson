#define a 0.8

const int SENSOR = 0;
const int LED = 9;
int v = 0;
float rc = 0;

void setup(){
  Serial.begin(9600);
  pinMode(LED, OUTPUT);
}

void loop(){
  v = analogRead(SENSOR);
  rc = a*rc + (1-a) * float(v);
  Serial.println(rc);
  analogWrite(LED, rc);
}
