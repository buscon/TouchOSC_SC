
~synth_choose = {|synth_index|

	var synth_name, synth_parameters, instance_name, current_value;
// clear all the texts
	15.do({ |i|
		~adrs.sendMsg('/2/text'++(i+1).asString, "");
		~adrs.sendMsg('/2/rotary'++(i+1).asString, 0);
	});

	// free old OSCdef
	if(~synth_index_latest != nil, {
		~parameters[~synth_index_latest][1][1].size.do({ |i|
			OSCdef(~parameters[~synth_index_latest][1][1][i][0]).free;
		});
	});

	instance_name = ~parameters[synth_index][0];
	synth_name = ~parameters[synth_index][1][0];
	synth_parameters = ~parameters[synth_index][1][1];

	synth_parameters.size.do({ |oscdef_index|
		var current_value;
	 OSCdef.new(
		synth_parameters[oscdef_index][0],
			{
				arg msg;
				var value = msg[1].postln;
				value = value.linlin(0, 1, synth_parameters[oscdef_index][1], synth_parameters[oscdef_index][2]);
				instance_name.set(synth_parameters[oscdef_index][0], value);
				~adrs.sendMsg('/2/slabel'++(oscdef_index+1), value.round(0.01));

			},
			('/2/rotary'++(oscdef_index+1).asString),
			nil,
			~osc_port
		);

	~adrs.sendMsg('/2/text'++(oscdef_index+1).asString, synth_parameters[oscdef_index][0].asString);
	~parameters[synth_index][0].get(~parameters[synth_index][1][1][oscdef_index][0], { arg value;
			~adrs.sendMsg('/2/rotary'++(oscdef_index+1).asString, value.linlin(~parameters[synth_index][1][1][oscdef_index][1], ~parameters[synth_index][1][1][oscdef_index][2], 0, 1));
			~adrs.sendMsg('/2/slabel'++(oscdef_index+1), value.round(0.01));


		});

	});
	~synth_index_latest = synth_index.asInt;
};
~parameters.size.do({ |oscdef_index|
	~adrs.sendMsg('/2/label'++(oscdef_index+1).asString, ~parameters[oscdef_index][1][0]);

	OSCdef.new(
		\instrument++(oscdef_index+1).asString,
		{
			arg msg;

			var value = ("value: " ++ msg[1]).postln;
			if(value != 0, {~synth_choose.value(oscdef_index)});
		},
		'/2/push'++(oscdef_index+1).asString,
		nil,
		~osc_port
	);
});
