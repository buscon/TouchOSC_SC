

SynthDef(\impulses, { | outbus = 0, impulseSpeed = 1, dustSpeed = 0, freqMul = 1, decayMul = 1, mulMul = 1, speedChange = 1, freqLPF = 22000, mulChange = 1,volume = 1 |
	var sig;
	impulseSpeed = impulseSpeed + LFNoise0.kr(speedChange).range(0, mulChange);
	sig = Ringz.ar(PinkNoise.ar(Impulse.ar(impulseSpeed.abs) + Dust.ar(dustSpeed) ), {gauss(300, 20000)}.dup(50) * freqMul, {exprand(0.3, 1.0)}.dup(50) * decayMul, {exprand(0.3, 1.0)}.dup(50) * mulMul).mean.dup(2);
	sig = LPF.ar(sig, freqLPF);
	Out.ar(outbus, sig * volume);
}).add;

