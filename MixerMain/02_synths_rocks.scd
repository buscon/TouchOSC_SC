(

~ampBus= Bus.control(s,4);
~freqBus= Bus.control(s,4);

Ndef(\receive, { arg in = 0, numsamp = 5,  lagAtk = 0.01, lagDec = 0.5;
	var sig1, sig2, sig3, sig4, input, amp1, amp2, amp3, amp4, freq1, freq2, freq3, freq4;
	input = SoundIn.ar([0,1,2,3]);
	amp1 = Amplitude.ar(input[0], 0.01, 0.1);
	amp2 = Amplitude.ar(input[1], 0.01, 0.1);
	amp3 = Amplitude.ar(input[2], 0.01, 0.1);
	amp4 = Amplitude.ar(input[3], 0.01, 0.1);

	freq1 = Pitch.kr(input[0], ampThreshold:0.01)[0];
	freq2 = Pitch.kr(input[1], ampThreshold:0.01)[0];
	freq3 = Pitch.kr(input[2], ampThreshold:0.01)[0];
	freq4 = Pitch.kr(input[3], ampThreshold:0.01)[0];

	sig1 = Lag2UD.kr((RunningSum.kr(amp1, numsamp) / numsamp).linlin(0.001, 0.2, 0, 1), lagAtk, lagDec);
	sig2 = Lag2UD.kr((RunningSum.kr(amp2, numsamp) / numsamp).linlin(0.001, 0.2, 0, 1), lagAtk, lagDec);
	sig3 = Lag2UD.kr((RunningSum.kr(amp3, numsamp) / numsamp).linlin(0, 0.25, 0, 1), lagAtk, lagDec);
	sig4 = Lag2UD.kr((RunningSum.kr(amp4, numsamp) / numsamp).linlin(0, 0.015, 0, 1), lagAtk, lagDec);


	Out.kr(~ampBus.index, [sig1, sig2, sig3, sig4]);
	Out.kr(~freqBus.index, [freq1, freq2, freq3, freq4]);

}).play;




SynthDef(\end_of_tv, {arg  outbus = 0, trig = 1, dur = 0.1, pRl = 0.5, pRh = 0.5, pD = 0, tD = 0, which = -1, volume = 0, snd_vol = 1, grain_vol = 0, dfm_inputgain = 1, dfm_freq = 1000, dfm_res = 0.1, dfm_type = 0, dfm_noise = 0.0003, gain = 1, spread = 1;
	var sndin, grain, ausgang, env;
	//env = EnvGen.kr(Env.sine(BufDur.kr(buf)));
	//sndin = PlayBuf.ar(2, buf , BufRateScale.kr(buf), loop: 0, doneAction: 2) * 0.25 ;
	//sndin = DFM1.ar(sndin, dfm_freq, dfm_res, dfm_inputgain, dfm_type, dfm_noise);

	sndin = SoundIn.ar(0) * gain;
	grain = GrainIn.ar(1, Impulse.kr(trig), dur, sndin);
	grain = PitchShift.ar(grain, 0.2, pRl+ pRh, pD, tD) * grain_vol;
	//grain = GVerb.ar(grain, 50, 5, drylevel:2) ;
	ausgang = Splay.ar( (sndin * snd_vol) + grain, spread, volume );

	Out.ar(outbus, ausgang);
}).add;


SynthDef(\gendy, { arg outbus = 0, volume = 0, freq = 300, freqFine = 1, freqMinMul = 0.5, freqMaxMul = 2, ampdist = 1, durdist = 0.5, adparam = 0.5, ddparram = 0.5,  ampscale= 0.5, durscale = 0.5, initCPs = 12, kumcps = 6, numcps = 12, n = 5, freqResonz = 800, bwr = 0.1, spread_speed = 0, center_speed = 0, orientation = 0.5, busAmpIndex = 0, busFreqIndex = 4, micSwitch = 1, whichMic = 2;
var  sig, bus,  ampBus, freqMic;
n=30;


freq = freq * freqFine;

		ampBus = Select.kr( whichMic, In.kr( busAmpIndex, 4));
	freqMic = Select.kr( whichMic, In.kr( busFreqIndex, 4));
	freq = Select.kr(micSwitch, [freq, freqMic]);
	bus = Select.kr(micSwitch, [1, ampBus]);
sig =
	//Resonz.ar(
Array.fill(n,{
//var freq, numcps;

//freq= rrand(330,460.3);
//numcps= rrand(2,20);

sig = Gendy4.ar(ampdist, durdist, adparam, ddparram,freq * freqMinMul, freq * freqMaxMul, ampscale, durscale, initCPs, kumcps, SinOsc.kr(exprand(0.02,0.2), 0, numcps/2, numcps/2), 0.5/(n.sqrt));
});
	//	, freqResonz, bwr);
	sig = SplayAz.ar(~num_channels, sig, LFDNoise3.kr(spread_speed).range(0,1), 1, 2, LFDNoise3.kr(center_speed), orientation  );

	sig = Limiter.ar(sig * volume * 0.1, 0.9).clip2(0.9);

	sig = LeakDC.ar(sig);

	Out.ar(outbus , sig * bus);

}).add;



SynthDef(\waveS1, {arg  outbus = 0,   attack = 0.01, releaseScale = 0.8, volume = 0, speedT = 1, speedLFO = 1, buf = ~waveBuf, resonance = 1, distortion = 0.5,
	first = 2, second = 1, third = 5, fourth = 2, busAmpIndex = 0, busFreqIndex = 4, micSwitch = 0, whichMic = 0;
	var  env, output, input, rep, trig, mod, release, freq1, freq2, freq3, freq4, ampBus, bus;

			ampBus = Select.kr( whichMic, In.kr( busAmpIndex, 4));
	bus = Select.kr(micSwitch, [1, ampBus]);

	mod = LFNoise0.kr(1!2).range(1, 2).round;
	speedT = speedT ** mod;

	trig = Impulse.kr(speedT);

	rep = Dstutter(Dwhite(1,5), Dwhite(0.2,1.8) * Dwhite(0,1).exprange(0.3, 2.0) );
	release = Demand.kr(trig, 0, rep);

	//f =  Dstutter(Diwhite(1,10).dpoll, Dwrand( [Dwhite(-100, 50,1), Dwhite(-1000, -2000, 1) ,Dwhite(-1000, -100,1) , Dwhite(100, 2000,1)], [first, second, third, fourth].normalizeSum, inf));
	f = Dwrand( [Dwhite(-100, 50,1), Dwhite(-1000, -2000, 1) ,Dwhite(-1000, -100,1) , Dwhite(100, 2000,1)], [first, second, third, fourth].normalizeSum, inf);
	freq1 = Demand.kr(trig, 0, f);
	freq2 = Demand.kr(trig, 0, f);
	freq3 = Demand.kr(trig, 0, f);
	freq4 = Demand.kr(trig, 0, f);

	env = EnvGen.kr(Env.perc(attack, (release * releaseScale)), trig, doneAction:0);

	input = SinOsc.ar([freq1, freq2, freq3, freq4], 0, 0.2);
	input = RLPFD.ar(input, [freq1, freq2, freq3, freq4]/3, resonance, distortion, 0.5) ;

	output = Shaper.ar(buf, input, 2 ) * env;
	output = LeakDC.ar(output, 0.995);
	output = MidEQ.ar(output, 150, 1, 12);
	output = MidEQ.ar(output, 3000, 1, 12);

	//output = Splay.ar(output);

	Out.ar(outbus, output * volume * 0.2 *bus);
}).add;


~delBuf = Buffer.alloc(s,s.sampleRate * 2, 2);

SynthDef("PingPong",{ arg outbus=0,feedback=0.5,delayTime=0.2, resonzVol = 0, combVol = 0, combdecay = 0.1,
	pitchRatio = 1, pitchDispersion = 0, timeDispersion =0, mulShift = 1,
	pitchWet = 0, delayWet = 0, reverberedWet = 0, whichMic = 0,
	volume =0.5;
    var left, right, numDel, inputChans, bufnum, selInput, delayed, out;
	bufnum = ~delBuf;
	numDel = 6;
	   // inputChans = [left, right];
	selInput = Select.kr(whichMic,[~input_ch1,~input_ch2, ~input_ch3, ~input_ch4] );
	inputChans  = SoundIn.ar(selInput)!2;

      //  inputChans = inputChans + Resonz.ar(inputChans, SinOsc.kr(2.7,0,1000,2500), 0.2) * resonzVol;
	//inputChans = inputChans + Mix.ar(Array.fill(numDel,{ CombL.ar(inputChans, 0.05, rrand(0.03, 0.05), combdecay) })) * combVol;
	inputChans = SelectX.ar(pitchWet, [inputChans, PitchShift.ar(inputChans, 0.2, pitchRatio, pitchDispersion, timeDispersion, mulShift)] );
	delayed = SelectX.ar(delayWet, [inputChans, PingPong.ar(bufnum, inputChans, delayTime, feedback, 1)] );
	out = SelectX.ar(reverberedWet, [delayed, AdCVerb.ar(delayed) * 0.5]);

	out = LeakDC.ar(out);

	Out.ar(outbus, out * volume);

}).add;



SynthDef(\henone, { arg outbus = 0, volume = 0, aval1 = 0.39, bval1 = 0.2, aval2 = 0.39, bval2 = 0.2; //a(0.39, 1.4), b(0.01,0.3)
	var output;
	output = Henon2DN.ar(20, SampleRate.ir, aval1 + aval2, bval1 + bval2) * 0.5;
	output = LeakDC.ar(output!2);
	Out.ar(outbus, output * volume).clip2(0.9);
}).add;

SynthDef(\pluck, { arg outbus = 0, volume = 1, speed = 5, gendyF = 100, hpfF = 20, mulP = 0.1, mulG = 1.0, mulC = 0.1, busAmpIndex = 0, freqMul = 1, busFreqIndex = 4, micSwitch = 0, whichMic = 2;
	var output, bus,  ampBus, freqMic;
	gendyF = gendyF * freqMul;

			ampBus = Select.kr( whichMic, In.kr( busAmpIndex, 4));
	freqMic = Select.kr( whichMic, In.kr( busFreqIndex, 4));
	gendyF =  Select.kr(micSwitch, [	gendyF
, freqMic]);
	bus = Select.kr(micSwitch, [1, ampBus]);

	output = HPF.ar(
			MidEQ.ar(
				Limiter.ar(
					GVerb.ar(
						HPF.ar(
							Pulse.ar([[0.1,0.11],[0.12,0.13]] * speed, 0.6, mulP)
							*
						Gendy4.ar(5,2,1.5,1.0, gendyF*0.3, gendyF * 2,0.6,0.5,12, mulG)
							,hpfF),
						[[1,5/4],[1.5,2]],99)
				) ,1e3,0.9,9)
			,10) ;
	output = CombC.ar(output, 0.2, [0.001, 0.002, 0.003, 0.004, 0.005], LFNoise0.kr(3).range(0.5, 1.5), mulC, output);
	output = Splay.ar(output);
	output = LeakDC.ar(output) * 0.1;

		Out.ar(outbus, output* volume * bus);
}).add;


SynthDef(\res, {|outbus = 0, dev = 0,  volume = 0.5, bwr = 0.02,
	vol_freq1 = 10, vol_freq3 = 7, vol_freq4 = 6, vol_freq5 = 5,  vol_freq6 = 5, vol_freq7 = 4, vol_freq8 = 3, vol_freq9 = 2, vol_freq10 = 1,
	lpf = 5000, rq = 0.5, spac_speed = 1|
	var sig;

	sig = Resonz.ar(PinkNoise.ar(0.25),
		Array.geom(10, 65, 1.5) * 1.gauss(dev),
		bwr, volume * [vol_freq1, vol_freq1 - 2, vol_freq3, vol_freq4, vol_freq5, vol_freq6, vol_freq7, vol_freq8, vol_freq9, vol_freq10] * bwr.reciprocal.linlin(10, 100000, 1, 1000)  );
	sig = SplayAz.ar(~num_channels, sig, LFDNoise3.kr(spac_speed).range(0,1), 1, 2, LFDNoise3.kr(spac_speed)  );

	sig = RLPF.ar(sig, lpf, rq);
//	sig = Pan4.ar(sig, LFNoise0.kr(spac_speed), LFNoise0.kr(spac_speed));
	Out.ar(outbus, sig * 2);
}).add;


SynthDef(\glitch_sounds, { arg outbus = 0, modN = 0.5, modF = 0, modAmp1 = 10, modAmp2 = 12, modAmp3 = 13, modC = 1, gpos = 0,  master_volume = 0.2, spread_speed = 10, center_speed = 0, orientation = 0.5, busAmpIndex = 0, busFreqIndex = 4, micSwitch = 1, whichMic = 2;
	var chain, snd,bus,  ampBus, modAmp, freqMic;


			ampBus = Select.kr( whichMic, In.kr( busAmpIndex, 4));
	freqMic = Select.kr( whichMic, In.kr( busFreqIndex, 4));
	modAmp =  Select.kr(micSwitch, [	modAmp1 * modAmp2 * modAmp3
, freqMic + modAmp1]);
	bus = Select.kr(micSwitch, [1, ampBus]);

	snd = BPF.ar(WhiteNoise.ar(mul: SinOsc.ar(modF,phase:Rand (0,pi), mul:Rand( 0.1,1) )),modAmp  *  Rand(0,400) * modN  )
	+
	BPF.ar(WhiteNoise.ar(mul: SinOsc.ar(modF,phase:Rand (0,pi), mul:Rand( 0.1,1) )), modAmp * Rand(0,400)* modN )
	+
	BPF.ar(WhiteNoise.ar(mul: SinOsc.ar(modF,phase:Rand (0,pi), mul:Rand( 0.1,1) )),modAmp* Rand(0,400) * modN ) ;
	snd = BrownNoise.ar(modF, snd) + snd;
	snd = snd.clip2(0.5);
	snd = Array.fill(8, CombN.ar(snd, 0.2, {rrand(0.05,0.1)} * modC, {rrand(0.1,1)} * modC, 1/8));
	//snd = SplayAz.ar(4, snd, );
	snd = Mix.ar(snd);
	snd = PanAz.ar(~num_channels, snd, LFDNoise3.kr(spread_speed), 1, 2, LFDNoise3.kr(center_speed), orientation  );

	//snd = GVerb.ar(snd, 5, 0.83423432, 0.5, spread:15, mul:0.2);
	//snd = Pan2.ar(snd, gpos);
	snd = LeakDC.ar(snd);
		bus = Select.kr(micSwitch, [1, ampBus]);

	Out.ar(outbus, snd * master_volume * bus).clip2(0.5);

}).add;
/*
SynthDef(\granulator, { arg bufNum = 0, pos = 0.1, trigRate1 = 3,trigRate2 = 0,trigRate3 = 0, rate = 1, frate = 1, overlap = 4, amtRnd = 0, lfoR = 4, dur = 0.3, list_of_pos = [0, 0.5],
		amFreq = 64, amVol = 0.5, pan = 0,
	stretch_bins = 0.5, //0.1-4 exponential
	pv_amt = 0, freeze = 0,
	holdperiod = 0.02, multiplier = 1, stutter = 0,
	ffreq_low = 22000, drywet = -0.8, decay = 0.1,
	panMax = 1, amp = 0.5, interp = 4, volume = 0, volume2 = 1, volume3 = 1, master_vol = 1, cutoffFreq = 3000,
	rndTrigRate = 0, speedRndTrigRate = 2, speedRndRate = 5, rndRate = 0, volumeLag =3, combLevel = -1, envbufnum, posS = 0;
    var trate, rndPos, ausgang, am, midiOsc, freqMod, sig, reverbered, comb, chain;
	rate = rate * frate;
	//trigRate1 =MouseX.kr(0, 10); dur = MouseX.kr(0.2, 1);
	pos = pos + LFNoise0.kr(lfoR, amtRnd );

	trate = (trigRate1 + trigRate2 + trigRate3);
	//ausgang = TGrains.ar(2, Impulse.kr(trate) , bufNum, rate, pos.linlin(0, 1, 0,  BufDur.kr(bufNum)) , dur , pan, amp, 4);
	ausgang = GrainBuf.ar(1, Impulse.kr(trate) ,dur , bufNum, rate, pos.linlin(0, 1, 0,  BufDur.kr(bufNum))  ,4, pan);

	// AM
	am = SinOsc.ar( amFreq, mul:amVol*1.5) * SinOsc.ar( (amFreq)/2, mul:amVol*1.5);
	ausgang = XFade2.ar(ausgang, ausgang * am, amVol.linlin(0, 1, -1, 1));


	sig = ausgang * Lag3UD.kr(volume * volume2, 0, volumeLag) * volume3 * master_vol;

	chain = FFT(LocalBuf(2048), sig);
	chain = PV_BinShift(chain, stretch_bins, 0, 4);
	sig = SelectX.ar(pv_amt, [sig,  IFFT(chain, 0)]);

	sig = RLPF.ar(sig, cutoffFreq, 0.8, 0.7);
//	sig = FreeVerb.ar(sig, 0.95, 0.9, 0.8);
//	sig = Mix.ar(sig) * 1.5;

	sig = Limiter.ar(sig, 0.8);
	sig = LeakDC.ar(sig).clip2;
	sig = PanAz.ar(~num_channels, sig, posS);

	Out.ar(0, sig  * 0.75 );

}).add;


old version, i just keep it in case the previous one fails.
*/
~whichMic = 0;
SynthDef(\granulator, { arg out = 0, volume = 0, bufNum = 0, pos = 0, trigRate = 1, trigRateR = 0,  rate = 1, frate = 1, freqLPF = 22000, amtRnd = 0, lfoR = 20, dur = 0.15, overlap = 1,
	amFreq = 64, amVol = 0,
	gate = 1.0, freqMIDI = 64,
	ffreq_low = 22000, drywet = -0.8,
	panMax = 1, amp = 1, interp = 4,  rndTrigRate = 0, speedRndTrigRate = 5, speedRndRate = 5, rndRate = 0, pan = 0, mulPan = 0, posS = 0, busAmpIndex = 0, micSwitch = 1, whichMic = 0;

    var trate, rndPos, ausgang, am, midiOsc, freqMod, sig, reverbered, chain, r_list, ampBus, bus;
		ampBus = Select.kr( whichMic, In.kr( busAmpIndex, 4));
	bus = Select.kr(micSwitch, [1, ampBus]);

	r_list = [ 1, 1/2, 1/3, 1/4, 1/5, 1/6, 1/7, 1/8, 1/10, 1/12, 1/14, 1/16, 1/20, 1/24, 1/28, 1/32, 1/40, 1/48, 1/56, 1/64];
	rate = rate * frate;
	pos = pos + LFNoise0.kr(lfoR, amtRnd );

	trigRateR = (trigRateR + LFNoise0.kr(speedRndTrigRate, rndTrigRate)).abs ;
	trate = (trigRate + Select.kr(trigRateR, r_list.reciprocal) + Select.kr(LFNoise0.kr(speedRndTrigRate, rndTrigRate), r_list.reciprocal)).abs;
	rate = rate + LFNoise0.kr(speedRndRate, rndRate);

	ausgang = GrainBuf.ar(1, Impulse.kr(trate) ,dur , bufNum, rate, pos.linlin(0, 1, 0,  BufDur.kr(bufNum))  ,4, pan);

	// AM
	am = SinOsc.ar( freqMIDI+amFreq, mul:amVol*1.5) * SinOsc.ar( (freqMIDI+amFreq)/2, mul:amVol*1.5);

	ausgang = XFade2.ar(ausgang, ausgang * am, amVol.linlin(0, 1, -1, 1));
	ausgang = LPF.ar(ausgang, freqLPF.lag(1));

	sig = PanAz.ar(~num_channels, ausgang, posS + LFNoise2.kr(0.1).range(-0.25, 0.25));

	bus = Select.kr(micSwitch, [1, ampBus]);

	Out.ar(out, sig * volume * bus );

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

SynthDef(\looper, { arg outbus, input_ch = 0, input_sel = 1, reclevel=0, prelevel=1, loop_rec = 0, loop_play = 1, trigger = 1, buf, volume = 1, rate =1, frate = 1, lpos = 0 , freqShift = 1, fshift = 1, windowSize = 0.2, randRatio = 0, width = -1, overlaps = 8, posS = 0;
	var sig = LeakDC.ar(SoundIn.ar(input_ch, 2)),// SelectX.ar(input_sel, [SoundIn.ar(input_ch,  2), In.ar(0, 1)]),
        play = PlayBuf.ar(1, buf, rate * frate, loop: loop_play),
	play2 = Warp1.ar(1, buf, lpos, freqShift * fshift, windowSize, -1, overlaps, windowRandRatio: randRatio, interp: 4),
        record = RecordBuf.ar(sig <! play, buf, recLevel: reclevel, preLevel:prelevel,
loop: loop_rec, trigger:trigger), ausgang;
	ausgang = XFade2.ar(play, play2, width, volume).softclip(0.9);
	ausgang = LeakDC.ar(ausgang);
	ausgang = PanAz.ar(~num_channels, ausgang, posS);
	Out.ar(outbus, ausgang);
}).add;

// not updated to multichannel, do i actually need it?

SynthDef(\looperD, { arg outbus, input_ch = 0, reclevel=0, prelevel=1, loop_rec = 0, loop_play = 1, trigger = 1, buf, volume = 1,rate = 1, frate = 1, maxdelay = 0.5, delaytime = 0.1, decaytime = 1, muldelay = 1, width = -1;
	var sig = LeakDC.ar(SoundIn.ar(input_ch, 2)),
        play = PlayBuf.ar(1, buf, rate * frate, loop: loop_play),
	delay = AllpassC.ar(play, maxdelay, delaytime, decaytime, muldelay),
        record = RecordBuf.ar(sig <! play, buf, recLevel: reclevel, preLevel:prelevel,
loop: loop_rec, trigger:trigger);

		play = LeakDC.ar(play);
		delay = LeakDC.ar(delay);

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
	in = In.ar(outbus, 6);
	//12.do({ sig = AllpassN.ar(in, 0.040 * delay, [0.020.rand,0.020.rand] * delay, decaytime, mul) });
	//sig = Array.fill(3, CombC.ar(in, 2, delay, decaytime, mul, in));
//	sig = AllpassC.ar(in, 2, delaytime, decaytime, mul, in);
	sig = CombC.ar(in, 2, delaytime.lag(1), decaytime, mul, in);

	ReplaceOut.ar(outbus, sig);
}).add;





SynthDef(\GVerb, { arg outbus = 0, roomsize= 243, revtime= 1, damping= 0.1, inputbw= 0.34, spread= 15, drylevel= -60, earlylevel= -11, taillevel= -9, volume = 3;
	var sig, in;
	in = In.ar(outbus, 6);
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

SynthDef(\combEffect, {arg outbus = 0, lfoRate = 0, phase = 0.45, depth = 2.5, predelay = 10, maxdelaytime = 0.5, fdbAmt = -0.9, drywet = 1, volume = 1;
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
	Limiter.ar(sig, 0.9) * volume;

ReplaceOut.ar(outbus, sig);


}).add;

/*
old version of combEffect
SynthDef(\combEffect, {|  outbus = 0,
	maxdelayt = 1, delayarr = #[ 0.016415828466415, 0.036066961288452, 0.045210140943527, 0.038088554143906, 0.037890076637268, 0.026094967126846 ], delaytime = 0.1, decaytime = 2,
	freqRingz = 111, freqMaxRingz = 222, gSpeed = 0.74, mulRingz = 0.1, volume = 1, mulComb = 1, decayRingz = 0.2|
	var out, in, trig;
	in = In.ar(outbus, 6);
	freqRingz = LFNoise0.kr(gSpeed).range(freqRingz, freqMaxRingz);
	out = Ringz.ar( in, freqRingz, decayRingz, mulRingz);
	//out =  SplayAz.ar(6, CombN.ar(out, maxdelayt, delaytime * delayarr, decaytime, mulComb/delayarr.size));

	ReplaceOut.ar(outbus , volume * out);
}).add;
*/

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


SynthDef(\soundRock, { arg outbus = 0, volume = 0, input = 0, freqMul = 1, decayscale = 1 , busAmpIndex = 0, busFreqIndex = 4, micSwitch = 0, whichMic = 2;

	var scale, specs, freqs, amps, rings, in = LeakDC.ar(SoundIn.ar(input)),
	numRes = 10, bells = 1, pan, freq, hasFreq = 1, freqScale, out, ampBus;
	# freq, hasFreq = Pitch.kr(in, ampThreshold:0.01);

		ampBus = Select.kr( whichMic, In.kr( busAmpIndex, 4));
	//freq = Select.kr( whichMic, In.kr( busFreqIndex, 3));	//Amplitude.kr(in).poll;
//scale = [60, 62, 64, 67, 69].midicps;

//	scale = (Scale.whole.ratios *50).round.midicps;
	scale = [32, 48, 74, 90, 114];
	freqScale = Demand.kr(hasFreq, 0, Drand(scale/65
, inf));

	out = Mix.fill(bells, {
		//freqs = Array.fill(numRes, {rand(0.5, 2.0)*(scale.choose)});
		freqs = Array.fill(numRes, {rand(1.0, 5.0) * (scale.midicps.choose)}) * freqScale * freqMul;

		amps = Array.fill(numRes, {rrand(0.3, 0.7)});
		rings = Array.fill(numRes, {rrand(0.5, 3.0)});
		specs = [freqs, amps, rings].round(0.01);
		// specs.postln;
		pan = (LFNoise1.kr(rrand(3, 6))*2).softclip;
		Pan2.ar(

			(DynKlank.ar(`specs, in  * 0.5   ) * 0.1)
			+ Ringz.ar(BrownNoise.ar(0.1), {exprand(70, 20000)}.dup(100) * freqScale, decayscale, 0.001).mean
	//input = input);
//			(in * SinOsc.ar(freqs).mean * EnvGen.ar(Env.perc))+
			//* BrownNoise.ar(1)
			,
				pan, bells.reciprocal *4
		)
	});
	out.clip2(0.9);
	out = LeakDC.ar(out);

	Out.ar(outbus, out * volume * 0.1);
}).add;

SynthDef(\freq_wander, { arg outbus=0, lo=70, hi=100, step=0.1, rate=10, volume=0.5, pan=0, lgate = 1, scale_val = 1, deviation = 1, spread_speed = 3, center_speed = 1, orientation = 0.5, busAmpIndex = 0, busFreqIndex = 4, micSwitch = 1, whichMic = 2;
	var output, freq, num_comb, num_tones, freq_list, bus,  ampBus, freqMic;
	num_comb = 36;
	num_tones = 48;




	freq = Demand.ar(Impulse.ar(rate), 0, Dbrown(lo, hi, step,)).midicps * scale_val;
//	freq = Demand.ar(Impulse.ar(rate), 0, SinOsc.ar(0.02).range(lo, hi)).midicps * scale_val;

		// use mic input to control some parameters
			ampBus = Select.kr( whichMic, In.kr( busAmpIndex, 4));
	freqMic = Select.kr( whichMic, In.kr( busFreqIndex, 4));
	freq = Select.kr(micSwitch, [freq, freqMic]);
	bus = Select.kr(micSwitch, [1, ampBus]);

	output = LPF.ar(
		//Mix.new(VarSaw.ar((freq + [0, -0.2, 0.2, 0.4, -0.4]).poll, 0, 0.8, 0.1)),
		Mix.new(VarSaw.ar((freq + Array.fill(num_tones, {gauss(0.0, 0.5) * deviation})), 0, 0.8, 0.5)),

		LFNoise2.ar(1).range((freq/2), (freq*1.5)),
	);

	output = Array.fill(num_comb,{ CombN.ar(output, 0.02, rrand(0.001, 0.02), 2, 1/num_comb) });

	output = SplayAz.ar(~num_channels, output, LFDNoise3.kr(spread_speed).range(0,1), 1, 2, LFDNoise3.kr(center_speed), orientation  );

	OffsetOut.ar(outbus, Pan2.ar(output, pan, volume) * bus);
}).add;

SynthDef(\stranga, {arg outbus = 0, speed = 20, volume = 1, volume2 = 1, pitch =0.8, pitch_fine =0.5, pitch_dev = 1, decay_time = 2, reverb_amt = 1, pan = 1,
	predelay = 0.048, combdecay=5, allpassdecay=1, revVol=0.31, spread_speed = 0, center_speed = 1, orientation = 0.5;
    var num_voices = 32, output, reverbed;
	//pitch = MouseY.kr;
	//speed = MouseX.kr(0, 10);
	//decay_time = MouseY.kr(6, 1);

	output = CombL.ar( (
		Dust.ar(speed.dup(num_voices),20 * speed.linlin(0,10, 0.8, 1.4))), 0.1, {((
		gauss(0.002, pitch_dev.linlin(0, 1, 0.0001, 0.0005)).abs
		//0.004.rand+0.0003
		+ pitch_fine.linlin(0, 1, 0.0009,0.0001).lag(0.4)) * pitch.linlin(0, 1, 5, 0.5)
	) }.dup(num_voices), {decay_time.rand}, 1/num_voices);
	output = RLPF.ar(output, pitch_fine.linlin(0, 1, 100, 3000 ), 0.3, 1);

	//output = Pan2.ar(output, {1.0.rand2}.dup(num_voices));

	output = output * Lag3UD.kr(volume * volume2, 0, 0.3);

	//output = Mix.new( output) ;
	output = LeakDC.ar(output);

	output = SplayAz.ar(~num_channels, output, LFDNoise3.kr(spread_speed).range(0,1), 1, 2, LFDNoise3.kr(center_speed), orientation  );

	Out.ar(outbus, output  );
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
*/