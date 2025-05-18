MIDIClient.init;
MIDIIn.connectAll;
MIDIOut.connectByUID(3);
m = MIDIOut.connect(0);
	MIDIOut.allNotesOff(16); //Clear all lights before setting another
	m.noteOn(16,~originalMIDIValue,~colourValue);

~midiOut.noteOn(8,41, 127);
~midiOut.noteOn(0,55,127);
(
MIDIClient.init;
//0 is iac bus internal routing from live!
/*
~midiSourceXL = MIDIClient.sources.detect({|a|a.name.contains("Launch Control XL")});

~midiDestXL = MIDIClient.destinations.detect{|a|a.name.contains("Launch Control XL")};

MIDIIn.connect(0, ~midiSourceXL.uid);

~midiOutXL = MIDIOut.new(1,~midiDestXL.uid);
*/
~midiSourceLaunchpad = MIDIClient.sources.detect({|a|a.name.contains("Launchpad")});

~midiDestLaunchpad = MIDIClient.destinations.detect{|a|a.name.contains("Launchpad")};

MIDIIn.connect(0, ~midiSourceLaunchpad.uid);

~midiOutLaunchpad = MIDIOut.new(0, ~midiDestLaunchpad.uid);


//set the action:
MIDIIn.control = {arg src, chan, num, val;
src.postln;
	chan.postln;

	num.postln;

	val.postln;
};
MIDIIn.noteOn = {arg src, chan, num, vel;
src.postln;
	chan.postln;

	num.postln;

	vel.postln;
};

// Colors
~red = 67;
~yellow = 127;
~green = 124;

);
//next define your synth and start the server
(
MIDIIn.connect;
s = Server.local;
s.boot;
s.latency = 0;

SynthDef("sik-goo", { arg freq=400,fromfreq=100, gate=0.0, bwfreq=800;
var x;
x = Formant.ar(
SinOsc.kr(0.02,0,10,freq),
fromfreq,
bwfreq
);
x = EnvGen.kr(Env.adsr,gate,Latch.kr(gate,gate)) * x;
Out.ar(0,x);
}).send(s);
);
//finally link the midi actions to the defined synth parameters
(
x = Synth("insidePiano1");
// action;
MIDIIn.noteOn = {arg src,chan,num,vel;
x.set(\freq,num.postln.midicps.postln /4.0);
x.set(\gate, vel / 200);
x.set(\formfreq, vel / 127 *1000 );
};
MIDIIn.noteOff = { arg src,chan,num,vel;
x.set(\gate, 0.0);
};
MIDIIn.bend = { arg src,chan,val;
x.set(\bwfreq,val * 0.048828125 );
};
);

// cleanup
x.free;