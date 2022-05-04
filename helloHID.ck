// first we create an HIDIn object
Hid kInput;
// and then a HidMsg
HidMsg msg;

// device number
// you can see the available device and their id pressing command + 2 
/// or from the top down menu
// window - device browser - human interface device
1 => int device; // 1 is my keyboard


// open keyboard (get device number from command line)
if( !kInput.openKeyboard( device ) ) me.exit();
<<< "keyboard '" + kInput.name() + "' ready", "" >>>;

// a tube bell from the STK
TubeBell bell => ADSR env => dac;
0.4 => bell.gain; // not too loud!
1 => env.keyOn; // bell is always on. we use the envelope

// we set the envelope
(1::ms, 180::ms, 0.7, 410::ms) => env.set;

// infinite event loop
while (true)
{ 
    //wait for event
    kInput => now;
    
    //get the message
    while (kInput.recv (msg))
    {
        if (msg.isButtonDown())
        {
            // convert the midi note numner to freq
            Std.mtof(msg.which + 45) => bell.freq;
            //play a note
            
            1 => bell.noteOn;
            //advance time
            120::ms => now;
        }
        else 
        {
            // note off when keyboard is not press
            0 => env.keyOn;
           // 0 => bell.noteOff;
        }
            
        }
}