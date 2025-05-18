

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



SynthDef(\wedSynth,{arg
	outbus = 0,
	midinote=60,
							octave=0,
							dronelvl=0.5,
							mDist = 1,
							rMix = 0.25,
							rRoom = 0.15,
	pitchBend = 0.01,
	modP = 0.01,
	volume = 0.5,
							mButton,
							daBuff;


var vals, buf,  s, drone, noise, melody, pulse, root;
root = midinote+(12*octave);
f = root.midicps;							//Root frequency
g = (root+19).midicps;						//Compound fifth above root frequency
	x = pitchBend.linexp(0.001, 1.0, f, g).lag(1);
	y = modP.linexp(0.001, 1.0, 0.25, 0.05);
z = Index.kr(daBuff, MouseX.kr(0, 20));
mButton = MouseButton.kr([x, x*2], [z, z*2] );

/////////Synths//////////////
drone = SinOsc.ar([f, f/2], mul:1)*									EnvGen.kr(Env.new(
				 					Array.rand(16, 0, 0.2),  //Random drones
									Array.rand(15, 1, 5),
									'exponential',
									0,
									1));

noise = Ringz.ar(WhiteNoise.ar(0.005),
            f*2,
            mul:MouseY.kr(0.15,0.25,'exponential')
            );

melody = Mix.ar([SinOsc.ar(KeyState.kr(
									46,		//m key
									mButton,
									0),
					SinOsc.kr(y*50, 0, 1),  	//Phase modulation controlled by mouse
					mDist).wrap2(1)*y]);		//Amplitude controlled by mouse

pulse = LFPulse.ar(KeyState.kr(
									46,
									mButton,
									0.8),
					0,
					LFTri.kr(0.2, 0, 0.5, 0.5),
					y/4);

/////////Output//////////////
Out.ar(outbus,
	Mix.new([
			drone*dronelvl,
			FreeVerb.ar(drone*dronelvl,
						0.8,
						0.7),
			FreeVerb.ar(Mix.new([
								melody,
								Latch.ar(pulse, noise)
								]),
						rMix,
						rRoom
						),
			noise
			]) * volume
		);
}).add;

SynthDef(\organ, { arg outbus=0, freq=1000, fineFreq = 1, amp=0.2, pan=0, gate=1;
var signal, shift1, shift2, shift3, shift4, input, output, comp1,comp2, comp3, comp4;
	freq = freq * fineFreq;
signal = Saw.ar(freq * [0.998, 1, 1.003]).sum + SinOsc.ar(2*freq, 0, -4.dbamp);

signal = (signal*0.5) + Resonz.ar(signal, 2/[2 , 4, 8, 14, 32, 50, 80], [200, 400, 800, 1400, 3200, 5000, 8000]).mean;
signal = MoogFF.ar(signal, freq * 4, 3.2);
signal = FFT(LocalBuf(2**10), signal);
signal = PV_MagSquared(signal);
signal = PV_LocalMax(signal, 31);
signal = IFFT(signal);
signal = EnvGen.kr(Env.adsr(releaseTime: 0.1), gate, doneAction: 2) * signal;

	input = signal;
	input = Mix.fill(6, { CombN.ar(input, 0.2, LFNoise2.kr(0.01, {Rand(0.01, 0.1)}, 0.05).abs, 10, 1/6) });


	Out.ar(outbus, Pan2.ar(input * (-28.dbamp) * amp * 0.5, pan).clip2(0.9));

}).add;

SynthDef(\impulses, { | outbus = 0, impulseSpeed = 1, dustSpeed = 0, freqMul = 1, decayMul = 1, mulMul = 1, speedChange = 1, freqLPF = 22000, mulChange = 1,volume = 1 |
	var sig;
	impulseSpeed = impulseSpeed + LFNoise0.kr(speedChange).range(0, mulChange);
	sig = Ringz.ar(PinkNoise.ar(Impulse.ar(impulseSpeed.abs) + Dust.ar(dustSpeed) ), {gauss(300, 20000)}.dup(50) * freqMul, {exprand(0.3, 1.0)}.dup(50) * decayMul, {exprand(0.3, 1.0)}.dup(50) * mulMul).mean.dup(2);
	sig = LPF.ar(sig, freqLPF);
	Out.ar(outbus, sig * volume);
}).add;


