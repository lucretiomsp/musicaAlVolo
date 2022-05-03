// we create 7 BowedInstrument wit different frequencies and parameters
Bowed b [7];
// the base freq for our violins
300.0 => float baseFreq;


// a Sine Oscillator is used as an LFO
// it is connected to the blackhole!
// the blackhole "sucks" the samples at sample rate
SinOsc lfo => blackhole;
// the variable that will contain the lfo modulation vakue
0.0 => float modValue;

// This class implements a bowed string model, a
// la Smith (1986), after McIntyre, Schumacher, Woodhouse (1983).



fun void modulate(float modFreq)
{
    0.5 => lfo.gain; // lfo amplitude is the modulation amount
    modFreq => lfo.freq;
    
    while (true) // runs over and over again
    {
     // we can decide the modulation frequency
    lfo.last() * baseFreq => modValue;
    // advance time by 1 sample, ut's sample rate modulation!
    1::samp => now;
    
    }
}
// setting up the violins
for ( 0 => int i; i < b.size(); i++)
{
    0.3 => b[i].volume; // the volume
   // a different freq for very violin
    i / 6.0 => b[i].bowPosition;
    
    
    b[i] => dac;
    
    // a note On for the synths
    
    1 => b[i].noteOn;
}

fun void play()
{
    while(true)
    {
    for (0 => int i; i < b.size(); i++)
    {
    (baseFreq + modValue) + i * 25 => b[i].freq; 
    }
    
    1::samp => now;
    }
}


// multithreading!!!!!!
// more than one shread running at the same time in parallel

// you can change modulate argument to change the speed of the lfo! 
spork ~ modulate(1.1);
spork ~ play();

// infinite time loop to serve as a parent shred
// we need a parent shread

while( true ) 
{
   1::second => now;
}