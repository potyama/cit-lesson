import processing.serial.*;

public static final int WINDOW_WIDTH = 256;
public static final int WINDOW_HEIGHT = 256;

int vals[] = new int[WINDOW_WIDTH];
Serial port;

void settings(){
    size(WINDOW_WIDTH, WINDOW_HEIGHT);
}

void setup(){
  port = new Serial(this, "COM3", 9600);
  port.clear();
  for(int i = 0; i < WINDOW_WIDTH; i++){
    vals[i] = 0;
  }
  frameRate(10);
}

void draw(){
  int x = 0, c;
  background(192);
  
  if(port.available() > 0){
    c = port.read();
    vals[frameCount % WINDOW_WIDTH] = c;
    
    for(int i = frameCount % WINDOW_WIDTH + 1; i < WINDOW_WIDTH; i++){
      line(x, WINDOW_HEIGHT, x, WINDOW_HEIGHT - vals[i]);
      x++;
    }
    
    for(int i = 0; i <= frameCount % WINDOW_WIDTH; i++){
      line(x, WINDOW_HEIGHT, x, WINDOW_HEIGHT - vals[i]);
      x++;
    }
  }
}
