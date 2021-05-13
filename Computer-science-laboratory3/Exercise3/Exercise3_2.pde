import processing.serial.*;

Serial port;

void setup(){
  size(256, 256);
  port = new Serial(this, "COM3", 9600);
  port.clear();
}

void draw(){
  int c;
  if(port.available() > 0){
    c = port.read();
    println(c);
    fill(255, 255-c, 255-c);
    background(192);
    rect(0, 127, c, 40);
  }
}
