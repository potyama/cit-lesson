import processing.serial.*;

public static final int WINDOW_WIDTH = 256;
public static final int WINDOW_HEIGHT = 256;

Serial port;

void settings(){
    size(WINDOW_WIDTH, WINDOW_HEIGHT);
}

void setup(){
  port = new Serial(this, "COM3", 9600);
  port.clear();
  frameRate(10);
}

void draw(){
  int data;
  int val[] = new int[2];
  background(192);
  
  if(port.available() > 0){
    val[0]= port.read();
    val[1] = port.read();
    data = val[0] * 256 + val[1];
    fill(0);
    text(str(data), 160, 200);
  }
}
