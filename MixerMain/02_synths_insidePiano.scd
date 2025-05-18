
(
SynthDef(\combP, {|outbus = 0, intensity = 0.5, input = 0, gainInput = 1,
	 delayscale = 0.1, decaytime = 1, mulComb = 0.5,
	pitchRatio = 1, pitchDispersion = 0,timeDispersion = 0, mulPShift = 1,
	freqRingz = 600, decayRingz = 1, mulRingz = 0.01, volume = 1|
	var out, in, trig, pitch, delaytime, amp;
	delaytime = ({0.015 * rrand(0.9, 1.1)}).dup(6);//[ 0.090285695660296, 0.011916220633422, 0.024487819703913, 0.048559433922072, 0.036170286488402, 0.096125769318391 ];//Array.fill(6,{exprand(0.01, 0.1)}).postln;
	in = SoundIn.ar(input) * gainInput;
	in = HPF.ar(in, 100);
	out = in;//PinkNoise.ar(0.1);
	//out = Impulse.ar(intensity);
	//in = WhiteNoise.ar(0.5);
	delayscale = delayscale.lag(0.1);
	amp = Amplitude.kr(in, 0.01, 0.3).linlin(0.003, 0.03, 0, 1);
	pitch = Pitch.kr(in);
	out = PitchShift.ar( out, 0.2, pitchRatio, pitchDispersion,timeDispersion, mulPShift ) + out;

	//if( (amp > 0.1), {delayscale = rrand(0.050, 0.200).poll});
	out =  Mix.new( CombC.ar(out, 2, (delaytime * delayscale) , decaytime, mulComb/6));// + out;
	//out = CombC.ar(out, 0.2, 0.003, 0.5);
	out = LPF.ar(out, 5000);
	//out = MidEQ.ar(out, 268, 1, -6);
	//out = MidEQ.ar(out, 524, 1, -6);
	//out = MidEQ.ar(out, 524, 1, -6);


	out = out * volume;// *  amp.linlin(0, 1, 0, 0.6).lag(1);
	//out = Mix.ar(out);
		//out = GVerb.ar(out, 50, 3);
	out = Limiter.ar(out)!2;
	Out.ar(outbus , out);
}).add;
SynthDef(\gendyP, { arg outbus = 0, volume = 0, input = 0, freqMul = 1, amp_thres = 0.0001, freqMaxMul = 2, freqMinMul = 0.5, decayscale = 1, master_volume = 1, amp_max = 0.9;
var scale, specs, freqs, amp, in = SoundIn.ar(input),
	numRes = 10, bells = 1, pan, freq, hasFreq = 1, freqScale, out;
	in = HPF.ar(in, 50);
	# freq, hasFreq = Pitch.kr(in, 200, 60, 900, ampThreshold:0.001);
	amp = Amplitude.kr(in, 0.01, 0.1);

	//out = SinOsc.ar(freq);
	//out = Ringz.ar(in, freq*freqMul,2, 1);

	// sinosc
	//out = SinOsc.ar(freq);
	//out = Blip.ar(freq/4, 100);

	//example ringz
	//out = Ringz.ar(in1, freq*2,1, 1);
	//example gendy
	out = Gendy1.ar(maxfreq: (freq * freqMaxMul), minfreq: (freq * freqMinMul * {rrand(0.900,1.100)}), ampscale: amp);

	//out = Ringz.ar(out, freq,1, 0.01);
	out = HPF.ar(out, 20);
	out = out * volume * amp.linlin(0, 1, 0, amp_max);
	//out = FreeVerb.ar(out, 0.5);
	out = Compander.ar(out, out,  thresh: 0.4, slopeBelow: 0.7, slopeAbove: 0.1, clampTime: 0.002,relaxTime: 0.01) ;
	//out = GVerb.ar(out, 100, 2).clip2(0.9) ;
	out = Mix.ar(out)!2;
	out = Limiter.ar(out, 0.9) * master_volume;
	Out.ar(outbus, out );
}).add;
SynthDef(\gendy, { arg outbus = 0, volume = 0, freq = 300, freqFine = 1, freqMinMul = 0.5, freqMaxMul = 2, ampdist = 1, durdist = 0.5, adparam = 0.5, ddparram = 0.5,  ampscale= 0.5, durscale = 0.5, initCPs = 12, kumcps = 6, numcps = 12, n = 5, freqResonz = 800, bwr = 0.1;
var  sig;
n=30;
freq = freq * freqFine;
sig =
	//Resonz.ar(
Mix.fill(n,{
//var freq, numcps;

//freq= rrand(330,460.3);
//numcps= rrand(2,20);
Pan2.ar(Gendy4.ar(ampdist, durdist, adparam, ddparram,freq * freqMinMul, freq * freqMaxMul, ampscale, durscale, initCPs, kumcps, SinOsc.kr(exprand(0.02,0.2), 0, numcps/2, numcps/2), 0.5/(n.sqrt)), 1.0.rand2)
});
	//	, freqResonz, bwr);
	sig = Limiter.ar(sig * volume * 0.1, 0.9).clip2(0.9);
	Out.ar(outbus , sig );

}).add;


SynthDef(\soundRock, { arg outbus = 0, volume = 0, input = 0, freqMul = 1, decayscale = 1;
var scale, specs, freqs, amps, rings, in = SoundIn.ar(input),
	numRes = 10, bells = 1, pan, freq, hasFreq = 1, freqScale, out;
	# freq, hasFreq = Pitch.kr(in, ampThreshold:0.01);
	//Amplitude.kr(in).poll;
//scale = [60, 62, 64, 67, 69].midicps;

//	scale = (Scale.whole.ratios *50).round.midicps;
	scale = [32, 48, 74, 90, 114];
	freqScale = Demand.kr(hasFreq, 0, Drand(scale/65
, inf));

	out = Mix.fill(bells, {
		//freqs = Array.fill(numRes, {rand(0.5, 2.0)*(scale.choose)});
		freqs = Array.fill(numRes, {rand(1.0, 5.0) * (scale.midicps.choose)}).postln * freqScale * freqMul;

		amps = Array.fill(numRes, {rrand(0.3, 0.7)});
		rings = Array.fill(numRes, {rrand(1.0, 4.0)});
		specs = [freqs, amps, rings].round(0.01);
		// specs.postln;
		pan = (LFNoise1.kr(rrand(3, 6))*2).softclip;
		Pan2.ar(

			(DynKlank.ar(`specs, in * 0.5  ) * 0.1)
			+ 	GVerb.ar(Ringz.ar(BrownNoise.ar(0.1), {exprand(70, 20000).postln}.dup(100) * freqScale, 1, 0.001).mean, mul:0.4)
	//input = input);
//			(in * SinOsc.ar(freqs).mean * EnvGen.ar(Env.perc))+
			//* BrownNoise.ar(1)
			,
				pan, bells.reciprocal *4
		)
	});
	out = HPF.ar(out, 20) * 0.1;
	out.clip2(0.9);
	Out.ar(outbus, out * volume);
}).add;
//wavetable
~wave =  Wavetable.chebyFill(512, [1]);
~waveBuf = Buffer.alloc(s, 1024, 1);
~waveBuf.sendCollection(~wave.asWavetableNoWrap);

SynthDef(\waveS1, {arg  outbus = 0,  freq = 400, attack = 0.01, releaseScale = 0.8, volume = 0, speedT = 1, speedLFO = 1, buf = ~waveBuf;
	var  env, output, input, rep, trig, mod, release;

	mod = LFNoise0.kr(1!2).range(1, 2).round;
	speedT = speedT ** mod;

	trig = Impulse.kr(speedT);

	rep = Dstutter(Dwhite(1,5), Dwhite(0.2,1.8) * Dwhite(0,1).exprange(0.3, 2.0) );
	release = Demand.kr(trig, 0, rep);

	f =  Dstutter(Dwhite(1,10), Dwrand( [Dwhite(-100, 50,1), Dwhite(-1000, -2000, 1) ,Dwhite(-1000, -100,1) , Dwhite(100, 2000,1)], [2, 1,5,2].normalizeSum, inf));

	freq = Demand.kr(trig, 0, f);

	env = EnvGen.kr(Env.perc(attack, (release * releaseScale)), trig, doneAction:0);

	input = SinOsc.ar(freq, 0, 0.2);
	input = RLPFD.ar(input, freq/3, 1, 0.5, 0.5);

	output = Shaper.ar(buf, input, 2 ) * env;
	output = LeakDC.ar(output, 0.995);
	output = MidEQ.ar(output, 150, 1, 12);
	output = MidEQ.ar(output, 3000, 1, 12);

	Out.ar(outbus, output * volume );
}).add;


~delBuf = Buffer.alloc(s,s.sampleRate * 2, 2);

SynthDef("PingPong",{ arg outbus=0,feedback=0.5,delayTime=0.2, resonzVol = 0, combVol = 0, combdecay = 0.1,
	pitchRatio = 1, pitchDispersion = 0, timeDispersion =0, mulShift = 1,
	pitchWet = 0, delayWet = 0, reverberedWet = 0,
	volume =0.5;
    var left, right, numDel, inputChans, bufnum, delayed, out;
	bufnum = ~delBuf;
	numDel = 6;
	   // inputChans = [left, right];
	inputChans  = SoundIn.ar([~input_ch1,~input_ch2]);

      //  inputChans = inputChans + Resonz.ar(inputChans, SinOsc.kr(2.7,0,1000,2500), 0.2) * resonzVol;
	//inputChans = inputChans + Mix.ar(Array.fill(numDel,{ CombL.ar(inputChans, 0.05, rrand(0.03, 0.05), combdecay) })) * combVol;
	inputChans = SelectX.ar(pitchWet, [inputChans, PitchShift.ar(inputChans, 0.2, pitchRatio, pitchDispersion, timeDispersion, mulShift)] );
	delayed = SelectX.ar(delayWet, [inputChans, PingPong.ar(bufnum, inputChans, delayTime, feedback, 1)] );
	out = SelectX.ar(reverberedWet, [delayed, AdCVerb.ar(delayed) * 0.5]);
	Out.ar(outbus, out * volume);

}).add;



SynthDef(\henone, { arg outbus = 0, volume = 0, aval1 = 0.39, bval1 = 0.2, aval2 = 0.39, bval2 = 0.2; //a(0.39, 1.4), b(0.01,0.3)
	var output;
	output = Henon2DN.ar(20, SampleRate.ir, aval1 + aval2, bval1 + bval2) * 0.5;
	Out.ar(outbus, output!2 * volume).clip2(0.9);
}).add;

SynthDef(\pluck, { arg outbus = 0, volume = 0, speed = 5, gendyF = 100, hpfF = 20, mulP = 0.1, mulG = 1.0, mulC = 0.1;
	var output;

	output = HPF.ar(
			MidEQ.ar(
				Limiter.ar(
					GVerb.ar(
						HPF.ar(
							Pulse.ar([[0.1,0.11],[0.12,0.13]] * speed, 0.6, mulP)
							* Gendy4.ar(5,2,1.5,1.0,30,gendyF,0.6,0.5,12, mulG)
							,hpfF),
						[[1,5/4],[1.5,2]],99)
				) ,9e3,0.9,9)
			,200);
	output = CombC.ar(output, 0.2, [0.001, 0.002, 0.003, 0.004, 0.005], LFNoise0.kr(3).range(0.5, 1.5), mulC, output);
	output = Mix.ar(output);


		Out.ar(outbus, output* volume );
}).add;



SynthDef(\glitch_sounds, { arg outbus = 0, modN = 0.5, modF = 0, modAmp1 = 0, modAmp2 = 1, modAmp3 = 1, modC = 1, gpos = 0,  master_volume = 0;
	var chain, snd;

	snd = BPF.ar(WhiteNoise.ar(mul: SinOsc.ar(modF,phase:Rand (0,pi), mul:Rand( 0.1,1) )),modAmp1 * modAmp2 * modAmp3 *  Rand(0,400) * modN  )!2
	+
	BPF.ar(WhiteNoise.ar(mul: SinOsc.ar(modF,phase:Rand (0,pi), mul:Rand( 0.1,1) )),modAmp1 * modAmp2 * modAmp3  * Rand(0,400)* modN )!2
	+
	BPF.ar(WhiteNoise.ar(mul: SinOsc.ar(modF,phase:Rand (0,pi), mul:Rand( 0.1,1) )),modAmp1 * modAmp2 * modAmp3  * Rand(0,400) * modN )!2 ;
	snd = BrownNoise.ar(modF, snd) + snd;
	snd = snd.clip2(0.5);
	snd = Array.fill(8, CombN.ar(snd, 0.2, {rrand(0.05,0.1)} * modC, {rrand(0.1,1)} * modC, 1/8));
	snd = Mix.new(snd);

	//snd = GVerb.ar(snd, 5, 0.83423432, 0.5, spread:15, mul:0.2);
	snd = Pan2.ar(snd, gpos);

	Out.ar(outbus, snd * master_volume).clip2(0.5);

}).add;


SynthDef(\granulator, { arg out = 0, volume = 0, bufNum = 0, pos = 0, trigRate = 1, rate = 1, frate = 1, freqLPF = 22000, amtRnd = 0, lfoR = 20, dur = 0.15, overlap = 1,
	amFreq = 64, amVol = 0,
	gate = 1.0, freqMIDI = 64,
	ffreq_low = 22000, drywet = -0.8,
	panMax = 1, amp = 1, interp = 4,  rndTrigRate = 0, speedRndTrigRate = 5, speedRndRate = 5, rndRate = 0, pan = 0, mulPan = 0;

    var trate, rndPos, ausgang, am, midiOsc, freqMod, sig, reverbered, chain;
	rate = rate * frate;
	rndPos = LFNoise0.kr(lfoR, amtRnd);
	trate = (trigRate + LFNoise0.kr(speedRndTrigRate, rndTrigRate)).abs ;
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

~path.pathMatch;
~buf_to_gran = ~path.pathMatch.collect { |i| Buffer.readChannel(s, i, channels:[0])}; // put your folder path here



/*
~gbuf1 = Buffer.read(s, "/Users/marcello/Music/FieldRecording/boat_istanbul_01_mono.wav");
~gbuf2 = Buffer.read(s, "/Users/marcello/Music/Supercollider/different bodies/samples/french_voice_no_silence_mono.wav");
~gbuf3 = Buffer.read(s, "/Users/marcello/Music/Samples/Capre_limited.wav");
~gbuf4 = Buffer.read(s, "/Users/marcello/Music/Supercollider/Monster/Samples/organic/Selection/Bowl1.wav");

~gbuf5 = Buffer.read(s,"/Users/marcello/Music/Supercollider/mixer/Samples/SingleKeys.wav");
~gbuf6  = Buffer.read(s, "/Users/marcello/Music/Supercollider/mixer/Samples/ImproPiano.wav");
*/
~buf2 = Buffer.alloc(s, s.sampleRate * 2, 1);

~buf2_c1 = Buffer.alloc(s, s.sampleRate * 2, 1);
~buf2_c2 = Buffer.alloc(s, s.sampleRate * 2, 1);
~buf2_c3 = Buffer.alloc(s, s.sampleRate * 2, 1);
~buf2_c4 = Buffer.alloc(s, s.sampleRate * 2, 1);

~buf4 = Buffer.alloc(s, s.sampleRate * 4, 1);

~buf4_c1 = Buffer.alloc(s, s.sampleRate * 4, 1);
~buf4_c2 = Buffer.alloc(s, s.sampleRate * 4, 1);
~buf4_c3 = Buffer.alloc(s, s.sampleRate * 4, 1);
~buf4_c4 = Buffer.alloc(s, s.sampleRate * 4, 1);

~buf21 = Buffer.alloc(s, s.sampleRate * 2, 1);

~buf21_c1 = Buffer.alloc(s, s.sampleRate * 2, 1);
~buf21_c2 = Buffer.alloc(s, s.sampleRate * 2, 1);
~buf21_c3 = Buffer.alloc(s, s.sampleRate * 2, 1);
~buf21_c4 = Buffer.alloc(s, s.sampleRate * 2, 1);

~buf41 = Buffer.alloc(s, s.sampleRate * 4, 1);

~buf41_c1 = Buffer.alloc(s, s.sampleRate * 4, 1);
~buf41_c2 = Buffer.alloc(s, s.sampleRate * 4, 1);
~buf41_c3 = Buffer.alloc(s, s.sampleRate * 4, 1);
~buf41_c4 = Buffer.alloc(s, s.sampleRate * 4, 1);


~buf_array = [[~buf2, ~buf2_c1], [~buf2,~buf2_c2], [~buf2, ~buf2_c3], [~buf2, ~buf2_c4],
	[~buf4, ~buf4_c1], [~buf4, ~buf4_c2], [~buf4, ~buf4_c3], [~buf4, ~buf4_c4],
	[~buf21, ~buf21_c1], [~buf21,~buf21_c2], [~buf21, ~buf21_c3], [~buf21, ~buf21_c4],
	[~buf41, ~buf41_c1], [~buf41, ~buf41_c2], [~buf41, ~buf41_c3], [~buf41, ~buf41_c4]

];


~copiedBuf_to_gran = [~buf2, ~buf4, ~buf21, ~buf41];

~buf_array.size.do({ |i|
	~copiedBuf_to_gran = ~copiedBuf_to_gran.add(~buf_array[i][1]);
});

SynthDef(\looper, { arg outbus, input_ch = 0, input_sel = 1, reclevel=0, prelevel=1, loop_rec = 0, loop_play = 1, trigger = 1, buf, volume = 1, rate =1, frate = 1, lpos = 0 , freqShift = 1, fshift = 1, windowSize = 0.2, randRatio = 0, width = -1, overlaps = 8;
	var sig = SoundIn.ar(input_ch, 2),// SelectX.ar(input_sel, [SoundIn.ar(input_ch,  2), In.ar(0, 1)]),
        play = PlayBuf.ar(1, buf, rate * frate, loop: loop_play),
	play2 = Warp1.ar(1, buf, lpos, freqShift * fshift, windowSize, -1, overlaps, windowRandRatio: randRatio, interp: 4),
        record = RecordBuf.ar(sig <! play, buf, recLevel: reclevel, preLevel:prelevel,
loop: loop_rec, trigger:trigger);
	Out.ar(outbus, XFade2.ar(play, play2, width, volume).softclip(0.9)!2);
}).add;

SynthDef(\looperD, { arg outbus, input_ch = 0, reclevel=0, prelevel=1, loop_rec = 0, loop_play = 1, trigger = 1, buf, volume = 1,rate = 1, frate = 1, maxdelay = 0.5, delaytime = 0.1, decaytime = 1, muldelay = 1, width = -1;
	var sig = SoundIn.ar(input_ch, 2),
        play = PlayBuf.ar(1, buf, rate * frate, loop: loop_play),
	delay = AllpassC.ar(play, maxdelay, delaytime, decaytime, muldelay),
        record = RecordBuf.ar(sig <! play, buf, recLevel: reclevel, preLevel:prelevel,
loop: loop_rec, trigger:trigger);
	Out.ar(outbus, XFade2.ar(play, delay, width, volume).softclip(0.9)!2);
}).add;




// other resources needed by the synthdefs
~dlybuf = Buffer.alloc(s, 6.05 * s.sampleRate, 1);
~oscbuf = Buffer.alloc(s, 4096, 1)
   .sine2(({ |i| rrand(3-i, 6-i) + (i+2).reciprocal.rand2 } ! 4), (1..4).reciprocal);

SynthDef.new("pinkfilt", {
	arg	outbus,	freq, rq, volume = 0;
	Out.ar(outbus, RLPF.ar(PinkNoise.ar, freq, rq)!2 * volume);
}).add;

SynthDef.new("comb", {
	arg outbus, delaytime = 1, decaytime = 1, mul = 1;
	var in, out;
	in = In.ar(outbus, 2);
	out = Array.fill(3, CombC.ar(in, 0.2, {BrownNoise.kr(0.5, 0.5).range(0.0001, 0.1) * delaytime}  , decaytime, mul));
	ReplaceOut.ar(outbus, out);  // equal power
}).add;



SynthDef.new(\delay, { arg outbus = 0, delaytime = 0.1, decaytime = 5, mul = 1;
	var sig, in;
	in = In.ar(outbus, 2);
	//12.do({ sig = AllpassN.ar(in, 0.040 * delay, [0.020.rand,0.020.rand] * delay, decaytime, mul) });
	//sig = Array.fill(3, CombC.ar(in, 2, delay, decaytime, mul, in));
//	sig = AllpassC.ar(in, 2, delaytime, decaytime, mul, in);
	sig = CombC.ar(in, 2, delaytime.lag(1), decaytime, mul, in);

	ReplaceOut.ar(outbus, sig);
}).add;



SynthDef("harmMod",{arg outbus, carrier = 10, harm = 5, bright = 5, volume = 0, hpan = 0;
	var snd, modFreq, modAmp, modOsc, brightness, carrierOsc, carrierSignal;
	carrierSignal = Signal.newClear(512).fill(1) * carrier;
	modFreq =  carrier * harm;
	modOsc = SinOsc.ar(modFreq);
	brightness = modFreq * bright;
	modAmp = modOsc * brightness;

	carrierOsc = SinOsc.ar(carrier + modAmp)!2;
	Out.ar(outbus, Pan2.ar(carrierOsc * volume, hpan));
}).add;

SynthDef("dust_touch", { arg out=0, volume = 0,density = 10, ps_ws = 0.05, ps_pr = 1, ps_pd = 0, ps_td = 0;
	var sig;
	sig = Dust2.ar(density, 1);
	sig = PitchShift.ar(sig, ps_ws, ps_pr, ps_pd, ps_td);
	//sig = GVerb.ar(sig, 5, 2);

//	6.do({ sig = AllpassN.ar(sig, 0.040, [0.020.rand,0.020.rand], 3) });
	//sig = BPeakEQ.ar(sig, 1000, 0.1, 5);
	sig = BHiPass.ar(sig, 1000, 0.5, 2);

	//sig = BLowPass.ar(sig, 200, 0.1, 2);
	//sig = GVerb.ar(sig, 3, 1, 1);

    Out.ar(out,
        sig*volume!2
    )
}).add;

SynthDef(\GVerb, { arg outbus = 0, roomsize= 243, revtime= 1, damping= 0.1, inputbw= 0.34, spread= 15, drylevel= -60, earlylevel= -11, taillevel= -9, volume = 3;
	var sig, in;
	in = In.ar(outbus, 2);
	sig = GVerb.ar(in, roomsize, revtime, damping, inputbw, spread, drylevel.dbamp, earlylevel.dbamp, taillevel.dbamp);
	ReplaceOut.ar(outbus, sig * volume);
}).add;

SynthDef(\comb, {|  outbus = 0, intensity = 2,
	maxdelayt = 0.2, delayarr = #[ 0.016415828466415, 0.036066961288452, 0.045210140943527, 0.038088554143906, 0.037890076637268, 0.026094967126846 ], delaytime = 1, decaytime = 1, mulComb = 0.1,
	freqRingz = 600, decayRingz = 1, mulRingz = 0.5,
	volume = 0.5 |
	var out, in, trig;

	in = Dust.ar(intensity);
	out = Ringz.ar( in, freqRingz, decayRingz, mulRingz);

	out =  Mix.new(CombN.ar(out, maxdelayt, delaytime * delayarr, decaytime, mulComb/delayarr.size));
	Out.ar(outbus , volume * out!2);
}).add;

SynthDef(\combEffect, {|  outbus = 0,
	maxdelayt = 1, delayarr = #[ 0.016415828466415, 0.036066961288452, 0.045210140943527, 0.038088554143906, 0.037890076637268, 0.026094967126846 ], delaytime = 0.1, decaytime = 2,
	freqRingz = 111, freqMaxRingz = 222, gSpeed = 0.74, mulRingz = 0.1, volume = 1, mulComb = 1, decayRingz = 0.2|
	var out, in, trig;
	in = In.ar(outbus, 2);
	freqRingz = Gendy3.kr(1,0.5,0.5,0.5, gSpeed, 0.5, SinOsc.kr(0.19,0,0.49,0.51),10,10
).range(freqRingz, freqMaxRingz);
	out = Ringz.ar( in, freqRingz, decayRingz, mulRingz);
	out =  Mix.new(CombN.ar(out, maxdelayt, delaytime * delayarr, decaytime, mulComb/delayarr.size));

	ReplaceOut.ar(outbus , volume * out!2);
}).add;


SynthDef(\hString, {|outbus = 0, volume = 0, pitch = 0.1, speed = 0.1, harm = 1, freqscale = 0.2|
	var mix, out, num = 16;
	r = LFNoise0.kr(speed, 0.5,0.5).squared * pitch;
	//out =  WhiteNoise.ar(0.1);

		mix = DynKlank.ar(
			`[
				Array.fill(num, { exprand(1.0,10.0) * pitch}),
				nil,
				Array.fill(num, { 0.5.rand })
			],
	//	LinCongC.ar( 100 * pitch, r), 0.2
	Blip.ar(r, harm * [2, 4], 0.1), freqscale
		).fold2(0.2).cubed * 12;
	//mix = mix + LinCongC.ar( 1000 * pitch * harm, );
		mix = Mix.arFill(3, { CombC.ar(mix, 0.1, 0.03.linrand, 4.0.linrand, 1, mix * 0.5) });
		out = mix.distort * 0.5;
		6.do({ out = AllpassC.ar(out, 0.05, [0.05.rand, 0.05.rand], 3) });
	//out;
	out = LeakDC.ar(out) * volume;

	Out.ar(outbus, out.clip2(0.8));
}).add;

SynthDef(\latoo, {|outbus = 0, volume = 0, freq =1000,
	a = 1, oscA = 0.1, aM = 1,
	b = 3,
	c = 0.5,
	d = 0.5|
	var sig;
	a = LFNoise0.kr(oscA, aM);

/*
	b = SinOsc.kr(oscB, 0, bM).poll;
		c = LFNoise0.kr(oscC,  cM).poll(label: c);

	d = SinOsc.kr(oscD, 0, dM);
*/
	sig = LatoocarfianC.ar(freq, a, b, c, d);
	sig = HPF.ar(sig * 0.2, 30);
	sig = Limiter.ar(sig, 0.9);
	sig = Pan2.ar(sig, LFNoise2.kr(freq));
	Out.ar(outbus, sig * volume);
}).add;




)

/*

OLD STUFF!

SynthDef.new(\chorus, {
	arg outbus = 0, delaytime = 1, decaytime = 1, mul = 1;

	var in, out, number_voices = 20;
		in = In.ar(outbus, 2);

	out= Mix.fill(number_voices, {
		var maxdelaytime= rrand(0.01,0.03);
		var half= maxdelaytime*0.5;
		var quarter= maxdelaytime*0.25;

		//half+(quarter*LPF.ar(WhiteNoise.ar,rrand(1.0,10)))

		DelayC.ar(in, maxdelaytime, LFNoise1.kr(Rand(5,10),0.01,0.02) )


	});
		ReplaceOut.ar(outbus, out);  // equal power

}).add;
SynthDef(\isoc, { |outbus = 0, speed = 8, freqSaw = 10, freqRingz = 4, decayRingz = 0.1, mulRingz = 0.1, mulSaw = 0.3, volume = 0.5|
	var sig, pulse, input;
	pulse = LFPulse.ar(speed + freqSaw, 0, 0.5, 1).lag(0.001);
	input = LFSaw.ar(freqSaw * 4.43423423, mul: mulSaw);
	sig = Ringz.ar(pulse, freqRingz * 30.23432, decayRingz, mulRingz)
	//sig = Streson.ar(pulse, 0.003, 0.9, 0.1)
	* input;
	sig = Pan2.ar(sig, 0.0);
	//sig = GVerb.ar(sig, 80, 14.3, 0.41, 0.19, 30, 1, 0.5) * 0.3;
	Out.ar(outbus, (sig * volume).clip2(0.9));

}).add;

SynthDef(\hString, {|outbus = 0, volume = 0, pitch = 0.1, speed = 0.1, harm = 1, freqscale = 0.2|
	var mix, out, num = 16;
	r = LFNoise0.kr(speed, 0.5,0.5).squared * pitch;
	//out =  WhiteNoise.ar(0.1);

		mix = DynKlank.ar(
			`[
				Array.fill(num, { exprand(1.0,10.0) * pitch}),
				nil,
				Array.fill(num, { 0.5.rand })
			],
	//	LinCongC.ar( 100 * pitch, r), 0.2
	Blip.ar(r, harm * [2, 4], 0.1), freqscale
		).fold2(0.2).cubed * 12;
	//mix = mix + LinCongC.ar( 1000 * pitch * harm, );
		mix = Mix.arFill(3, { CombC.ar(mix, 0.1, 0.03.linrand, 4.0.linrand, 1, mix * 0.5) });
		out = mix.distort * 0.5;
		6.do({ out = AllpassC.ar(out, 0.05, [0.05.rand, 0.05.rand], 3) });
	//out;
	out = LeakDC.ar(out) * volume;

	Out.ar(outbus, out.clip2(0.8));
}).add;

SynthDef( \resonantNoise, { |outbus = 0, volume = 0.5, fmfreq = 50, fmamp = 0.1, freq = 500, lffreq = 50, lfmul = 0.04, rq = 0.01|
	var mix;
	mix = Resonz.ar( Array.fill(6, {PinkNoise.ar( SinOsc.ar( fmfreq, 0, fmamp, 1 ) )}), freq.lag(0.1) * [1,5/4,3/2] * LFNoise2.kr(lffreq, lfmul, 1 ), rq.lag(0.1) ).sum * 3 * volume;
	Out.ar(outbus, mix);

}).add;
