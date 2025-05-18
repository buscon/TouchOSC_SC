/*
TODO:
//


*RETURNS*
3. return more interesting

*SOUNDS*
- glitch, gendy and waveS1 che reagiscono all'input
- check all


score:
1. silence, little rocks, little by little. no processing (2mins)
2. i start with short delays, following the little sounds,
3. from 7-8 mins, electronic sounds, granular and looping
4. about 12 mins, throwing a bunch of little rocks => cue to turn the bells on. granular drone stays first, then it slowly fades out
5. about 15 mins, drone is out, bells solo, about 2 mins
6. about 17 mins, sampling small pattern and create a rhythm
7. from 20 mins, the rhythm patterns stays and continue, together with bells.
8. about 23 mins, the rhythm starts to change (delays, and different granular trigrate) + distort the signal
9. at 25 mins, bells off. the rhythm gets more messy, more chaos, gendy, low bass.
10. about 30 mins, techno takes over, continue loop and build up layers. some stop and start.
11. 37-38 at one stop, techno does not start again and it gets back to little sounds with reverb and delay
12. fade out to very little like beginning



*/
s.quit
s.boot;
Quarks.gui
(
//~path="/Users/marcello/Music/Samples/MartinLau/*.wav";
//~path="/Users/mlarcello/Music/Samples/Piano/Inside/*.wav";
//~path="/Users/marcello/Music/Samples/orgel/lausitzer/*.wav";
//~path="/Users/marcello/Music/Samples/GranularSelection/*.wav";
//~path="/Users/marcello/Music/Samples/Huggermugger/*.wav";
//"/Users/marcello/Music/Samples/UlrikeThomas/*.wav";
~path="/home/buscon/Music/Samples/Huggermugger/*.wav";
~adrs = NetAddr("192.168.0.105", 9000);
//~adrs = NetAddr("192.168.0.101", 9000);

//~adrs = NetAddr("169.254.10.192", 9000);
//~adrs = NetAddr("169.254.2.156", 9000);

~adrs_looper = ~adrs;//NetAddr("192.168.1.194", 9000);
~adrs_mixer = ~adrs;//NetAddr("192.168.1.194", 9000);//NetAddr("192.168.43.113", 9000);

~adrs_xy = ~adrs;//NetAddr("192.168.1.194", 9000);

~adrs_granulator = ~adrs;
~adrs_trigger = ~adrs;//~adrs_looper;
//~adrs = NetAddr("169.254.212.139", 9000);

//~adrs = NetAddr("169.254.241.141", 9000);

//~adrs = NetAddr("169.254.224.149", 9000);
~osc_port = 5000;
~input_ch1 = 0;
~input_ch2 = 1;
~midi = 1;
~num_channels = 2;
~input_ch3 = 3;
~input_ch4 = 1;
	//("".resolveRelative++"02_synths_debug.scd").load;
//wavetable
~wave =  Wavetable.chebyFill(512, [1]);
~waveBuf = Buffer.alloc(s, 1024, 1);
~waveBuf.sendCollection(~wave.asWavetableNoWrap);

)
	("".resolveRelative++"02_synths_rocks.scd").openOS;
("".resolveRelative++"01_midiIn_NanoKontrol2.scd").openDocument;
		("".resolveRelative++"03_mixer_2looper_editForWaveS1.scd").openOS;
