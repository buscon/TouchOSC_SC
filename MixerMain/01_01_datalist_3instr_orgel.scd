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
	[z ,
		[ 'organ',
			[
				['freq', 20, 5000, 'linlin'],
				['fineFreq', 0.01, 2.0, 'linlin'],
				['pan', -1.0, 1.0, 'linlin'],

				['amp', 0, 5, 'linlin']
			]
	]],
	[z,
		['harmMod',
			[
				['carrier', 1, 100, 'linlin'],
				['harm', 1, 10, 'linlin'],
				['bright', 1, 50, 'linlin'],
				['hpan', -1.0, 1.0, 'linlin'],

				['volume', 0, 1, 'linlin']
			]
	]]

	/*
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


*/
	,
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


];

)
