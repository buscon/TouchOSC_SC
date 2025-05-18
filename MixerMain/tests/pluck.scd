Ndef(\pluck).set(\gendyF, 8000, \mulP, 0.1);
(
Ndef(\pluck, { arg outbus = 0, volume = 1, speed = 5, gendyF = 100, hpfF = 20, mulP = 0.1, mulG = 1.0, mulC = 0.1, busAmpIndex = 0, freqMul = 1, busFreqIndex = 4, micSwitch = 0, whichMic = 2;
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
}).play;
)
9e3