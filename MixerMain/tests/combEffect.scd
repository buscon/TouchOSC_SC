(
a = Ndef(\combEffect, {arg outbus = 0, lfoRate = 0.125, phase = 0, depth = 10, predelay = 10, maxdelaytime = 0.5, fdbAmt = -0.87, drywet = 0;
var source, chorus, delays = 10, sig;

var lfo = SinOsc.ar(lfoRate, phase, depth, predelay) * 0.001;

	source =  In.ar(outbus, 2);
//SoundIn.ar(3);

chorus = Mix.fill(delays, {
    var fdbIn, fdbOut, sig, out;
    fdbIn = LocalIn.ar(2);
    sig = DelayC.ar(source + fdbIn, maxdelaytime, lfo);
    fdbOut = LocalOut.ar(sig * fdbAmt);
    sig * 1/delays
    });
	sig = Select.ar(drywet, [source, chorus]);
	Limiter.ar(sig, 0.9);
ReplaceOut.ar(outbus, sig.poll);


}).play;
//a.addSpec( \fdbAmt, [ -0.800, -1.0, \exp, 0.1 ] );

)
(
SynthDef(\click, {
	Out.ar(0, SinOsc.ar(200,  0, 0.1)!2 * EnvGen.ar(Env.perc, doneAction:2) )
}).play;
)
a.addSpec( \fdbAmt, [ 0.8, 1.03, \exp, 0.001 ] );
a.set(\fdbAmt, -0.98);
a.gui