(
SynthDef(\blipDelay, { |outbus, bufnum, t_repan|
   var dly, dtime, sig, newdly, bufRate;
   sig = In.ar(outbus, 2);
      // this technique is borrowed from MultiTap
   RecordBuf.ar(Mix.ar(sig) * 0.7, bufnum, 0, run:-1);
   bufRate = BufSampleRate.kr(bufnum);
   dtime = 0;
   dly = Mix.arFill(3, { |i|
      dtime = dtime + rrand(0.5, 2);
      dly = PlayBuf.ar(1, bufnum, -1, startPos:dtime * bufRate, loop:1);
      Pan2.ar(LPF.ar(dly, 5000 - (i*2000)),
         TRand.kr(-1.0, 1.0, t_repan), (i+3).reciprocal);
   });
   Out.ar(outbus, dly)
}).add;

SynthDef(\blipdrop, { |out, freq, freqdrop, dur, trigStart, trigEnd, bufnum|
   var trig, tfreq, amp, timeScale, osc, pan;
   trig = Impulse.kr((tfreq = XLine.kr(trigStart, trigEnd, dur))
      + LFNoise0.kr(12, tfreq * 0.8, tfreq));
   amp = EnvGen.kr(Env(#[0, 1, 0.8, 0], #[0.01, 4, 4].normalizeSum), 1, timeScale:dur,
      doneAction:2);
   pan = LFNoise1.kr(0.8, 0.8);
   freq = freq * LFNoise1.kr(1.2, 0.2, add: Line.kr(1, freqdrop, dur));
   osc = Osc.ar(bufnum, Latch.kr(freq, trig), 0, amp);
   Out.ar(out, Pan2.ar(Decay2.kr(trig, 0.01, 0.08) * osc, pan));
}).add;

// other resources needed by the synthdefs
~dlybuf = Buffer.alloc(s, 6.05 * s.sampleRate, 1);
~oscbuf = Buffer.alloc(s, 4096, 1)
   .sine2(({ |i| rrand(3-i, 6-i) + (i+2).reciprocal.rand2 } ! 4), (1..4).reciprocal);

SynthDef.new("pinkfilt", {
	arg	outbus,	// outbus is the standard name used by MixerChannel
		freq, rq;
	Out.ar(outbus, RLPF.ar(PinkNoise.ar, freq, rq));
}).add;

SynthDef.new("fx/chorus1x1", {
	arg outbus, delay = 0.01, freq = 0.2, depth = 0.05, wet = 1;
	var in, out;
	in = In.ar(outbus, 2);
	out = DelayN.ar(in, 1, SinOsc.ar(freq, 0, depth, delay));
	ReplaceOut.ar(outbus, in*(1-wet).sqrt + out*wet.sqrt);  // equal power
}).add;

SynthDef.new(\delay, { arg outbus = 0, delay = 1, decaytime = 3;
	var sig, in;
	in = In.ar(outbus, 2);
	12.do({ sig = AllpassN.ar(in, 0.040 * delay, [0.020.rand,0.020.rand] * delay, decaytime) });
	ReplaceOut.ar(outbus, sig);
}).add;

SynthDef("harmMod",{arg outbus, carrier = 10, harm = 5, bright = 5, volume = 1, sidechain;
	var snd, modFreq, modAmp, modOsc, brightness, carrierOsc, carrierSignal;
	carrierSignal = Signal.newClear(512).fill(1) * carrier;
	modFreq =  carrier * harm;
	modOsc = SinOsc.ar(modFreq);
	brightness = modFreq * bright;
	modAmp = modOsc * brightness;
	carrierOsc = SinOsc.ar(carrier + modAmp)!2;

	Out.ar(outbus, carrierOsc * volume);
}).add;

SynthDef("dust_touch", { arg out=0;
	var sig;
	sig = Dust2.ar(10, 1);
	sig = PitchShift.ar(sig, 0.05, 2);
	//sig = GVerb.ar(sig, 5, 2);

//	6.do({ sig = AllpassN.ar(sig, 0.040, [0.020.rand,0.020.rand], 3) });
	//sig = BPeakEQ.ar(sig, 1000, 0.1, 5);
	sig = BHiPass.ar(sig, 1000, 0.5, 2);

	//sig = BLowPass.ar(sig, 200, 0.1, 2);
	//sig = GVerb.ar(sig, 3, 1, 1);

    Out.ar(out,
        sig!2
    )
}).add;

SynthDef(\GVerb, { arg outbus = 0, roomsize= 10, revtime= 3, damping= 0.5, inputbw= 0.5, spread= 15, drylevel= 1, earlyreflevel= 0.7, taillevel= 0.5;
	var sig, in;
	in = In.ar(outbus, 2);
	sig = GVerb.ar(in, roomsize, revtime, damping, inputbw, spread, drylevel, earlyreflevel, taillevel);
	ReplaceOut.ar(outbus, sig);
}).add;
)

x = Synth(\dust_touch);
y = Synth.after(x, \delay);

(
r = Task({
   {   ~chan.play(\blipdrop, [\freq, rrand(1000, 2000), \freqdrop, rrand(0.4, 0.7),
         \dur, rrand(6, 10), \bufnum, ~oscbuf.bufnum,
         \trigStart, rrand(1.1, 1.4), \trigEnd, rrand(7.0, 10)]);
      rrand(5, 12).wait;
   }.loop;
}).play;
);

r.stop
)
