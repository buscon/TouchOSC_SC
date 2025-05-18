

// function that choose the selected synth from the bottom row with the push buttons
// it takes as argument the synth and set the parameters of the interface
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
				var value = msg[1];
				instance_name.set(synth_parameters[oscdef_index][0], value.linlin(0, 1, synth_parameters[oscdef_index][1], synth_parameters[oscdef_index][2]));

				~adrs.sendMsg('/2/slabel'++(oscdef_index+1),value.linlin(0, 1, synth_parameters[oscdef_index][1], synth_parameters[oscdef_index][2]).round(0.01));

			},
			('/2/rotary'++(oscdef_index+1).asString),
			nil,
			~osc_port
		);
		// set the text of every single rotary
		~adrs.sendMsg('/2/text'++(oscdef_index+1).asString, synth_parameters[oscdef_index][0].asString);
		// create an osc receiver for every rotary
		~parameters[synth_index][0].get(~parameters[synth_index][1][1][oscdef_index][0], { arg value;
			~adrs.sendMsg('/2/rotary'++(oscdef_index+1).asString, value.linlin(~parameters[synth_index][1][1][oscdef_index][1], ~parameters[synth_index][1][1][oscdef_index][2], 0, 1));
			~adrs.sendMsg('/2/slabel'++(oscdef_index+1), value.round(0.01));

		});

	});
	~synth_index_latest = synth_index.asInt;
};

// create an osc receiver for every preset
~choose_preset = {|synth_index|
	var  synth_name;
	synth_name = ~parameters[synth_index][1][0];
	("last_synth_preset begin: "++~synth_index_latest_preset).postln;
	/*
	if(~synth_index_latest_preset != nil, {
		~parameters[~synth_index_latest_preset][1][1].size.do({ |i|
			("free: "++"preset"++~parameters[~synth_index_latest_preset][1][0]++(i).asString).postln;
			OSCdef(("preset"++~parameters[~synth_index_latest_preset][1][0]++(i).asString).asString).free;
		});
	});

	10.do({ |i|
		OSCdef(("preset"++(i).asString).postln).free;
	});
	*/

	~parameters[synth_index][1][2].size.do({ |preset_index|
		//("preset number: "++preset_index).postln;

		//("synth_index: "++synth_index).postln;
		("creating: "++"preset"++synth_name++(preset_index).asString).postln;

		OSCdef.new(
			// name of the OSCdef with the synthname ("preset"++synth_name++(preset_index).asString).asString,
			("preset"++(preset_index).asString).asString,
			{
				arg msg;
				var value = msg[1].asInt;
				//msg.postln;
				if(value == 1, {
					~parameters[synth_index][1][1].size.do({ |parameter|
						var preset_val;
						preset_val = ~parameters[synth_index][1][2][preset_index][parameter];

						//("parameter: "++~parameters[synth_index][1][1][0]++" - "++preset_val).postln;

						~parameters[synth_index][0].set(	~parameters[synth_index][1][1][parameter][0],						preset_val		);
						~adrs.sendMsg('/2/slabel'++(parameter+1), preset_val);
						~adrs.sendMsg('/2/rotary'++(parameter+1).asString, preset_val.linlin(~parameters[synth_index][1][1][parameter][1], ~parameters[synth_index][1][1][parameter][2], 0, 1));

					});
				});

			},
			('/2/preset/'++(preset_index+1).asString++'/1'),
			nil,
			~osc_port
		);
		~synth_index_latest_preset = synth_index.asInt;
		("last_synth_preset end: "++~synth_index_latest_preset).postln;
	});
};
~parameters.size.do({ |oscdef_index|
	~adrs.sendMsg('/2/label'++(oscdef_index+1).asString, ~parameters[oscdef_index][1][0]);
	//("oscdef_index: "++oscdef_index).postln;
	OSCdef.new(
		\instrument++(oscdef_index+1).asString,
		{
			arg msg;

			var value = ("value: " ++ msg[1]);
			if(value != 0, {
				("pressed push: "++oscdef_index).postln;

				~synth_choose.value(oscdef_index);
				~choose_preset.value(oscdef_index);
			});
		},
		'/2/push'++(oscdef_index+1).asString,
		nil,
		~osc_port
	);
});


~parameters_returns.size.do({ |synth_index|
	var synth_name, synth_parameters, instance_name, current_value;

	instance_name = ~parameters_returns[synth_index][0];
	synth_name = ~parameters_returns[synth_index][1][0];
	synth_parameters = ~parameters_returns[synth_index][1][1];

	//~parameters_returns[synth_index].put(0, Synth(synth_name)); We do it in the mixer

	~adrs.sendMsg('/1/vlabel'++(synth_index+1), synth_name);

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
				~adrs.sendMsg('/1/slabel'++(osc_index+1).asString, value.round(0.00));

			},
			('/1/rotary'++(osc_index+1).asString),
			nil,
			~osc_port
		);

		~adrs.sendMsg('/1/label'++(osc_index+1), synth_parameters[oscdef_index][0]);

		~parameters_returns[synth_index][0].get(~parameters_returns[synth_index][1][1][oscdef_index][0], { arg value;  ~adrs.sendMsg('/1/rotary'++(osc_index+1), value.linlin(~parameters_returns[synth_index][1][1][oscdef_index][1], ~parameters_returns[synth_index][1][1][oscdef_index][2], 0, 1));
			~adrs.sendMsg('/1/slabel'++(osc_index+1), value);

		});
	});
};
);
