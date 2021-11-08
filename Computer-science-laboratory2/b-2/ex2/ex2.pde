import ddf.minim.signals.*;
import ddf.minim.analysis.*;
import ddf.minim.*;
import javax.sound.sampled.*;

Minim minim;
AudioSample wave;
FFT fft;
float[] samples;

void setup() {
  size(512, 1000);
  minim = new Minim(this);

  float waveSampleRate = 11025f;
  float timeLength = 5.0f;
  float amp = 0.6f;
  float overtones = 5;
  float f = 440f;
  float period = waveSampleRate/f;
  float amp_max = 0.0;

  samples = new float[(int)( waveSampleRate * timeLength )];
  for (int i = 0; i < samples.length; i++) {
    float t = i / waveSampleRate;
    for (int j = 1; j <= overtones; j++) {
      switch(j){
        case 1:
          float tmp = sin(2*PI*(f*j)*t)*(1.0);
          samples[i] += tmp;
       case 2:
          float tmp2 = sin(2*PI*(f*j)*t)*(0.38);
          samples[i] += tmp2;

      }
      }
    if (amp_max < abs(samples[i])) {
      amp_max = abs(samples[i]);
    }
  }
  for (int i = 0; i < samples.length; i++) {
    samples[i] = samples[i]/amp_max * amp;
  }

  AudioFormat format = new AudioFormat(waveSampleRate, 16, 1, true, true);

  wave = minim.createSample(samples, format, 1024);

  fft = new FFT(wave.bufferSize(), wave.sampleRate());
  WindowFunction newWindow = FFT.HANN;
  fft.window(newWindow);
}

void draw() {
  background(0);
  stroke(255);
  fft.forward(wave.left);

  /*
  for(int i=0; i<wave.bufferSize() - 1; i++){
   line(i, 100 - wave.left.get(i)*50 , i+1, 100 - wave.left.get(i +1)*50);
   }
   

  fft.forward(wave.left);
  for (int i=0; i< fft.specSize(); i++) {
    float x = map(i, 0, fft.specSize(), 0, width);

    line(x, height, x , height - fft.getBand(i)*8);
  }*/
    for (int i=0; i< fft.specSize(); i++) {
     float bandDB = 20 * log(fft.getBand(i) / fft.timeSize() );
     float bandHeight = map(bandDB, 0, -250, 0, height);
     line(i, height, i, bandHeight);
  }
}

void keyPressed() {
  if (key=='s') {
    save("image.png");
  } else if (key == 't') {
    wave.trigger();
  }
}
