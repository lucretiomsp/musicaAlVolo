// we create a Saw Oscillator and we connect it to the dac
// dac stand for  Digital Audio Converter

SawOsc saw => dac;

180 => saw.freq; // we set the frequency
0.3 => saw.gain; // we set the gain

// we play it for 2 second
2::second => now;

// we always add comments to our code
// for other people
// or for our future self