(
r = Task({
	//	if(~midi > 0,{("".resolveRelative++"01_midiIn_LaunchControlXL.scd").load; });
		if(~midi > 0,{("".resolveRelative++"01_midiIn_NanoKontrol2.scd").load; });

	1.wait;
	OSCdef.freeAll;
	("".resolveRelative++"01_01_datalist_5instrRocks.scd").load;
	("".resolveRelative++"01_02_datalist_returns.scd").load;
	("".resolveRelative++"01_02_datalist_looper2.scd").load;
	("".resolveRelative++"01_02_datalist_granular.scd").load;
	("".resolveRelative++"02_synths_rocks.scd").load;
	1.wait;
	("".resolveRelative++"03_mixer_2looper_editForWaveS1.scd").load;
	3.wait;

	("".resolveRelative++"03_01_setupOSC.scd").load;
	1.wait;
	("".resolveRelative++"03_02_setupOSC_mixer.scd").load;
	1.wait;

//	("".resolveRelative++"03_01_setupOSC_synths.scd").load;
	1.wait;

	("".resolveRelative++"03_01_setupOSC_returns.scd").load;
	1.wait;

	("".resolveRelative++"04_OSC_looper2.scd").load;
	1.wait;

	("".resolveRelative++"03_01_setupOSC_XY.scd").load;
	1.wait;
//	if(~midi > 0, {("".resolveRelative++"04_midiforlooper_LaunchControlXL.scd").load; });
 	if(~midi > 0, {("".resolveRelative++"04_midiforlooper_NanoKontrol2.scd").load; });

	1.wait;
	("".resolveRelative++"05_granulatorOSC_new.scd").load;


	1.wait;
	"=========================== DONE =================================".postln;
}).start;
)
	("".resolveRelative++"04_OSC_looper2.scd").load;
MasterEQ.new(2)
(
Task({
ChannelEQ(target: ~mixer[8]);
	FreqScope.new;
	s.meter;
},AppClock).start;

)
//("".resolveRelative++"04_midiforlooper.scd").load;
(

)

(
FreqScope.new;
	ChannelEQ(target: ~mixer[0]);
	ChannelEQ(target: ~mixer[1]);
	ChannelEQ(target: ~mixer[2]);
	ChannelEQ(target: ~mixer[3]);
	ChannelEQ(target: ~mixer[4]);
	ChannelEQ(target: ~mixer[5]);
	ChannelEQ(target: ~mixer[6]);
	ChannelEQ(target: ~mixer[7]);
)
//("/Users/marcello/Music/Supercollider/mixer/06_touchosc.scd").load;

//Free

("".resolveRelative++"free_returns.scd").load;


	OSCdef.freeAll;
	("".resolveRelative++"01_01_datalist_5instr.scd").load;
	("".resolveRelative++"01_02_datalist_returns.scd").load;
	("".resolveRelative++"01_02_datalist_looper2.scd").load;
	("".resolveRelative++"01_02_datalist_granular.scd").load;
	("".resolveRelative++"02_synths_debug.scd").load;
	("".resolveRelative++"03_mixer_2looper_editForWaveS1.scd").load;

	("".resolveRelative++"03_01_setupOSC.scd").load;
	("".resolveRelative++"03_02_setupOSC_mixer.scd").load;

	("".resolveRelative++"03_01_setupOSC_synths.scd").load;


	("".resolveRelative++"03_01_setupOSC_returns.scd").load;

	("".resolveRelative++"04_OSC_looper2.scd").load;


	("".resolveRelative++"03_01_setupOSC_XY.scd").load;
	if(~midi > 0, {("".resolveRelative++"04_midiforlooper_NoLaunchpad.scd").load; });
	("".resolveRelative++"05_granulatorOSC_new.scd").load;


(
~parameters[1][0].set(~parameters[1][1][1][3][0], 0.5);

~chan2.level = 0.3;
~senda_2.level = 0;
~sendb_2.level = 0;
~sendc_2.level = 0;
)
~parameters_returns[2][0].set(\volume, 1);
~parameters_returns[2][0].get(\volume, {arg value; value.postln});
~parameters_returns[2]
~del.set(\mul, 5);
~parameters[1][1][1][3][0]
~parameters_returns
~parameters[1][0].set(~parameters[1][1][1][3][0], 0.5);
~f = Array.newClear(20);
(
~copiedBuf_to_gran.size.do({ |b|
	var left, top, width, height;
	width = 250;
	height = 150;
	//left = b * width;
	left = (( b  % 8.0 ) * width);

	top = ( (b * height) / 8.0 ).trunc(100) * 1.8;
	top.postln;
	~f[b] = ~copiedBuf_to_gran[b].plot(b.asString, Rect(left, top, width, height));
});
)


(
8.size.do({ |i|
	ChannelEQ(target: ~mixer[i]);
});
)
