
(

~parameters = [

	[z ,
		[ 'wavPlayer',
			[
				['main_volume', 0.0, 2.0, 'linlin'],
				['speed', -1.0, 2.0, 'linlin'],
				['fine_speed', 0.90, 1.10, 'linlin'],
				['which', 0, 2, 'linlin'],
				['trigger_rate', 1, 20, 'linlin'],
				['bufnum', 0, 20, 'linlin'],
				['volume', 0.0, 2.0, 'linlin'],
				['pos', 0.0, 1.0, 'linlin'],
				['spread_speed', 0.0, 5, 'linlin'],
				['center_speed', 0.0, 5, 'linlin'],
				['orientation', -1.0, 1.0, 'linlin']

				],
			[

				[0.1, 2, 10, 3, 0, 0.5, 1, 0],
				[0.1, 5, 10, 5, 0, 0.5, 1, 0],
				[0.1, 2, 20, 7, 0, 0.5, 1, 0],
				[0.1, 2, 30, 9, 0, 0.5, 1, 0]
			]
	]],
	[z ,
		[ 'wavPlayer',
			[
				['main_volume', 0.0, 2.0, 'linlin'],
				['speed', -1.0, 2.0, 'linlin'],
				['fine_speed', 0.90, 1.10, 'linlin'],
				['which', 0, 2, 'linlin'],
				['trigger_rate', 1, 20, 'linlin'],
				['bufnum', 0, 20, 'linlin'],
				['volume', 0.0, 2.0, 'linlin'],
				['pos', 0.0, 1.0, 'linlin'],
				['spread_speed', 0.0, 25, 'linlin'],
				['center_speed', 0.0, 25, 'linlin'],
				['orientation', -1.0, 1.0, 'linlin']

				],
			[

				[0.1, 2, 10, 3, 0, 0.5, 1, 0],
				[0.1, 5, 10, 5, 0, 0.5, 1, 0],
				[0.1, 2, 20, 7, 0, 0.5, 1, 0],
				[0.1, 2, 30, 9, 0, 0.5, 1, 0]
			]
	]],

[z,
		['sina',
			[
				['volume', 0, 10, 'linlin'],
					['which', 0, 3, 'linlin'],

				['deviation', 0.1, 400, 'explin'],
				['fine_dev', 0.8, 1.2, 'linlin'],

				['transp', 0.1, 4.0, 'linlin'],
				['range_min', 0, 300, 'linlin'],
				['range_max', 10, 500, 'explin'],
				['lfo_speed', 0.1, 3.0, 'linlin'],
				['spread_speed', 0.0, 25, 'linlin'],
				['center_speed', 0.0, 25, 'linlin'],
				['orientation', -1.0, 1.0, 'linlin']
			]
	]]
	,

		[z,
		['rhythm',// harmMod
			[
				['volume', 0.0, 5.0, 'linlin'],
				['freq_min', 40, 10000, 'linlin'],
				['freq_max', 100, 20000, 'linlin'],
				['speed', 1, 17, 'linlin'],
				['lpf_mul_freq', 1, 16, 'linlin'],
				['transpose', 0.1, 4, 'linlin'],
				['release', 0.01, 8, 'linlin'],
				['mul_noise', 0.0, 2.0, 'linlin'],
				['mul_sin', 0.0, 2.0, 'linlin'],
				['spread_speed', 0.0, 25, 'linlin'],
				['center_speed', 0.0, 25, 'linlin'],
				['orientation', -1.0, 1.0, 'linlin']
			]
	]]
	,



	[z,
		['pulse',
			[
				['volume', 0, 3.0, 'linlin'],
				['freq', 80, 150, 'linexp'],
				['freq_fine', 0.0, 1.0, 'linexp'],
				['delayTime', 0.015, 0.8, 'linexp'],
				['mul_imp', 0.0, 1.5, 'linlin'],
				['mul_click', 0.0, 1.5, 'linlin'],
				['decay_imp',  0.01, 2.0, 'linexp'],
				['hpf_freq', 60, 120, 'linexp'],
				['hpf_freq2', 0.1, 1000, 'linexp']

			]
	]]


];

)
