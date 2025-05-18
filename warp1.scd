

{FreqShift.ar(Mix(SinOsc.ar(100*(1..6)))*0.1,MouseX.kr(0,1000),MouseY.kr(0,2pi))}.scope;
{FreqShift.ar(Mix(SinOsc.ar(100*(1..6)))*0.1,MouseX.kr(0,1000),SinOsc.ar(MouseY.kr(0,100)))}.scope;

b = Buffer.read(s,Platform.resourceDir +/+"sounds/a11wlk01.wav");
Warp1
WarpExt
//overlaps eight windows of 0.1 seconds, so one window every 0.1/8 = 0.0125 seconds

{Warp1.ar(1,b,pointer:MouseX.kr,freqScale:1,windowSize:0.1 + LFNoise0.kr(20, 0.1), interp:4)}.scope


//increasingly randomise window shape to avoid rough repetition sounds
BufDur.kr(b).BufDur.kr(b)
{Warp1.ar(1,b,pointer:MouseX.kr  + LFNoise0.kr(4, MouseY.kr).poll.range(0,  BufDur.kr(b).poll).poll,freqScale:1.0,windowSize:0.1)}.scope