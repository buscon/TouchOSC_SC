~mixer.size.do({ |chan_index|
	OSCdef.new(
		~mixer[chan_index].asString,
		{
					arg msg;
					var value = msg[1];
					~mixer[chan_index].level = value;
			},
			('/4/fader'++(chan_index+1).asString),
			nil,
			~osc_port
		);

	~adrs_mixer.sendMsg('/4/fader'++(chan_index+1).asString,
		~mixer[chan_index].level);

});

8.do({ |chan_index|
		OSCdef.new(
		~mixer[chan_index].asString,
		{
			arg msg;
			var value = msg[1];
			if( value == 1,{ ~mixer[chan_index].mute(true); }, { ~mixer[chan_index].mute(false);});
			},
			('/4/toggle'++(chan_index+1).asString),
			nil,
			~osc_port
		);

	~adrs_mixer.sendMsg('/4/fader'++(chan_index+1).asString, 0);
});

8.do({ |chan_index|
	OSCdef.new(
		("senda_"++~senda[chan_index]).asString,
		{
			arg msg;
			var value = msg[1];
					//"aaaaa".postln;

					//chan_index.postln;

		~senda[chan_index].level = value;
		},

		('/4/rotary'++(chan_index+1).asString),
		nil,
		~osc_port
	);

	~adrs_mixer.sendMsg('/4/rotary'++(chan_index+1).asString, 0);

});

8.do({ |chan_index|

	OSCdef.new(
		"sendb_"++~sendb[chan_index],
		{
			arg msg;
			var value = msg[1];

		chan_index;

	(chan_index+9);
		~sendb[chan_index].level = value;
		},
		('/4/rotary'++(chan_index+9).asString),
		nil,
		~osc_port
	);
	~adrs_mixer.sendMsg('/4/rotary'++(chan_index+9).asString, 0);
});

8.do({ |chan_index|
	OSCdef.new(
		"sendc_"++~sendc[chan_index],
		{
			arg msg;
			var value = msg[1];
					chan_index;

			(chan_index+17);
		~sendc[chan_index].level = value;
		},
		('/4/rotary'++(chan_index+17).asString),
		nil,
		~osc_port
	);
	~adrs_mixer.sendMsg('/4/rotary'++(chan_index+17).asString, 0);
});
