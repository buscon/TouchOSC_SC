~granulator = Synth(\granulator, [\bufNum, ~gbuf3, \volume, 0.1]);

trigRate
amtRnd 0-1
lfoR 0.1-30

amVol 0-1
amFreq 10 - 127

rate: slider -1.0 - 2.0. bottone riporta  1
volume 0 - 1
rndTrigRate 0 - 1
speedRndTrigRate 0.1-10

drywet  -1 +1
amp 0 - 1
(


~granulator = Synth(\granulator, [\bufNum, ~gbuf3]);

~granulator.set(\bufNum, ~gbuf4);

g.set(\master_volume, 1);
g.set(\master_volume, 1);

g.set(\bufNum, b);

(

//b = Buffer.read(s, "/Users/marcello/Music/Supercollider/Monster/Samples/mix_bells_rr_steps2_mono.wav");
//b = Buffer.read(s, "/Users/marcello/Music/Supercollider/Monster/Samples/organic/Selection/Bowl1.wav");
//b = Buffer.read(s, "/Users/marcello/Music/Supercollider/different bodies/samples/french_voice_no_silence_mono.wav");
b = Buffer.read(s, "/Users/marcello/Music/Samples/Capre_limited.wav");
g = Synth(\gran_m, [\bufNum, b, \volume, 0.4]);
g.set(\amtRnd, 0.01);
g.set(\lfoR, 10);
)

(
g.set(\amtRnd, 0.001);
g.set(\lfoR, 2);
g.set(\overlap , 2);
g.set(\drywet , -0.8);
)
g.set(\pos, 0.2);
g.set(\trigRate, 10);
g.set(\volume, 1);
g.set(\amp, 0.3);
g.set(\rndTrigRate, 0);
g.set(\speedRndTrigRate, 6);
g.set(\rate, 1);
)
g.set(\rate, 1);

g.set(\freeze, 1);
g.set(\freeze, 0);

(
//b = Buffer.read(s, "/Users/marcello/Music/Supercollider/different bodies/samples/french_voice_no_silence_mono.wav");
b = Buffer.read(s,  "/Users/marcello/Music/Listen/Björk - Biophilia [CD]-FLAC-(2011)/03 - Crystalline.wav");
g = Synth(\gran_m, [\bufNum, b, \master_volume, 0, \amtRnd, 0, \lfoR, 10]);

)
g.set(\amtRnd, 0.5);
g.set(\amtRnd, 1);
g.set(\amtRnd, 0);
g.set(\trigRate, 10);

g.set(\lfoR, 30);
g.set(\lfoR, 5);
g.set(\rndTrigRate, 0);
g.set(\rndTrigRate, 1);
g.set(\speedRndTrigRate, 12);
g.set(\speedRndTrigRate, 6);
g.set(\freeze, 1);
g.set(\freeze, 0);

g.set(\master_volume, 0.2);


(
g.set(\master_volume, 1.2);

OSCdef (\activityNormal, { |msg|
	//("ActivityAll: " ++ msg[1]).postln;

		//g.set(\freeze, -1);
			g.set(\volume, msg[1].linlin(0.1, 0.4, 0, 1));
			//g.set(\trigRate, msg[1].linlin(0.1, 1, 5, 1/8));
			g.set(\trigRate, msg[1].linexp(0.4, 1, 1, 60));




		//g.set(\rate, msg[1].linlin(0.9, 1, 1, 1.5));



	},
	'/activityNormal1',
	nil
);

OSCdef (\centerX, { |msg|
	("centerX: " ++ msg[1]).postln;
	g.set(\pos, (msg[1].linlin(0.1, 0.9, 0, 1) ));//.range(0.0,1.0).round(0.1).postln);
	},
	'/centerX1',
	nil
);

OSCdef (\height, { |msg|
	//("height: " ++ msg[1]).postln;
		//g.set(\ffreq_low, msg[1].linexp(0.1, 0.7, 50, 22000));
		//g.set(\rate, msg[1].linlin(0.3, 0.5, 0.5, 1).postln);



	},
	'/height',
	nil
);

OSCdef (\width, { |msg|
	("width: " ++ msg[1]).postln;
	//g.set(\drywet, msg[1].linlin(0.3, 1, -1, -0.5));
	},
	'/width',
	nil
);

OSCdef (\freeze, { |msg|
	("freeze: " ++ msg[1]).postln;
	//g.set(\drywet, msg[1].linlin(0.3, 1, -1, -0.5));
	},
	'/freeze',
	nil
);
)

trace