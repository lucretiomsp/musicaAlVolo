// a raw FM synth
SinOsc carrier => Gain g;
SinOsc modulator => blackhole;

SndBuf ztick => dac;

g => dac;

// we read the file into the soundbuffer
me.dir() + "/samples/ztick.aiff" => ztick.read;

// just mute the gain
0.0 => g.gain;
0.5 => carrier.gain;

// modulator index
float modIndex;

// the OSC event
OscIn oin;
// the osc message
OscMsg msg;

9000 => oin.port;

oin.addAddress("/nunchuk/x");
oin.addAddress("/nunchuk/y");
oin.addAddress("/nunchuk/pitch");
oin.addAddress("/nunchuk/yaw");
oin.addAddress("/nunchuk/roll");
oin.addAddress("/nunchuk/buttonC");
oin.addAddress("/nunchuk/buttonZ");
oin.addAddress("/buttonA");
oin.addAddress("/buttonB");
oin.addAddress("/pitch");
oin.addAddress("/roll");
oin.addAddress("/yaw");
//open the device
// if (!min.open(device)) me.exit();

//infinite time-loop

// for debug purpose
float debug;

fun void wiiControl()
{
while (true)
{
    // wait from the event from MIDI in
   oin => now;
    
    //get the messages
    while (oin.recv(msg))
    {
        
        //print out the midi message
        // <<< msg.address >>> ;
       // we parse the messages
       // nunchuck yoypad X
       if (msg.address == "/nunchuk/x")
       {
            
           // get the absolute value and normalize it
           Std.fabs(msg.getFloat(0)) * 400.0 + 20.0 => modulator.freq;
          
       }
       // nunchuck yoypad Y
       if (msg.address == "/nunchuk/y")
       {
          Std.fabs(msg.getFloat(0)) * 300 + 10 => modIndex;
           
       }
       // main roll
       if (msg.address == "/roll")
       {
           Std.fabs(msg.getFloat(0)) * 800.0 + 20 => carrier.freq;
           /// <<< debug >>>;
       }
       
       // main buttonB
       if (msg.address == "/buttonB")
       {
           if (msg.getFloat(0) == 1.0)
           {
           0 => ztick.pos;    
           /// <<< debug >>>;
           }
       }
       
       // main pitch
       if (msg.address == "/pitch")
       {
          Std.fabs(msg.getFloat(0)) * 2.0 => ztick.rate;
       }
       
    }
}
}


fun void modulation1()
{
    while (true)
    {
        // modulator.last() ;
        
    }
}
spork ~ wiiControl();
// parent shred
while (true) 1::second => now;
