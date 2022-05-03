// we create a Saw Oscillator and we connect it to the dac
// dac stand for  Digital Audio Converter

SawOsc saw => dac;

180 => saw.freq; // we set the frequency
0.3 => saw.gain; // we set the gain

//this loop runs forever
while (true)
{
    // from the math library
    // we generate a random number between 50 and 900
    // and we chuck it into the saw freq.
    Math.random2f(50,900) => saw.freq;
    // we get a new random number every 110 milliseconds
    110::ms => now;
}
    