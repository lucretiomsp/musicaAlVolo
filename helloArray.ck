// a saw oscillator chucked into an ADSR envelope
// then into a LowPass filter
// and then chucked into our dac

SawOsc saw => ADSR env => LPF lowpass => Echo e=> dac;


0.4 => saw.gain; // initial sawtooth wave gain
(2::samp, 180::ms, 0, 190::ms) => env.set; // envelope parameters
1200 => lowpass.freq; // initial cutoff frequency
2.5 => lowpass.Q; // initial reso

// create array of integers
[37, 41, 47, 50, 38, 42, 49, 47] @=> int notes [];
0 => int index; // to read the values inside the array

while (true)
{
    // convert MIDI note number to frequency
    // we use the modulo operator stay within the array boundaries
    // .size() or .cap() are the two methods to get the size of an array
    // the index of the first element of the array in C-like message is 
    // zero
    
    // ramp like modulation of filter freq
    80 + ((index % 200)  * 10) => lowpass.freq;
    
    Std.mtof(notes[index%notes.size()]) => saw.freq;
    1 => env.keyOn; // play the Envelope
    index + 1 => index; //advance the index
    <<< index % notes.size() >>> ;
    107::ms => now;
    1 => env.keyOff;
}
    
    
    