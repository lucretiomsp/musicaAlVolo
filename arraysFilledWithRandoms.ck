// resonant bar from the STK
// moog likeSewpt STK instrument
///into Gain;
// into CCRMA  reverberator
ModalBar bar => Gain g;
Moog moog => g;
g => NRev rev => dac;
0.7 => bar.volume; // initial bar volume
0.4 => moog.volume; // initial moog volume
0.2 => rev.mix; // initial reverb amount
// all our arrays will have the same size
512 => int patternLength;


// strike position
float positions [patternLength]; 
// mode of vibration
float modeRatio [patternLength]; 
//frequencies
float barFreqs [patternLength]; 
float moogFreqs [patternLength]; 
//damping
float damps[patternLength]; 
// sequencer trigs
float trigs[patternLength]; 

// moog filterSweeps
float filterSweep[patternLength];

// first we fill the arrays 
for (0 => int i; i < patternLength; i ++)
{
    // generates random floating point number in the range [0, 1]
   // (NOTE: this is different semantics than Std.randf(), 
   // which has the range [-1,1])
    Math.randomf() => positions[i];
    Math.randomf() => modeRatio[i];
    Math.random2f(50,400) => barFreqs[i];
    Math.randomf() => damps[i];
    Math.randomf() => filterSweep[i];
    
    // triggers are 0 or 1
    //round to nearest integral value (returned as float)
    Math.round(Math.randomf()) => trigs[i];
}


for (0 => int i; i <= patternLength; i++)
{
    positions[i] => bar.strikePosition;
    modeRatio[i] => bar.modeRatio;
    barFreqs[i] => bar.freq;
    // moog is an octave lower
    barFreqs[i] * 0.5 => moog.freq;
    
    // advance time
    109::ms => now;
    if (trigs[i] == 1.0)  
    {   // moog plays when bar doesnt
        1 => bar.noteOn;
        1 => moog.noteOff;
} else {
    1 => bar.noteOff;
    1 => moog.noteOn;
}
}

       
  

