// instanziamo un oggetto della classe SndBuf
// we need it to read files

SndBuf tom => JCRev rev =>dac; // we chuck our sample into a JCReverb from the STK
// JC stands for John Chowning

// we save into a variable the path to our file
// me.dir() returns the directory in which our .ck file is located
me.dir() + "/samples/HT1_808.aiff" => string tomFileName;

// we load the file into our buffer
tomFileName => tom.read;

0.3 => rev.mix; // the amount of reverb

// our duration is 1/16th at 146 bpm
146.0 => float bpm; // take care of float-int operations in C-like languages
((60.0 / bpm) / 4.0)::second => dur myDuration;

// forever
while( true )
{
    
    0 => tom.pos; // to restart the buffer 
    Math.random2f(.0, .6) => tom.gain;
    Math.random2f(.2,1.9) => tom.rate;
    Math.random2f(0.0, 0.3) => rev.mix; // the amount of reverb
    myDuration => now;
}