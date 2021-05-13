import processing.serial.*;

Serial port;

void setup(){
  size(256, 256);
  port = new Serial(this, "/dev/cu.usbmodem141101", 9600);
  port.clear();
}

void draw(){
  if(mousePressed == true){
    if((mouseX >= 77 && mouseX <= 177) && (mouseY >= 77 && mouseY <= 177)){
      port.write('a');
      fill(255, 0, 0);
    }
  }else{
    port.write('b');
    fill(255);
  }
  background(192);
  ellipse(127, 127, 100, 100);
}
