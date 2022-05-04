// instanziamo un oggetto della classe SndBuf
// we need it to read files

SndBuf tom => JCRev rev =>dac; // we chuck our sample into a JCReverb from the STK
// JC stands for John Chowning
SndBuf kick => dac; 



// we save into a variable the path to our file
// me.dir() returns the directory in which our .ck file is located
me.dir() + "/samples/HT1_808.aiff" => string tomFileName;
me.dir() + "/samples/BD_dry909.aiff" => string kickFileName;

// we load the file into our buffer
tomFileName => tom.read;
kickFileName => kick.read;

// inital gain for the kick sample
0.8 => kick.gain;

0.3 => rev.mix; // the amount of reverb

// our duration is 1/16th at 146 bpm
146.0 => float bpm; // take care of float-int operations in C-like languages
(60.0 / bpm) ::second => dur beat;
beat / 4.0 => dur sixteenth;

// Tom shred
fun void playTom()
{
while( true )
{
    
    0 => tom.pos; // to restart the buffer = play the sample from the beginning
    // random2f from the Math library, returns a random float between min and max 
    Math.random2f(.0, .6) => tom.gain;
    Math.random2f(.2,0.9) => tom.rate;
    Math.random2f(0.0, 0.3) => rev.mix; // the amount of reverb
    sixteenth => now;
}
}

// Kick shred
fun void playKick( float kickTune)
{   
    while (true)
    {
    kickTune => kick.rate;
    0 => kick.pos;
    beat => now;
    }
}

spork ~ playTom();
spork ~ playKick(0.6);

// parent shred, we always need one!
while (true)
    1::second => now;