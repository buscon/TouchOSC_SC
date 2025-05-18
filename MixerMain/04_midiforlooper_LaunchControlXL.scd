/*
~lcXL.elAt(\pg8, \bt, \fcs, 0).action = {arg el; el.value.postln;}
MKtl('myXL').trace(false);
			~lcXL.setValueAt("pg8_bt_fcs_" ++ index ++ "_on", 1);
		~lcXL.elAt(\pg8, \sl, 0).action = {arg el; el.value.postln };
"pg8_bt_fcs_" ++ 0 ++ "_on"
~lcXL.setValueAt(("pg8_bt_fcs_" ++ 1 ++ "_on").asSymbol, 0);
~lcXL.setValueAt(\pg8_bt_fcs_1_on, 1);
~lcXL.setValueAt("pg8_bt_fcs_1_on", 0);

);
*/

8.do({|index|
	~lcXL.elAt(\pg8, \kn, \sndA, index).action = {arg el; ~senda[index].level = el.value };
		~lcXL.elAt(\pg8, \kn, \sndB, index).action = {arg el; ~sendb[index].level = el.value };
	~lcXL.elAt(\pg8, \kn, \pan, index).action = {arg el; ~sendc[index].level = el.value };

		~lcXL.elAt(\pg8, \sl, index).action = {arg el; ~mixer[index].level = el.value };
		~lcXL.elAt(\pg8, \bt, \fcs, index).action = {arg el; if(el.value == 1,
		{ ~mixer[index].mute(true);
			~lcXL.setValueAt(("pg8_bt_fcs_" ++ (index + 1) ++ "_on").asSymbol, 1);

		} ,
		{ ~mixer[index].mute(false);
			~lcXL.setValueAt(("pg8_bt_fcs_" ++ (index + 1) ++ "_on").asSymbol, 0);

	} ); };
	// solo ?	~nk2.elAt(\bt, 0, index).action = {arg el; if(el.value == 1, { ~mixer[index].solo(true);} , { ~mixer[0].solo(false); } ); };

});


/*
~nk2.elAt(\sl, 0).action = {arg el; ~mixer[0].level = el.value };
~nk2.elAt(\sl, 1).action = {arg el; ~mixer[1].level = el.value };
~nk2.elAt(\sl, 2).action = {arg el; ~mixer[2].level = el.value };
~nk2.elAt(\sl, 3).action = {arg el; ~mixer[3].level = el.value };
~nk2.elAt(\sl, 4).action = {arg el; ~mixer[4].level = el.value };
~nk2.elAt(\sl, 5).action = {arg el; ~mixer[5].level = el.value };
~nk2.elAt(\sl, 6).action = {arg el; ~mixer[6].level = el.value };
~nk2.elAt(\sl, 7).action = {arg el; ~mixer[7].level = el.value };

~nk2.elAt(\kn, 0).action = {arg el; ~senda[0].level = el.value };
~nk2.elAt(\kn, 1).action = {arg el; ~senda[1].level = el.value };
~nk2.elAt(\kn, 2).action = {arg el; ~senda[2].level = el.value };
~nk2.elAt(\kn, 3).action = {arg el; ~senda[3].level = el.value };
~nk2.elAt(\kn, 4).action = {arg el; ~senda[4].level = el.value };
~nk2.elAt(\kn, 5).action = {arg el; ~senda[5].level = el.value };
~nk2.elAt(\kn, 6).action = {arg el; ~senda[6].level = el.value };
~nk2.elAt(\kn, 7).action = {arg el; ~senda[7].level = el.value };

~nk2.elAt(\bt, 0, 0).action = {arg el; if(el.value = ~senda[7].level = el.value };


	// Colors
	(

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
	};
	)
	*/
	