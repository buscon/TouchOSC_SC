/*
TODO:
//

sina:
- add deviation fine

*/
s.quit
s.boot;


(

~path="/home/marcello/Music/Samples/Unendlich/*.wav";

~adrs = NetAddr("192.168.1.177", 9000);
//~adrs = NetAddr("192.168.0.103", 9000);

//~adrs = NetAddr("10.42.0.249", 9000);
~adrs_mixer = ~adrs;

//~adrs_mixer = NetAddr("192.168.1.194", 9000);//NetAddr("192.168.43.113", 9000);
~adrs_looper = ~adrs_mixer;

~adrs_returns = ~adrs_mixer;
~adrs_xy = ~adrs;//NetAddr("192.168.1.194", 9000);

~adrs_granulator = ~adrs_mixer;
~adrs_trigger = ~adrs;//~adrsx_looper;
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
	("".resolveRelative++"04_OSC_looper2.scd").openOS;


s.meter;	s.freqscope;
~buf_to_gran[0]
~mixer[0].set(\trigger1, 1)
~parameters[0].put(0, ~mixer[0].play(~parameters[0][1][0]), [\trigger1, 1]);

	("".resolveRelative++"02_synths_rocks.scd").open;
("".resolveRelative++"01_midiIn_LaunchControlXL.scd").openOS;
	("".resolveRelative++"03_mixer_2looper_editForWaveS1.scd").openOS;
	("".resolveRelative++"01_01_datalist_5Unendlich.scd").openOS;
m.gui
	("".resolveRelative++"01_02_datalist_looper2.scd").openOS;

(
r = Task({
	//	if(~midi > 0,{("".resolveRelative++"01_midiIn_LaunchControlXL.scd").load; });
		if(~midi > 0,{("".resolveRelative++"01_midiIn_NanoKontrol2.scd").load; });

	1.wait;
	OSCdef.freeAll;
	("".resolveRelative++"01_01_datalist_5Unendlich.scd").load;
	("".resolveRelative++"01_02_datalist_returns.scd").load;
	("".resolveRelative++"01_02_datalist_looper2.scd").load;
	("".resolveRelative++"01_02_datalist_granular.scd").load;
	("".resolveRelative++"02_synths_unendlich.scd").load;
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
s.meter;	s.freqscope;
MasterEQ.new(2);

	"=========================== DONE =================================".postln;
},AppClock).start;
)
("".resolveRelative++"01_midiIn_LaunchControlXL.scd").load;
("".resolveRelative++"04_midiforlooper_LaunchControlXL.scd").load;
("".resolveRelative++"04_midiforlooper_LaunchControlXL.scd").openOS;

("".resolveRelative++"01_midiIn_LaunchControlXL.scd").openOS;

ChannelEQ(target: ~mixer[8]);
(target: ~mixer[8]);

s.meter;	s.freqscope;
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
