(
~parameters_returns = [
	['' ,
		[ 'GVerb',
			[
				['roomsize', 10, 300, 'linlin'],
				['revtime', 1, 30, 'linlin'],
				['damping', 0, 1, 'linlin'],
				//['inputbw', 0, 1, 'linlin'],
				['spread', 0, 50, 'linlin'],
				['drylevel', -60, 0, 'linlin'],
				['earlylevel', -30, 0, 'linlin'],
				['taillevel', -30, 0, 'linlin']
				//['volume', 0, 5, 'linlin']

			]
	]],
	['',
		['delay',
			[

				['delaytime', 0.01, 2, 'linlin'],
				['decaytime', 0.1, 10, 'linlin'],
				['mul', 0.1, 5, 'linlin'],
			['chtest', 0, 1, ''],
			[' ', 0, 1, ''],
			[' ', 0, 1, ''],
			[' ', 0, 1, '']
			]
	]]

		,
		['',
		['combEffect',
			[
				['lfoRate', 0.0, 2.0, 'linlin'],
				['phase', 0, 1, 'linlin'],
				//['mulComb', 0.1, 3, 'linlin'],
				['depth', 0, 30, 'linlin'],
				['predelay', 0, 20, 'linlin'],
				['fdbAmt', -0.8, -1.0, 'linexp'],

				//['decayRingz', 0.01, 1, 'linlin'],
				['drywet', 0, 1, 'linlin'],
				['volume', 0.0, 3.0, 'linlin']
			]
	]]

	/*
	['',
		['tape_delay',
			[
				['maxdelaytime', 0.1, 3, 'linlin'],
				['delaytime', 0.01, 2.0, 'linlin'],
				['decaytime', 0.1, 5, 'linlin'],
				['volume', 0, 3, 'linlin'],
			['', 0, 1, 'linlin'],
			['', 0, 1, 'linlin'],
			['', 0, 1, 'linlin']
			]
	]]

	,
	['',
		['monograin',
			[
				['delaytime', 0.1, 3, 'linlin'],
				['decaytime', 0.1, 2.0, 'linlin'],
				['width', 0, 1, 'linlin'],
				['winsize', 0.01, 0.3, 'linlin'],
			['grainrate', 2, 15, 'linlin'],
			['rand', 0, 1, 'linlin'],
			['volume', 0, 3, '']
			]
	]]
	*/

];

)
