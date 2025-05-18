

(

~parameters = [





	[z,
		['soundRock',
			[
				['volume', 0.0, 2.0, 'linlin'],
				['input', 0, 3, 'linlin'],
				['freqMul', 0.1, 3.0, 'linlin'],
				['micSwitch', 0, 2, 'linlin'],
				['whichMic', 0, 4, 'linlin'],


				['decayscale', 0.1, 3.0, 'linlin']



			]
	]]
	,


	[z ,
		[ 'PingPong',
			[

				['volume', 0.1, 4, 'linlin'],
				['feedback', 0.01, 1.5, 'linlin'],
				['delayTime', 0.01, 2, 'linexp'],
				['delayWet', 0.1, 1, 'linlin'],
				['pitchRatio', 0.1, 4, 'linlin'],
				['pitchDispersion', 0.01, 4, 'linlin'],
				['timeDispersion', 0.1, 3, 'linlin'],
				['mulShift', 0, 2, 'linlin'],
				['pitchWet', 0, 1, 'linlin'],
				['whichMic', 0, 4, 'linlin']

			]
	]]
,
/*
			[z,
		['res',

			[
				['volume', 0.0, 2.0, 'linlin'],
				['dev', 0.0001, 0.3, 'linexp'],
				['bwr', 0.0001, 0.15, 'linexp'],
				['spac_speed', 0.0, 5.0, 'linlin'],
				['vol_freq1', 0, 10, 'linlin'],
				['vol_freq3', 0, 10, 'linlin'],
				['vol_freq4', 0, 10, 'linlin'],
				['vol_freq5', 0, 10, 'linlin'],
				['vol_freq6', 0, 10, 'linlin'],
				['vol_freq7', 0, 10, 'linlin'],
				['vol_freq8', 0, 10, 'linlin'],
				['vol_freq9', 0, 10, 'linlin'],
				['vol_freq10', 0, 10, 'linlin'],
				['lpf', 50, 20000, 'linlin'],
				['rq', 0.1, 1, 'linlin'],

			],
			[

				[1.0, 0.0001, 0.0001, 0, 9, 8, 7, 6, 5, 5, 4, 3, 2, 5000, 0.5],
				[1.0, 0.0001, 0.02, 0.5, 9, 8, 7, 6, 5, 5, 4, 3, 2, 5000, 0.5],
				[1.0, 0.0001, 0.1, 10, 9, 8, 7, 6, 5, 5, 4, 3, 2, 5000, 0.5],
				[1.0, 0.0001, 0.15, 50, 9, 8, 7, 6, 5, 5, 4, 3, 2, 5000, 0.5],

			]
	]]

	,


	*/
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
		['comb',
			[
				['volume', 0.0, 2.0, 'linlin'],
				['intensity', 0.1, 20, 'linlin'],
				['delaytime', 0.001, 3.0, 'linexp'],
				['decaytime', 0.1, 5, 'linlin'],
				['mulComb', 0.1, 3, 'linlin'],
				['freqRingz', 50, 5000, 'linlin'],
				['decayRingz', 0.1, 5, 'linlin'],
				['mulRingz', 0.1, 3, 'linlin'],



			]
	]]
	,
*/


	[z,
		['gendy',
			[
				['volume', 0.0, 1.0, 'linlin'],
				['freq', 50, 5000, 'linlin'],
				['freqFine', 0.1, 2, 'linlin'],
				['freqMinMul', 0.1, 3, 'linlin'],
				['freqMaxMul', 0.1, 5, 'linlin'],
				['initCPs', 1, 24, 'linlin'],
				['kumcps', 1, 24, 'linlin'],
				['ampdist', 0, 6, 'linlin'],
				['durdist', 0.1, 5.0, 'linlin'],
					['micSwitch', 0, 1, 'linlin'],


			//	['adparam', 0.0001, 1.0, 'linlin'],
			//	['ddparram', 0.0001, 1.0, 'linlin'],
				['whichMic', 0, 4, 'linlin'],
				//['durscale', 0.0, 1.0, 'linlin'],
				['spread_speed', 0.0, 25, 'linlin'],
				['center_speed', 0.0, 25, 'linlin'],
				['orientation', -1.0, 1.0, 'linlin']
				//['freqResonz', 30, 2000, 'linlin'],
				//['bwr', 0.01, 2.0, 'linlin']
			]
	]],




/*

[z,
		['freq_wander',
			[
				['volume', 0, 1, 'linlin'],
				['scale_val', 0.1, 3, 'linexp'],
				['deviation', 0.1, 100, 'linexp'],
				['rate', 1, 50, 'linlin'],
				['step', 0.01, 10, 'linexp'],
				['lo', 10, 100, 'linlin'],
				['hi', 30, 150, 'linlin'],
				['spread_speed', 0.0, 25, 'linlin'],
				['center_speed', 0.0, 25, 'linlin'],
				['orientation', -1.0, 1.0, 'linlin']

			]
	]]


	,
	[z,
		['dynKlank',
			[
				['freqMul', 20, 10000, 'linlin'],
				['whiteN', 10, 10000, 'linlin'],
				['volume', 0, 1, 'linlin']

			]
	]]
		*/
];

)
