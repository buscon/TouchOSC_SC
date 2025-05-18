
//MIDIClient.init;
//0 is iac bus internal routing from live!
//~nk2 = MKtl('nk2', "korg-nanokontrol2");
~lcXL = MKtl('myXL', "novation-launchcontrol-xl", false, 0);


/*
~lcXL2 = MKtl('myXL', "novation-launchcontrol-xl", false, 1);

~lcXL.trace(true);
~lcXL2.trace(true);

~lcXL.trace(false);
~lcXL2.trace(false);

~lcXL.trace(true);
~lcXL.free
~lcXL


//debug

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
