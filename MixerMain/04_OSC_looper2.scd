~looper_control = { arg looper, msg;
	x = case
	{ msg == 'play'} {
			looper.set(\loop_play, 1);
			looper.set(\loop_rec, 0);
			looper.set(\reclevel, 0);
			looper.set(\prelevel, 1);
	}
		{ msg == 'overdub'} {
			looper.set(\loop_play, 1);
			looper.set(\loop_rec, 1);
			looper.set(\reclevel, 0.5);
			looper.set(\prelevel, 0.5);
			looper.set(\trigger, 0);
			looper.set(\trigger, 1);
	}
		{ msg == 'rec'} {
			looper.set(\loop_play, 1);
			looper.set(\loop_rec, 1);
			looper.set(\reclevel, 1);
			looper.set(\prelevel, 0);
			looper.set(\trigger, 0);
			looper.set(\trigger, 1);
	}
	{ msg == 'stop'} {
			looper.set(\loop_play, 0);
			looper.set(\loop_rec, 0);
	};
};
~looper_parameters.size.do({|looper_index|
	var page_index = 5;
	if(looper_index > 1 ,{ page_index = 6}, {page_index = 5});
	~looper_controls_values.size.do({|command_index|
		//Multitoggle
		OSCdef.new(
			("multit"++looper_index.asString++command_index.asString++~looper_controls_values[command_index][0]).asString,
			{
				arg msg;
				var value = msg[1];
				if(value == 1, {
					~looper_control.value(~looper_parameters[looper_index][0], ~looper_controls_values[command_index][0].postln);
				});
			},
			('/'++page_index++'/multitoggle'++(looper_index+1)++'/1/'++(command_index+1).asString),
			nil,
			~osc_port
		);

		});

	~looper_parameters[looper_index][1][1].size.do({|rotary_index|
		var row_index = (looper_index * ~looper_parameters[looper_index][1][1].size
) + 1 + rotary_index;
		OSCdef.new(
			("rotary"++looper_index.asString++rotary_index.asString++~looper_parameters[looper_index][1][1][rotary_index][0]).asString,
			{

				arg msg;
				var value = msg[1].postln;
				value = value.linlin(0, 1, ~looper_parameters[looper_index][1][1][rotary_index][1], ~looper_parameters[looper_index][1][1][rotary_index][2]);
				~looper_parameters[looper_index][0].set(~looper_parameters[looper_index][1][1][rotary_index][0], value);
				~adrs_looper.sendMsg(('/'++page_index++'/slabel'++(row_index)), value.round(0.01));
			},
			('/'++page_index++'/rotary'++(row_index).asString),
			nil,
			~osc_port
		);
		"--".postln;
		~looper_parameters[looper_index][1][1][rotary_index][0].postln;
				"--".postln;

				OSCdef.new(
			("defbutton"++looper_index.asString++rotary_index.asString++~looper_parameters[looper_index][1][1][rotary_index][0]).asString,
			{

				arg msg;
				var value = msg[1];
				if(value == 1,{
				~looper_parameters[looper_index][0].set(~looper_parameters[looper_index][1][1][rotary_index][0], ~looper_parameters[looper_index][1][1][rotary_index][4]);
				~adrs_looper.sendMsg('/'++page_index++'/rotary'++(row_index), ~looper_parameters[looper_index][1][1][rotary_index][4].linlin(~looper_parameters[looper_index][1][1][rotary_index][1], ~looper_parameters[looper_index][1][1][rotary_index][2], 0, 1 ));
				~adrs_looper.sendMsg('/'++page_index++'/slabel'++(row_index), ~looper_parameters[looper_index][1][1][rotary_index][4]);
				});

			},
			('/'++page_index++'/defaults'++(row_index).asString),
			nil,
			~osc_port
		);

		~adrs_looper.sendMsg('/'++page_index++'/tlabel'++(row_index).asString, ~looper_parameters[looper_index][1][1][rotary_index][0].asString);
/*
		~looper_parameters[looper_index][0].get(~looper_parameters[looper_index][1][1][rotary_index][0], { arg value;
			~adrs_looper.sendMsg(('/'++page_index++'/rotary'++(row_index).asString), value.linlin(~looper_parameters[looper_index][1][1][rotary_index][1], ~looper_parameters[looper_index][1][1][rotary_index][2], 0, 1));
			~adrs_looper.sendMsg('/'++page_index++'/slabel'++(row_index), value.round(0.01));
		});
		*/


	});


	(~buf_array.size/2).do({ |copybuf_index|
		var array_i = copybuf_index + (looper_index * 4);
		OSCdef.new(
			("copybuf"++copybuf_index).asString,
			{
				arg msg;
				var value = msg[1];
				//array_i.postln;
				if(value == 1,{
				~buf_array[array_i][0].copyData(~buf_array[array_i][1].postln);
				});
			},
			('/'++page_index++'/copybuf' ++ (looper_index + 1) ++ '/'++(copybuf_index+1)++'/1'),
			nil,
			~osc_port
		);

	});


});







