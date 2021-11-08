import ddf.minim.signals.*;
import ddf.minim.analysis.*;
import ddf.minim.*;
import javax.sound.sampled.*;

Minim minim;
AudioSample wave;
FFT fft;
float[] samples;

void setup(){
  size(512, 200);
  minim = new Minim(this);
  
  float waveSampleRate = 10000f;
  float timeLength = 2.0f;
  float amp = 0.6f;
  float f = 440f;
  float period = waveSampleRate/f;
  
  samples = new float[(int)(waveSampleRate*timeLength)];
  
  for(int i=0; i<samples.length; i++){
    samples[i] = (i%period-period/2)/(period/2)*amp;
  }
  AudioFormat format = new AudioFormat(waveSampleRate, 16, 1, true, true);
  
  wave = minim.createSample(samples, format, 1024);
  /*
  fft = new FFT(wave.bufferSize(), wave.sampleRate());
  WindowFunction newWindow = FFT.HANN;
  fft.window(newWindow);
  */
}

void draw(){
  background(0);
  stroke(255);
  
 
  for(int i=0; i<wave.bufferSize() - 1; i++){
    line(i, 100 - wave.left.get(i)*50 , i+1, 100 - wave.left.get(i +1)*50);
  }
  
  /*
  fft.forward(wave.left);
  for(int i=0; i< fft.specSize(); i++){
    float x = map(i, 0, fft.specSize(), 0, width);
    line(x, height, x, height - fft.getBand(i)*8);*/
  //}
}

void keyPressed(){
  if(key=='s'){
    save("image.png");
  }else if(key == 't'){
    wave.trigger();
  }
}
