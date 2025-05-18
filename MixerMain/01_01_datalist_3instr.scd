(

~parameters = [
	/*
	[z ,
	[ 'glitch_sounds',
	[
	['modAmp', 20000, 200000, 'linlin'],
	['master_volume', 0, 1, 'linlin'],
	['modF', 0, 1, 'linlin'],
	['modN', 0, 1, 'linlin'],
	['modC', 0, 1, 'linlin'],
	['gpos', 0, 1, 'linlin']
	]
	]],
	*/

	[z,
		['combP',
			[
				['volume', 0.0, 2.0, 'linlin'],
				['delayscale', 0.01, 2, 'linlin'],
				['decaytime', 0.1, 3, 'linlin'],
				['mulComb', 0.1, 3, 'linlin'],
				['pitchRatio', 0, 4, 'linlin'],
				['pitchDispersion', 0, 3, 'linlin'],
				['timeDispersion', 0, 3, 'linlin'],
				['mulPShift', 0, 3, 'linlin'],
				['gainInput', 1, 3, 'linlin'],

				['input', 0, 2, 'linlin']
			]
	]]
	,
	[z,
		['gendyP',
			[
				['volume', 0.0, 1.0, 'linlin'],
				['input', 0, 2, 'linlin'],
				['freqMul', 0.1, 3, 'linlin'],
				['freqMaxMul', 0.5, 5, 'linlin'],
				['freqMinMul', 0.1, 3, 'linlin'],
				['decayscale', 0.1, 3.0, 'linlin'],
				['amp_max', 0.3, 1.0, 'linlin'],


			]
	]]
	,
	[z ,
		[ 'PingPong',
			[

				['volume', 0.1, 3, 'linlin'],
				['feedback', 0.01, 4, 'linlin'],
				['delayTime', 0.01, 3, 'linexp'],
				['rotation', 0.1, 2, 'linlin']
			]
	]]
	/*
	,
	[z,
	['harmMod',
	[
	['carrier', 1, 100, 'linlin'],
	['harm', 1, 10, 'linlin'],
	['bright', 1, 50, 'linlin'],
	['volume', 0, 1, 'linlin']
	]
	]]
	,
	[z,
	['isoc',
	[
	['speed', 1, 50, 'linexp'],
	['freqSaw', 1, 80, 'linlin'],
	['freqRingz', 1, 80, 'linlin'],
	['mulPulse', 0.1, 10, 'linlin'],
	['mulDust', 0.1, 10, 'linlin'],
	['pulsethepulse', 0, 10, 'linlin'],
	['changeSpeedPulse', 0, 10, 'linlin'],
	['lowPassFreq', 100, 22000, 'linlin'],
	['volume', 0,4, 'linlin']
	]
	]]
	[z,
	['dust_touch',
	[
	['density', 1, 100, 'linlin'],
	['ps_pr', 0.0, 4.0, 'linlin'],
	['ps_pr', 0.0, 4.0, 'linlin'],
	['ps_td', 0.001, 0.2, 'linlin'],
	['ps_pd', 0.0, 4.0, 'linlin'],

	['volume', 0, 1, 'linlin']
	]
	]]
	,

	[z,
	['pinkfilt',
	[
	['freq', 20, 10000, 'linlin'],
	['rq', 0.1, 2.0, 'linlin'],
	['volume', 0, 1, 'linlin']

	]
	]]
	,
	[z,
	['comb',
	[
	['intensity', 0.1, 50, 'linlin'],
	['delaytime', 0.1, 3.0, 'linlin'],
	['decaytime', 0.1, 12, 'linlin'],
	['mulComb', 0.1, 3, 'linlin'],
	['freqRingz', 50, 1000, 'linlin'],
	['decayRingz', 0.01, 1, 'linlin'],
	['mulRingz', 0.01, 1, 'linlin'],
	['volume', 0.0, 3.0, 'linlin']
	]
	]]
	,

	[z,
	['hString',
	[
	['speed', 0.1, 10, 'linlin'],
	['pitch', 0.1, 20, 'linlin'],
	['harm', 1, 200, 'linlin'],
	['freqscale', 0.1, 2, 'linlin'],
	['volume', 0, 1, 'linlin']
	]
	]]
	,
	[z,
	['isoc',
	[
	['speed', 1, 100, 'linexp'],
	['speed2', 0, 20, 'linlin'],
	['freq', 1, 20, 'linlin'],
	['volume', 0,4, 'linlin']
	]
	]]



	[z,
	['wedSynth',
	[
	['midinote', 12, 127, 'linlin'],
	['octave', 0, 8, 'linlin'],
	['mDist', 0.1, 3, 'linlin'],
	['rMix', 0.1, 2, 'linlin'],
	['rRoom', 0.1, 2, 'linlin'],
	['pitchBend', 0.01, 1, 'linexp'],
	['modP', 0.01, 1, 'linexp'],
	['volume', 0,4, 'linlin']
	]
	]]
	*/

];

)
