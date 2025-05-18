//OSCdef("z"++~parameters[0][1][1][0][0]).free;+
//OSCdef.freeAll;
~synth_choosexy = {|synth_index|

	var synth_name, synth_parameters, instance_name, current_value, counter = 0;

	//

	instance_name = ~parameters[synth_index][0];
	synth_name = ~parameters[synth_index][1][0];
	synth_parameters = ~parameters[synth_index][1][1];

	// free old OSCdef
	if(~synth_index_latest != nil, {
		~parameters[~synth_index_latest][1][1].size.do({ |i|
					if( i.odd, {

			OSCdef(("xy"++~parameters[~synth_index_latest][1][1][i][0]).asSymbol).free.post;
			" - free".postln;
			});

		});
		OSCdef(("z"++~parameters[~synth_index_latest][1][1][0][0]).asSymbol).free.post;
					" - free".postln;

	});
	 OSCdef.new(
		("z"++synth_parameters[0][0]).asSymbol,
			{
				arg msg;
				var value = msg[1];
			//msg.postln;

				value = value.linlin(0, 1, synth_parameters[0][1], synth_parameters[0][2]);

				instance_name.set(synth_parameters[0][0], value);
			(synth_parameters[0][0] ++ ": " ++ value);

			},
			'/8/multixy1/z',
			nil,
			~osc_port
		).postln;
	synth_parameters.size.do({ |oscdef_index|
		if( oscdef_index.odd, {
		var current_value;
			counter = counter+1;
	 OSCdef.new(
				("xy"++synth_parameters[oscdef_index][0]).asSymbol,
			{
				arg msg;
				var value = msg[1], value2 = msg[2];
				value = value.linlin(0, 1, synth_parameters[oscdef_index][1], synth_parameters[oscdef_index][2]);
				value2 = value2.linlin(0, 1, synth_parameters[oscdef_index+1][1], synth_parameters[oscdef_index+1][2]);

				instance_name.set(synth_parameters[oscdef_index][0], value);
				instance_name.set(synth_parameters[oscdef_index+1][0], value2);

			},
			('/8/multixy1/'++(counter).asString),
			nil,
			~osc_port
		).postln; // oscdef closed
		});// if closed

	});
	("synth_index_lastest: " ++ ~synth_index_latest).postln;

	"synth_index: ".post;
		~synth_index_latest = synth_index.asInt.postln;

};
/*
~parameters_xy = ~parameters ++ [~gran_parameters]
~parameters.size
~parameters_xy.size
~parameters_xy[3]
[~gran_parameters][0]
~parameters[0]
*/
~parameters.size.do({ |oscdef_index|

	~adrs_xy.sendMsg(('/8/label'++(oscdef_index+1)).asString, ~parameters[oscdef_index][1][0]);

	OSCdef.new(
		\instrumentxy++(oscdef_index+1).asString,
		{
			arg msg;

			var value = ("value: " ++ msg[1]);
			if(value != 0, {~synth_choosexy.value(oscdef_index)});
		},
		'/8/push'++(oscdef_index+1).asString,
		nil,
		~osc_port
	);

});
/*
~parameters
~gran_parameters[1][1]
~gran_parameters[1].size.do({ |oscdef_index|
	~adrs_xy.sendMsg(('/8/label6', 'granulator');

	OSCdef.new(
		\instrumentxyg++(oscdef_index+1).asString,
		{
			arg msg;

			var value = ("value: " ++ msg[1]);
			if(value != 0, {~synth_choosexy.value(oscdef_index)});
		},
		'/8/push'++(oscdef_index+1).asString,
		nil,
		~osc_port
	);

});
*/