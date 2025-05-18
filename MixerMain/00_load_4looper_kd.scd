 /*
- formant filter, as return?
- beat repeater?
- trigRate and overlap, exp!
- volume looper, 10 or more


Orgel:
- granulator, LFO per il rate con un Line, LF0 0,1,2, Line e in base a una scala?
*/
(

~path="/Users/marcello/Music/Samples/kriton/selection/*.wav";
~adrs = NetAddr("192.168.1.145", 9000);
~adrs_mixer = ~adrs;//NetAddr("192.168.43.113", 9000);
~adrs_looper = NetAddr("192.168.1.123", 9000);
//~adrs = NetAddr("169.254.39.2", 9000);
//~adrs = NetAddr("192.168.43.128", 9000);
//~adrs = NetAddr("192.168.0.102", 9000);
//~adrs = NetAddr("192.168.178.110", 9000);
~osc_port = 5000;
~input_ch1 = 2;
~input_ch2 = 3;
~input_ch3 = 2;
~input_ch4 = 3;
)

//("".resolveRelative++"01_midiIn.scd").load;
("".resolveRelative++"01_midiIn_NoLaunchpad.scd").load;

(
("".resolveRelative++"01_01_datalist_3instr.scd").load;
("".resolveRelative++"01_02_datalist_returns.scd").load;
("".resolveRelative++"01_02_datalist_looper4.scd").load;
("".resolveRelative++"01_02_datalist_granular.scd").load;
("".resolveRelative++"02_synths.scd").load;

("".resolveRelative++"02_synths_kg.scd").load;
)

("".resolveRelative++"03_mixer_4looper.scd").load;
("".resolveRelative++"03_01_setupOSC.scd").load;
("".resolveRelative++"03_02_setupOSC_mixer.scd").load;
("".resolveRelative++"03_01_setupOSC_synths.scd").load;
("".resolveRelative++"03_01_setupOSC_returns.scd").load;
("".resolveRelative++"04_OSC_looper2.scd").load;

//("".resolveRelative++"04_midiforlooper.scd").load;
("".resolveRelative++"04_midiforlooper_NoLaunchpad.scd").load;
("".resolveRelative++"05_granulatorOSC_new.scd").load;

FreqScope.new;
ChannelEQ(target: ~mixer[8]);
	ChannelEQ(target: ~mixer[3]);

(
FreqScope.new;
/*	ChannelEQ(target: ~mixer[0]);
	ChannelEQ(target: ~mixer[1]);
	ChannelEQ(target: ~mixer[2]);
*/
	ChannelEQ(target: ~mixer[3]);
	ChannelEQ(target: ~mixer[4]);
	ChannelEQ(target: ~mixer[5]);
	ChannelEQ(target: ~mixer[6]);
	ChannelEQ(target: ~mixer[7]);
)
//("/Users/marcello/Music/Supercollider/mixer/06_touchosc.scd").load;

//Free

("".resolveRelative++"free_returns.scd").load;
(
~chan3.level = 0.4;
~senda_3.level = 0;
~sendb_3.level = 1;
~sendc_3.level = 0;
~parameters[2][0].set(~parameters[2][1][1][5][0], 0.5);

)
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
//~copiedBuf_to_gran[4].plot
//~buf_array[1][1].normalize


(
8.size.do({ |i|
	ChannelEQ(target: ~mixer[i]);
});
)

/*
TODO:

*Antii*

- resonance instruments with input selection or combinations
- LPF and HPF p er loopers and instruments
-

*RETURNS*
3. return more interesting

*SOUNDS*
- freqShift fine for: looper, granular, and all the synths! microtonal! also with long lag!
- LF0 per ogni suono, in modo da renderlo non atmosferico

- aggiungere un granular, provare con Warp1
- granular con attack and decay modulabili

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