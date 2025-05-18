(
MIDIClient.init;
//0 is iac bus internal routing from live!
~midiSourceXL = MIDIClient.sources.detect({|a|a.name.contains("Launch Control XL")});

~midiDestXL = MIDIClient.destinations.detect{|a|a.name.contains("Launch Control XL")};

 MIDIIn.connect(0, ~midiSourceXL.uid);

~midiOutXL = MIDIOut.new(1,~midiDestXL.uid);




//debug
/*
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
*/
)