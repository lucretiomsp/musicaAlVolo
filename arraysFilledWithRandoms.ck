// resonant bar from the STK
// moog likeSewpt STK instrument
// SinOsc for the subb into an ADSR
///into Gain;
// into CCRMA  reverberator
ModalBar bar => Gain g;
Moog moog => g;
SinOsc sub => ADSR env => g;
g => NRev rev => dac;

0.7 => bar.volume; // initial bar volume
0.4 => moog.volume; // initial moog volume
0.32 => sub.gain; // initial sub gain
0.2 => rev.mix; // initial reverb amount
// envelope for the sub:
(2::ms, 180::ms, 0.95, 210::ms) => env.set;


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
    // moog and sub are one and two octave lower
    barFreqs[i] * 0.5 => moog.freq;
    barFreqs[i] * 0.25 => sub.freq;
    
    // advance time randomly
    // random2 generates random integer in the range [min, max]
    Math.random2(112,340)::ms => now;
    if (trigs[i] == 1.0)  
    {   // moog and sub play when bar doesnt
        1 => bar.noteOn;
        1 => env.keyOff;
        1 => moog.noteOff;
} else {
    1 => bar.noteOff;
    1 => env.keyOn;
    1 => moog.noteOn;
}
}

       
  

