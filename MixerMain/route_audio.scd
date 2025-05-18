(
Ndef(\route_ganesh, { arg volume = 1.0;
	var sig ;
	sig = SoundIn.ar(1,1);
	Out.ar(0, sig * volume);
}).play;
)

Ndef(\route_ganesh).set(\volume, 1.0);