

(
var key11, key12, key13, key14, key15, key16, key17, key18,
key21, key22, key23, key24, key25, key26, key27, key28,
play1 = {
			~l.set(\loop_play, 1);
			~l.set(\loop_rec, 0);
			~l.set(\reclevel, 0);
			~l.set(\prelevel, 1);
},
overdub1 = {
			~l.set(\loop_play, 1);
			~l.set(\loop_rec, 1);
			~l.set(\reclevel, 0.5);
			~l.set(\prelevel, 0.5);
			~l.set(\trigger, 0);
			~l.set(\trigger, 1);
},
rec1 = {
			~l.set(\loop_play, 1);
			~l.set(\loop_rec, 1);
			~l.set(\reclevel, 1);
			~l.set(\prelevel, 0);
			~l.set(\trigger, 0);
			~l.set(\trigger, 1);
},
play2 = {
			~l2.set(\loop_play, 1);
			~l2.set(\loop_rec, 0);
			~l2.set(\reclevel, 0);
			~l2.set(\prelevel, 1);
},
overdub2 = {
			~l2.set(\loop_play, 1);
			~l2.set(\loop_rec, 1);
			~l2.set(\reclevel, 0.5);
			~l2.set(\prelevel, 0.5);
			~l2.set(\trigger, 0);
			~l2.set(\trigger, 1);
},
rec2 = {
			~l2.set(\loop_play, 1);
			~l2.set(\loop_rec, 1);
			~l2.set(\reclevel, 1);
			~l2.set(\prelevel, 0);
			~l2.set(\trigger, 0);
			~l2.set(\trigger, 1);
};
// Colors
~red = 67;
~yellow = 127;
~green = 124;
~noColor = 68;

/************************ MIXER ****************************/

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
	num.postln;
x = case
	//Channels  Volume
	{ num == 77} {~mixer[0].level = val.linlin(0, 127, 0.0, 1.0).postln}
		{ num == 78} {~mixer[1].level = val.linlin(0, 127, 0.0, 1.0).postln}
		{ num == 79} {~mixer[2].level = val.linlin(0, 127, 0.0, 1.0).postln}
		{ num == 80} {~mixer[3].level = val.linlin(0, 127, 0.0, 1.0).postln}
		{ num == 81} {~mixer[4].level = val.linlin(0, 127, 0.0, 1.0).postln}
		{ num == 82} {~mixer[5].level = val.linlin(0, 127, 0.0, 1.0).postln}
		{ num == 83} {~mixer[6].level = val.linlin(0, 127, 0.0, 1.0).postln}
		{ num == 84} {~mixer[7].level = val.linlin(0, 127, 0.0, 1.0).postln}



	//Sends

		{ num == 13} {~senda[0].level = val.linlin(0, 127, 0.0, 1.0).postln}
		{ num == 14} {~senda[1].level = val.linlin(0, 127, 0.0, 1.0).postln}
		{ num == 15} {~senda[2].level = val.linlin(0, 127, 0.0, 1.0).postln}
		{ num == 16} {~senda[3].level = val.linlin(0, 127, 0.0, 1.0).postln}
		{ num == 17} {~senda[4].level = val.linlin(0, 127, 0.0, 1.0).postln}
		{ num == 18} {~senda[5].level = val.linlin(0, 127, 0.0, 1.0).postln}
		{ num == 19} {~senda[6].level = val.linlin(0, 127, 0.0, 1.0).postln}
		{ num == 20} {~senda[7].level = val.linlin(0, 127, 0.0, 1.0).postln}


	{ num == 29} {~sendb[0].level = val.linlin(0, 127, 0.0, 1.0).postln}
		{ num == 30} {~sendb[1].level = val.linlin(0, 127, 0.0, 1.0).postln}
		{ num == 31} {~sendb[2].level = val.linlin(0, 127, 0.0, 1.0).postln}
		{ num == 32} {~sendb[3].level = val.linlin(0, 127, 0.0, 1.0).postln}
		{ num == 33} {~sendb[4].level = val.linlin(0, 127, 0.0, 1.0).postln}
		{ num == 34} {~sendb[5].level = val.linlin(0, 127, 0.0, 1.0).postln}
		{ num == 35} {~sendb[6].level = val.linlin(0, 127, 0.0, 1.0).postln}
		{ num == 36} {~sendb[7].level = val.linlin(0, 127, 0.0, 1.0).postln}


		{ num == 49} {~sendc[0].level = val.linlin(0, 127, 0.0, 1.0).postln}
		{ num == 50} {~sendc[1].level = val.linlin(0, 127, 0.0, 1.0).postln}
		{ num == 51} {~sendc[2].level = val.linlin(0, 127, 0.0, 1.0).postln}
		{ num == 52} {~sendc[3].level = val.linlin(0, 127, 0.0, 1.0).postln}
		{ num == 53} {~sendc[4].level = val.linlin(0, 127, 0.0, 1.0).postln}
		{ num == 54} {~sendc[5].level = val.linlin(0, 127, 0.0, 1.0).postln}
		{ num == 55} {~sendc[6].level = val.linlin(0, 127, 0.0, 1.0).postln}
		{ num == 56} {~sendc[7].level = val.linlin(0, 127, 0.0, 1.0).postln}


	;




};



