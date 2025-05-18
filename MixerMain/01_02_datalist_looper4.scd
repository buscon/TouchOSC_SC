~looper_controls_values = [['rec', 'play'], ['overdub', 'play'], ['play', 'stop'], ['stop', 'play']];

~looper_parameters = [
	['',
		['looperD',
		[
			['rate', -1, 2, 'linlin', 1],
			['frate', 0.9000, 1.1000, 'linlin', 1],
			['width', -1.0, 1.0, 'linlin', 0.2],
			['maxdelay', 1, 2, 'linlin', 2],
			['delaytime', 0.01, 2, 'linlin', 0] ,
			['decaytime', 0.1, 4, 'linlin', 1],
			['muldelay', 0.1, 6, 'linlin', 1],
			['', 0, 1, 'linlin', 0],
			['volume', 0, 20, 'linlin', 1]
		]
	]],
		/*
	['',
		['looperD',
		[
			['rate', -1, 2, 'linlin', 1],
			['frate', 0.9000, 1.1000, 'linlin', 1],
			['width', -1.0, 1.0, 'linlin', 0.2],
			['maxdelay', 1, 2, 'linlin', 2],
			['delaytime', 0.01, 2, 'linlin', 0] ,
			['decaytime', 0.1, 4, 'linlin', 1],
			['muldelay', 0.1, 6, 'linlin', 1],
			['', 0, 1, 'linlin', 0],
			['volume', 0, 20, 'linlin', 1]
		]
	]],
	*/

	['',
		['looper',
		[
			['rate', -1, 2, 'linlin', 1],
			['frate', 0.9000, 1.1000, 'linlin', 1],
			['width', -1, 1, 'linlin', -1],
			['lpos', 0, 1, 'linlin', 0] ,
			['freqShift', -1, 2, 'linlin', 1],
			['fshift', 0.9000, 1.1000, 'linlin', 1],
			['windowSize', 0.001, 2.0, 'linlin', 0.2],
			['randRatio', 0, 1, 'linlin', 0],
			['volume', 0, 20, 'linlin', 1]
		]
	]],

	['',
		['looper',
		[
			['rate', -1, 2, 'linlin', 1],
			['frate', 0.9000, 1.1000, 'linlin', 1],
			['width', -1, 1, 'linlin', -1],
			['lpos', 0, 1, 'linlin', 0] ,
			['freqShift', -1, 2, 'linlin', 1],
			['fshift', 0.9000, 1.1000, 'linlin', 1],
			['windowSize', 0.001, 2.0, 'linlin', 0.2],
			['randRatio', 0, 1, 'linlin', 0],
			['volume', 0, 20, 'linlin', 1]
		]
	]],
		['',
		['looper',
		[
			['rate', -1, 2, 'linlin', 1],
			['frate', 0.9000, 1.1000, 'linlin', 1],
			['width', -1, 1, 'linlin', -1],
			['lpos', 0, 1, 'linlin', 0] ,
			['freqShift', -1, 2, 'linlin', 1],
			['fshift', 0.9000, 1.1000, 'linlin', 1],
			['windowSize', 0.001, 2.0, 'linlin', 0.2],
			['randRatio', 0, 1, 'linlin', 0],
			['volume', 0, 20, 'linlin', 1]
		]
	]]
];

