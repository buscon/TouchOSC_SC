(
Ndef(\granu, { arg out = 0, bufNum = 0, pos = 0, trigRate = 1, rate = 1, frate = 1, freqLPF = 22000, amtRnd = 0, lfoR = 20, dur = 0.15,
	amFreq = 64, amVol = 0,
	 freqMIDI = 64,
	ffreq_low = 22000, drywet = -0.8,
	panMax = 1, amp = 1, interp = 4, volume = 0, rndTrigRate = 0, speedRndTrigRate = 5, speedRndRate = 5, rndRate = 0, pan = 0, mulPan = 0;

    var trate, rndPos, ausgang, am, midiOsc, freqMod, sig, reverbered, chain;
	rate = rate * frate;
	rndPos = LFNoise0.kr(lfoR, amtRnd);
	//trate = (trigRate + LFNoise0.kr(speedRndTrigRate, rndTrigRate)).abs ;
	trate = (trigRate + {rndTrigRate.sum3rand.poll}).abs.poll ;

	rate = rate + LFNoise0.kr(speedRndRate, rndRate);
	ausgang = TGrains2.ar(2, Impulse.kr(trate) , bufNum, rate, ((pos + rndPos).range(0,  BufDur.kr(bufNum))) , dur , 0, amp, 0.01);

	// AM
	am = SinOsc.ar( freqMIDI+amFreq, mul:amVol*1.5) * SinOsc.ar( (freqMIDI+amFreq)/2, mul:amVol*1.5);

	//ausgang = RLPF.ar(ausgang, ffreq_low, 0.9);
	ausgang = XFade2.ar(ausgang, ausgang * am, amVol.linlin(0, 1, -1, 1));
	ausgang = LPF.ar(ausgang, freqLPF.lag(1));

	//ausgang = EnvGen.kr(Env.adsr(attackTime: 0.01, sustainLevel: 1, decayTime: 0.5, releaseTime:1),gate, Latch.kr(gate,gate)) * ausgang;
	//ausgang = Array.fill(8, CombN.ar(ausgang, 0.2, {rrand(0.05, 0.01)}, {rrand(0.3, 0.01)} , 1/8));
	sig = Mix.new(ausgang).softclip(0.9);

	//chain = Mix.new( chain );
	//reverbered = GVerb.ar(ausgang, 10, 3 );

	//sig = XFade2.ar(ausgang, reverbered, drywet);
	sig = Pan2.ar(sig, pan + LFNoise0.kr(1, mulPan));
	Out.ar(out, sig * volume  );

}).add;
)

Ndef(\granu).play;
Ndef(\granu).set( \bufNum, 0, \amVol, 0, \master_vol, 0.3, \volume, 1, \dur, 0.1, \trigRate, 5, \rndTrigRate, 3, \speedRndTrigRate, 6);
Ndef(\granu).set( \bufNum, 5, \amVol, 0,\master_vol, 0.3, \dur, 0.15);