// Colors
~red = 67;
~yellow = 127;
~green = 124;
~noColor = 68;
//Launchpad

key11 = ~noColor;
key12 = ~noColor;
key13 = ~noColor;
key14 = ~noColor;

key15 = ~noColor;

key16 = ~noColor;
key17 = ~noColor;
key18 = ~noColor;

key21 = ~noColor;
key22 = ~noColor;
key23 = ~noColor;
key24 = ~noColor;
key25 = ~noColor;
key26 = ~noColor;
key27 = ~noColor;
key28 = ~noColor;

~midiOutLaunchpad.noteOn(0, 112, ~noColor);
~midiOutLaunchpad.noteOn(0, 96, ~noColor);
~midiOutLaunchpad.noteOn(0, 0, ~noColor);


~midiOutLaunchpad.noteOn(0, 113, ~noColor);
~midiOutLaunchpad.noteOn(0, 97, ~noColor);
~midiOutLaunchpad.noteOn(0, 1, ~noColor);

MIDIIn.noteOn = {arg src, chan, num, vel;
	//{ num == 41} {val.postln}
	x = case
// Looper channel 1, column 1
	{ num == 112 } {chan.postln;if ( key11 == ~noColor,
		{
			~midiOutLaunchpad.noteOn(chan, num, ~red);
			key11 = ~red;
			rec1.value();
	}, {
			~midiOutLaunchpad.noteOn(chan, num, ~noColor);
			key11 = ~noColor;
			play1.value();
	} )}
		{ num == 96 } {chan.postln;if ( key12 == ~noColor,
		{
			overdub1.value();
			~midiOutLaunchpad.noteOn(chan, num, ~yellow);
			key12 = ~yellow;

	}, {
			~midiOutLaunchpad.noteOn(chan, num, ~noColor);
			key12 = ~noColor;
			play1.value();


	} )}


		{ num == 0} {chan.postln;if ( key18 == ~noColor,
		{
			~midiOutLaunchpad.noteOn(chan, num, ~green);
			key18 = ~green;
			//~l = ~looper.play(~buf2);
			~l = Synth(\looper, [\buf, ~buf2]);

	}, {
			~midiOutLaunchpad.noteOn(chan, num, ~noColor);
			key18 = ~noColor;
			~l.set(\loop_play, 0);
			~l.set(\loop_rec, 0);
			~l.free;
	} )}


	// Looper channel 2, column 2

	{ num == 113 } {chan.postln;if ( key21 == ~noColor,
		{
			~midiOutLaunchpad.noteOn(chan, num, ~red);
			key21 = ~red;
			rec2.value();
	}, {
			~midiOutLaunchpad.noteOn(chan, num, ~noColor);
			key21 = ~noColor;
			play2.value();
	} )}
		{ num == 97 } {chan.postln;if ( key22 == ~noColor,
		{
			overdub2.value();
			~midiOutLaunchpad.noteOn(chan, num, ~yellow);
			key22 = ~yellow;

	}, {
			~midiOutLaunchpad.noteOn(chan, num, ~noColor);
			key22 = ~noColor;
			play2.value();


	} )}

		{ num == 1} {chan.postln;if ( key28 == ~noColor,
		{
			~midiOutLaunchpad.noteOn(chan, num, ~green);
			key28 = ~green;
			//~l = ~looper.play(~buf4);
			~l2 = Synth(\looper, [\buf, ~buf4]);

	}, {
			~midiOutLaunchpad.noteOn(chan, num, ~noColor);
			key28 = ~noColor;
			~l2.free;
	} )}


		// Mute and Solo

	{ num == 41 } {chan.postln;if ( ~muteColor1 == ~green, {~midiOutXL.noteOn(chan, num, ~red); ~muteColor1 = ~red;
~mixer[0].mute(true); }, {~midiOutXL.noteOn(chan, num, ~green); ~muteColor1 = ~green;
~mixer[0].mute(false); } )}
		{ num == 42 } {chan.postln;if ( ~muteColor2 == ~green, {~midiOutXL.noteOn(chan, num, ~red); ~muteColor2 = ~red;
~mixer[1].mute(true); }, {~midiOutXL.noteOn(chan, num, ~green); ~muteColor2 = ~green;
~mixer[1].mute(false); } )}
		{ num == 43 } {chan.postln;if ( ~muteColor3 == ~green, {~midiOutXL.noteOn(chan, num, ~red); ~muteColor3 = ~red;
~mixer[2].mute(true); }, {~midiOutXL.noteOn(chan, num, ~green); ~muteColor3 = ~green;
~mixer[2].mute(false); } )}
	{ num == 44 } {chan.postln;if ( ~muteColor4 == ~green, {~midiOutXL.noteOn(chan, num, ~red); ~muteColor4 = ~red; ~mixer[3].mute(true); }, {~midiOutXL.noteOn(chan, num, ~green); ~muteColor4 = ~green;
~mixer[3].mute(false); } )}
		{ num == 57 } {chan.postln;if ( ~muteColor5 == ~green, {~midiOutXL.noteOn(chan, num, ~red); ~muteColor5 = ~red;
~mixer[4].mute(true); }, {~midiOutXL.noteOn(chan, num, ~green); ~muteColor5 = ~green;
~mixer[4].mute(false); } )}
		{ num == 58 } {chan.postln;if ( ~muteColor6 == ~green, {~midiOutXL.noteOn(chan, num, ~red); ~muteColor6 = ~red;
~mixer[5].mute(true); }, {~midiOutXL.noteOn(chan, num, ~green); ~muteColor6 = ~green;
~mixer[5].mute(false); } )}
		{ num == 59 } {chan.postln;if ( ~muteColor7 == ~green, {~midiOutXL.noteOn(chan, num, ~red); ~muteColor7 = ~red;
~mixer[6].mute(true); }, {~midiOutXL.noteOn(chan, num, ~green); ~muteColor7 = ~green;
~mixer[6].mute(false); } )}
		{ num == 57 } {chan.postln;if ( ~muteColor8 == ~green, {~midiOutXL.noteOn(chan, num, ~red); ~muteColor8 = ~red;
~mixer[7].mute(true); }, {~midiOutXL.noteOn(chan, num, ~green); ~muteColor8 = ~green;
~mixer[7].mute(false); } )}

	;
		num.postln;
}
)