import ddf.minim.*; 
import ddf.minim.ugens.*; 
import javax.sound.sampled.*;

Minim minim; 
AudioSample wave;
float[] samples;



void setup () 
{ 
  size (1024, 200); 

  minim = new Minim(this); 
  float waveFrequency = 440f;
  float waveSampleRate = 16000f;
  float timeLength = 6.0f;
  float amp = 0.3f;
  float r = pow(2.0f, (1.0f/12.0f));

  samples = new float[(int)( waveSampleRate * timeLength )];
  int a=1;
  for ( int i = 0; i < samples.length; ++i ) 
  {    
    if(i == (int)(waveSampleRate * 0.5*a) && a <= 12){
      waveFrequency = waveFrequency * r;
      a++;
    }
    float t = i / waveSampleRate ; 
    samples[i] = sin (2* PI* waveFrequency *t)* amp;
  } 

  AudioFormat format = new AudioFormat ( 
    waveSampleRate, 
    16, 
    1, 
    true, 
    true
    );


  wave = minim. createSample ( samples, 
    format, 
    1024
    );
} 

void draw () 
{ 
  background (0); 
  stroke (255); 

  for (int i = 0; i < wave.bufferSize() - 1; i++) 
  {
    line(i, 100 - wave.left.get(i)*50, i+1, 100 - wave.left.get(i +1)*50);
  }
} 

void keyPressed () 
{
  if ( key == 't' ) {
    wave.trigger ();
  }
} 
