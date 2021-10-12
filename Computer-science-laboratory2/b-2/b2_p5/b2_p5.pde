import ddf.minim.analysis.*;
import ddf.minim.*;

Minim minim;
AudioPlayer voice;
FFT fft;
String windowName;

void setup(){
  size(512, 1000);
  minim = new Minim(this);
  //voice = minim.loadFile("../wav/strings_11025.wav", 512);
    voice = minim.loadFile("../wav/clarinet_11025.wav", 512);
  println(voice.length());
  voice.loop();
  
  fft = new FFT(voice.bufferSize(), voice.sampleRate());
  WindowFunction newWindow = FFT.HANN;
  fft.window(newWindow);
}

void draw(){
  background(0);
  stroke(255);

  fft.forward(voice.left);
  for(int i = 0; i< fft.specSize(); i++){
    //iの取る値を0 ~ スペクトル幅　-> 0 ~ widthに変換(ようするに、xをスペクトル幅の位置にしてる)
    float x = map(i, 0, fft.specSize(), 0, width);
    // 高さ - 周波数iの音量 で定数倍することで、波形を大きくしてる
    line(x, height, x , height - fft.getBand(i)*8);
  }
  fill(255);
}
