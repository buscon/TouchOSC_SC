/*
TODO:
//


*RETURNS*
3. return more interesting

*SOUNDS*
- freqShift fine for: looper, granular, and all the synths! microtonal! also with long lag!
- LF0 per ogni suono, in modo da renderlo non atmosferico


*INTERFACE*
- rendere dinamico granulator OSC
- controlli del looper su touchosc:
  * button to write recorded buf to disk.
  * button copy recorded buf to another buf to play it later.
- button for presets, recall and store?


- looper su launchpad, tasti che lampeggiano in base al timing del looper
- sempre su launchpad, pulsanti restanti come note midi?
oppure per accendere spegnere effetti?
*/
s.quit
s.boot;
(
//~path="/Users/marcello/Music/Samples/MartinLau/*.wav";
//~path="/Users/mlarcello/Music/Samples/Piano/Inside/*.wav";
//~path="/Users/marcello/Music/Samples/orgel/lausitzer/*.wav";
~path="/Users/marcello/Music/Samples/GranularSelection/*.wav";

~adrs = NetAddr("192.168.1.145", 9000);
//~adrs = NetAddr("192.168.0.103", 9000);

//~adrs = NetAddr("169.254.8.170", 9000);
//~adrs = NetAddr("169.254.2.156", 9000);

~adrs_looper = NetAddr("192.168.1.194", 9000);
~adrs_mixer = ~adrs_looper;//NetAddr("192.168.43.113", 9000);

~adrs_xy = ~adrs;//NetAddr("192.168.1.194", 9000);

~adrs_granulator = ~adrs;
~adrs_trigger = ~adrs_looper;
//~adrs = NetAddr("169.254.212.139", 9000);

//~adrs = NetAddr("169.254.241.141", 9000);

//~adrs = NetAddr("169.254.224.149", 9000);
~osc_port = 5000;
~input_ch1 = 0;
~input_ch2 = 1;
~midi = 0;
~num_channels = 2;
//~input_ch3 = 2;
//~input_ch4 = 2;
	//("".resolveRelative++"02_synths_debug.scd").load;

)

("".resolveRelative).openOS
	("".resolveRelative++"03_01_setupOSC.scd").load;
	("".resolveRelative++"02_synths_debug.scd").openOS;
	("".resolveRelative++"01_01_datalist_5instr.scd").load;
	("".resolveRelative++"01_02_datalist_looper2.scd").openOS;


(
r = Task({
		if(~midi > 0,{("".resolveRelative++"01_midiIn_NoLaunchpad.scd").load; });
	1.wait;
	OSCdef.freeAll;
	("".resolveRelative++"01_01_datalist_5instr.scd").load;
	("".resolveRelative++"01_02_datalist_returns.scd").load;
	("".resolveRelative++"01_02_datalist_looper2.scd").load;
	("".resolveRelative++"01_02_datalist_granular.scd").load;
	("".resolveRelative++"02_synths_debug.scd").load;
	1.wait;
	("".resolveRelative++"03_mixer_2looper_editForWaveS1.scd").load;
	5.wait;

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
	if(~midi > 0, {("".resolveRelative++"04_midiforlooper_NoLaunchpad.scd").load; });
	1.wait;
	("".resolveRelative++"05_granulatorOSC_new.scd").load;


	1.wait;
	"=========================== DONE =================================".postln;
}).start;
)
	("".resolveRelative++"04_OSC_looper2.scd").load;

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
