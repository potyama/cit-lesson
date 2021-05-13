const int SENSOR = 0;

void setup() {
  Serial.begin(9600); // シリアル通信の速度を設定
}

void loop() {
  int v;
  byte buf[2];
  v = analogRead(SENSOR);
  buf[0] = byte(v);
  buf[1] = byte(v >> 8);
  Serial.write(buf, 2);
  delay(100);
}
