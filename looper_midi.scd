[~chan1, ~chan2, ~chan3, ~rvbmc, ~chorusC, ~delC, ~master].do(_.free);

(
~master = MixerChannel(\master, s, 2, 2, level:1);
~chan1 = MixerChannel(\dust_touch, s, 2, 2, outbus:~master, postSendReady:true);
~chan2 = MixerChannel(\harmMod, s, 2, 2, outbus:~master, postSendReady:true);

~rvbmc = MixerChannel.new("chn rvb", s, 2, 2, outbus:~master);
~chorusC = MixerChannel.new("chn ch", s, 2, 2, outbus:~master);
~delC = MixerChannel.new("chn delay", s, 2, 2, outbus:~master);

//~dlysynth = ~chan.playfx(\blipDelay, [\bufnum, ~dlybuf.bufnum, \t_repan, 1]);

~rvb = ~rvbmc.playfx(\GVerb);
~chr = ~chorusC.playfx("fx/chorus1x1");
~del = ~delC.playfx(\delay);

~chan1_s = ~chan1.play(\dust_touch);
~chan2_s = ~chan2.play(\harmMod, [\carrier, 10, \harm, 6, \bright, 3, \volume, 0.1]);
//~chan_mix = ~chan.play(\dust_touch);

//r.play;

)
(
~send1_r = ~chan1.newPostSend(~rvbmc, 0);
~send1_ch = ~chan1.newPostSend(~chorusC, 0);

~send1_del = ~chan1.newPostSend(~delC, 1);
//~send1_del.level = 1;

)

~chan1_s.mute  = 0;  // silence

~chan1.mute(false);

aMixer.synth.map(\level, aMixer.controls[\level].bus);  // unmute
~chan1_s.set(\density, 5);
~chan1.muteMe = 1;
~send1_r = ~chan1.newPostSend(~rvbmc, 1);
~send1_r.level = 0.5;
~send1_ch = ~chan1.newPostSend(~chorusC, 0.41);
~send1_ch.level = 1;
~send1_del = ~chan1.newPostSend(~delC, 1);
~send1_del.level = 1;

~chan1.pan = 0;

~send2_ch = ~chan2.newPostSend(~chorusC, 0.41);
~send2_ch.level = 1;

~chan2.level = 0.2;

~send2 = ~chan2.newPostSend(~rvbmc, 1);
~send2.level = 0;
~send2 = ~chan2.newPostSend(~chorusC, 1);

~board = MixingBoard("demo", nil, ~chan1, ~chan2, ~rvbmc, ~chorusC, ~delC, ~master);
~board.postSettings;

(

// LauchControl XL
~muteColor1 = 127;
MIDIIn.control = {arg src, chan, num, val;
x = case
	//Channels Volume
	{ num == 77} {~chan1.level = val.linlin(0, 127, 0.0, 1.0).postln}
		{ num == 78} {~chan2.level = val.linlin(0, 127, 0.0, 1.0).postln}

	//Sends
		{ num == 13} {~send1_r.level = val.linlin(0, 127, 0.0, 1.0).postln}
		{ num == 14} {~send2_r.level = val.linlin(0, 127, 0.0, 1.0).postln}


	;
		num.postln;

/*
	src.postln;
	chan.postln;


	*/
};

MIDIIn.noteOn = {arg src, chan, num, vel;
	//{ num == 41} {val.postln}
	x = case
	// Mute and Solo

	{ num == 41 } {chan.postln;if ( ~muteColor1 == 127, {~midiOutXL.noteOn(chan, num, 124); ~muteColor1 = 124;
~chan1.mute(false); }, {~midiOutXL.noteOn(chan, num, 127); ~muteColor1 = 127;
~chan1.mute(true); } )}

	;
		num.postln;
}
)

(
~play = { arg l;
			l.set(\loop_play, 1);
			l.set(\loop_rec, 0);
			l.set(\reclevel, 0);
			~l.set(\prelevel, 1);
};
~play.value(~l);
)
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
	;
		num.postln;
}
)

			overdub1.value();


~midiOutLaunchpad.noteOn(0, 112, 68);

~muteColor1