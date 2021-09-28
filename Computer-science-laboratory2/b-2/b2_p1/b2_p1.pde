import ddf.minim.*; 
import ddf.minim.ugens.*; 
import javax.sound.sampled.*;

Minim minim; 
AudioSample wave;
float[] samples;
float waveFrequency = 880f;
float waveSampleRate = 22050f;
float samplesPerFreq = waveSampleRate/waveFrequency;
float timeLength = 2.0;

void setup () 
{ 
  size (1024, 200); 

  minim = new Minim(this); 

  float amp = 0.6; 

  samples = new float[(int)( waveSampleRate * timeLength )];
  for ( int i = 0; i < samples.length; ++i ) 
  {    
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
  
  for (int i = 0; i < (int)(samplesPerFreq*5); i++) 
  {
    line(i, 100 - wave.left.get(i)*50, i+1, 100 - wave.left.get(i +1)*50);
  }
} 

void keyPressed () 
{
  if ( key == 't' ) {
    wave.trigger ();
  } else if ( key == 's'){
  
  }
} 
