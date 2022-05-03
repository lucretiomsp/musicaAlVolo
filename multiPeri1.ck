// simplest multithreading example
// declare first function
fun void boom()
{
    while (true)
    {
    <<< "Boom!" >>> ;
    1::second => now;
    }
}

// declare second function
fun void cha()
{
    while (true)
    {
    <<< "Cha!" >>> ;
    2::second => now;
    }
}

spork ~ boom();
spork ~ cha();

// infinite time loop to serve as a parent shred
// we need it
while (true) 
    1::second => now;

