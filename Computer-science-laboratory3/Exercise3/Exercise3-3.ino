const int SENSOR = 0;

void setup() {
  Serial.begin(9600); // シリアル通信の速度を設定
}

void loop() {
  int v;
  v = analogRead(SENSOR);
  Serial.write(v);
  delay(100);
}
