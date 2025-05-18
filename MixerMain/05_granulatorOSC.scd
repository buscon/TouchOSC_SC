
(
~gran_parameters[0].size.do({|gran_index|
	~gran_parameters[1].size.do({|rotary_index|

		OSCdef.new(
			("rotary"++gran_index.asString++rotary_index.asString++~gran_parameters[1][rotary_index][0]).asString,
			{

				arg msg;
				var value = msg[1];
				value = value.linlin(0, 1, ~gran_parameters[1][rotary_index][1], ~gran_parameters[1][rotary_index][2]);
				~gran_parameters[0][gran_index].set(~gran_parameters[1][rotary_index][0], value);
				~adrs.sendMsg('/3/slabel'++(rotary_index+1), value.round(0.01));
			},
			('/3/rotary'++(rotary_index+1).asString),
			nil,
			~osc_port
		);

				OSCdef.new(
			("defbutton"++gran_index.asString++rotary_index.asString++~gran_parameters[1][rotary_index][0]).asString,
			{

				arg msg;
				var value = msg[1];
				if(value == 1,{
				~gran_parameters[0][gran_index].set(~gran_parameters[1][rotary_index][0], ~gran_parameters[1][rotary_index][4]);
				~adrs.sendMsg('/3/rotary'++(rotary_index+1), ~gran_parameters[1][rotary_index][4].linlin(~gran_parameters[1][rotary_index][1], ~gran_parameters[1][rotary_index][2], 0, 1 ));
				~adrs.sendMsg('/3/slabel'++(rotary_index+1), ~gran_parameters[1][rotary_index][4]);
				});

			},
			('/3/defaults'++(rotary_index+1).asString),
			nil,
			~osc_port
		);



			~adrs.sendMsg('/3/tlabel'++(rotary_index+1).asString, ~gran_parameters[1][rotary_index][0].asString);
		~gran_parameters[0][gran_index].get(~gran_parameters[1][rotary_index][0], { arg value;
			~adrs.sendMsg(('/3/rotary'++(rotary_index+1).asString), value.linlin(~gran_parameters[1][rotary_index][1], ~gran_parameters[1][rotary_index][2], 0, 1));
			~adrs.sendMsg('/3/slabel'++(rotary_index+1), value.round(0.01));
		});

	});

	});

);



(
~buf_to_gran.size.do({ |buf_i|
	OSCdef.new(
	"copiedBuf_"++buf_i,
	{
		arg msg, time, addr, port;
		var value = msg[1];
			if(value == 0, {
				~gran_parameters[0][0].set(\bufNum, ~buf_to_gran[buf_i].postln);
			});
	},
		('/3/multitoggle1/'++(buf_i+1)++'/1'),
		nil,
		~osc_port
	);
});

~copiedBuf_to_gran.size.do({ |buf_i|
	var row_index, mbuf_i;
	mbuf_i = (buf_i % 4.0) + 1;
	row_index = (buf_i / 4.0).trunc(1) + 1;
//mbuf_i.postln;
	 //row_index.postln;
	OSCdef.new(
	"copiedBuf_"++buf_i,
	{
		arg msg, time, addr, port;
		var value = msg[1];
			if(value == 0, {
				//buf_i.postln;
				~gran_parameters[0][0].set(\bufNum, ~copiedBuf_to_gran[buf_i].postln);
			});
	},
		('/3/multitoggle2/'++(mbuf_i)++'/'++row_index),
		nil,
		~osc_port
	);
});

);



