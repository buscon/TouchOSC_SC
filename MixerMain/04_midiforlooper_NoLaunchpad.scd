

/************************ MIXER ****************************/
// Colors
~red = 67;
~yellow = 127;
~green = 124;
~noColor = 68;
~midiOutXL.noteOn(8, 41, ~green);
~midiOutXL.noteOn(8, 42, ~green);
~midiOutXL.noteOn(8, 43, ~green);

~midiOutXL.noteOn(8, 44, ~green);
~midiOutXL.noteOn(8, 57, ~green);
~midiOutXL.noteOn(8, 58, ~green);
~midiOutXL.noteOn(8, 59, ~green);
~midiOutXL.noteOn(8, 60, ~green);



/*
PeakMonitor(~mixer[0]);
PeakMonitor(~mixer[1]);
PeakMonitor(~mixer[2]);
PeakMonitor(~mixer[3]);
*/
// LauchControl XL
MIDIIn.control = {arg src, chan, num, val;
	//num.postln;
	x = case
	//Channels  Volume
	{ num == 77} {~mixer[0].level = val.linlin(0, 127, 0.0, 1.0)}
	{ num == 78} {~mixer[1].level = val.linlin(0, 127, 0.0, 1.0).postln}
	{ num == 79} {~mixer[2].level = val.linlin(10, 127, 0.0, 1.0).postln}
	{ num == 80} {~mixer[3].level = val.linlin(0, 127, 0.0, 1.0)}
	{ num == 81} {~mixer[4].level = val.linlin(0, 127, 0.0, 1.0)}
	{ num == 82} {~mixer[5].level = val.linlin(0, 127, 0.0, 1.0)}
	{ num == 83} {~mixer[6].level = val.linlin(0, 127, 0.0, 1.0)}
	{ num == 84} {~mixer[7].level = val.linlin(0, 127, 0.0, 1.0)}



	//Sends

	{ num == 13} {~senda[0].level = val.linlin(0, 127, 0.0, 1.0)}
	{ num == 14} {~senda[1].level = val.linlin(0, 127, 0.0, 1.0)}
	{ num == 15} {~senda[2].level = val.linlin(0, 127, 0.0, 1.0)}
	{ num == 16} {~senda[3].level = val.linlin(0, 127, 0.0, 1.0)}
	{ num == 17} {~senda[4].level = val.linlin(0, 127, 0.0, 1.0)}
	{ num == 18} {~senda[5].level = val.linlin(0, 127, 0.0, 1.0)}
	{ num == 19} {~senda[6].level = val.linlin(0, 127, 0.0, 1.0)}
	{ num == 20} {~senda[7].level = val.linlin(0, 127, 0.0, 1.0)}


	{ num == 29} {~sendb[0].level = val.linlin(0, 127, 0.0, 1.0)}
	{ num == 30} {~sendb[1].level = val.linlin(0, 127, 0.0, 1.0)}
	{ num == 31} {~sendb[2].level = val.linlin(0, 127, 0.0, 1.0)}
	{ num == 32} {~sendb[3].level = val.linlin(0, 127, 0.0, 1.0)}
	{ num == 33} {~sendb[4].level = val.linlin(0, 127, 0.0, 1.0)}
	{ num == 34} {~sendb[5].level = val.linlin(0, 127, 0.0, 1.0)}
	{ num == 35} {~sendb[6].level = val.linlin(0, 127, 0.0, 1.0)}
	{ num == 36} {~sendb[7].level = val.linlin(0, 127, 0.0, 1.0)}


	{ num == 49} {~sendc[0].level = val.linlin(0, 127, 0.0, 1.0)}
	{ num == 50} {~sendc[1].level = val.linlin(0, 127, 0.0, 1.0)}
	{ num == 51} {~sendc[2].level = val.linlin(0, 127, 0.0, 1.0)}
	{ num == 52} {~sendc[3].level = val.linlin(0, 127, 0.0, 1.0)}
	{ num == 53} {~sendc[4].level = val.linlin(0, 127, 0.0, 1.0)}
	{ num == 54} {~sendc[5].level = val.linlin(0, 127, 0.0, 1.0)}
	{ num == 55} {~sendc[6].level = val.linlin(0, 127, 0.0, 1.0)}
	{ num == 56} {~sendc[7].level = val.linlin(0, 127, 0.0, 1.0)}

	;
};



// Colors


MIDIIn.noteOn = {arg src, chan, num, vel;
	//{ num == 41} {val.postln}
	x = case

	// Mute and Solo

	{ num == 41 } {chan;if ( ~muteColor1 == ~green, {~midiOutXL.noteOn(chan, num, ~red); ~muteColor1 = ~red;
		~mixer[0].mute(true); }, {~midiOutXL.noteOn(chan, num, ~green); ~muteColor1 = ~green;
			~mixer[0].mute(false); } )}
	{ num == 42 } {chan;if ( ~muteColor2 == ~green, {~midiOutXL.noteOn(chan, num, ~red); ~muteColor2 = ~red;
		~mixer[1].mute(true); }, {~midiOutXL.noteOn(chan, num, ~green); ~muteColor2 = ~green;
			~mixer[1].mute(false); } )}
	{ num == 43 } {chan;if ( ~muteColor3 == ~green, {~midiOutXL.noteOn(chan, num, ~red); ~muteColor3 = ~red;
		~mixer[2].mute(true); }, {~midiOutXL.noteOn(chan, num, ~green); ~muteColor3 = ~green;
			~mixer[2].mute(false); } )}
	{ num == 44 } {chan;if ( ~muteColor4 == ~green, {~midiOutXL.noteOn(chan, num, ~red); ~muteColor4 = ~red; ~mixer[3].mute(true); }, {~midiOutXL.noteOn(chan, num, ~green); ~muteColor4 = ~green;
		~mixer[3].mute(false); } )}
	{ num == 57 } {chan;if ( ~muteColor5 == ~green, {~midiOutXL.noteOn(chan, num, ~red); ~muteColor5 = ~red;
		~mixer[4].mute(true); }, {~midiOutXL.noteOn(chan, num, ~green); ~muteColor5 = ~green;
			~mixer[4].mute(false); } )}
	{ num == 58 } {chan;if ( ~muteColor6 == ~green, {~midiOutXL.noteOn(chan, num, ~red); ~muteColor6 = ~red;
		~mixer[5].mute(true); }, {~midiOutXL.noteOn(chan, num, ~green); ~muteColor6 = ~green;
			~mixer[5].mute(false); } )}
	{ num == 59 } {chan;if ( ~muteColor7 == ~green, {~midiOutXL.noteOn(chan, num, ~red); ~muteColor7 = ~red;
		~mixer[6].mute(true); }, {~midiOutXL.noteOn(chan, num, ~green); ~muteColor7 = ~green;
			~mixer[6].mute(false); } )}
	{ num == 57 } {chan;if ( ~muteColor8 == ~green, {~midiOutXL.noteOn(chan, num, ~red); ~muteColor8 = ~red;
		~mixer[7].mute(true); }, {~midiOutXL.noteOn(chan, num, ~green); ~muteColor8 = ~green;
			~mixer[7].mute(false); } )}

	;
	//num.postln;
}
