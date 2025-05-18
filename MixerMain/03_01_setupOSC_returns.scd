/*
~parameters_returns.size.do({ |synth_i|
	~adrs.sendMsg(('/1/vlabel'++(synth_i+1)).postln, "");

	//~parameters_returns[synth_i][0].free;
	//	~parameters_returns[synth_i].put(0, '');

});

28.do({ |i|
	~adrs.sendMsg('/1/label'++(i+1).asString, "");
	~adrs.sendMsg('/1/slabel'++(i+1).asString, "");
	~adrs.sendMsg('/1/rotary'++(i+1).asString, 0);
});
*/

~parameters_returns.size.do({ |synth_index|
	var synth_name, synth_parameters, instance_name, current_value;

	instance_name = ~parameters_returns[synth_index][0];
	synth_name = ~parameters_returns[synth_index][1][0];
	synth_parameters = ~parameters_returns[synth_index][1][1];

	//~parameters_returns[synth_index].put(0, Synth(synth_name)); We do it in the mixer

	~adrs_returns.sendMsg('/1/vlabel'++(synth_index+1), synth_name);

	synth_parameters.size.do({ |oscdef_index|
		var osc_index;
		osc_index = oscdef_index + (synth_index * 7);
		OSCdef.new(
				synth_name++synth_parameters[oscdef_index][0],
				{
					arg msg;
					var value = msg[1];
					value = value.linlin(0, 1, synth_parameters[oscdef_index][1], synth_parameters[oscdef_index][2]);
					~parameters_returns[synth_index][0].set(synth_parameters[oscdef_index][0], value);
					~adrs_returns.sendMsg('/1/slabel'++(osc_index+1), value.round(0.01));

			},
			('/1/rotary'++(osc_index+1).asString),
			nil,
			~osc_port
		);

		~adrs_returns.sendMsg('/1/label'++(osc_index+1), synth_parameters[oscdef_index][0]);

		~parameters_returns[synth_index][0].get(~parameters_returns[synth_index][1][1][oscdef_index][0], { arg value;  ~adrs_returns.sendMsg('/1/rotary'++(osc_index+1), value.linlin(~parameters_returns[synth_index][1][1][oscdef_index][1], ~parameters_returns[synth_index][1][1][oscdef_index][2], 0, 1));
				~adrs_returns.sendMsg('/1/slabel'++(osc_index+1), value.round(0.01));

		});
	});
};
	);
