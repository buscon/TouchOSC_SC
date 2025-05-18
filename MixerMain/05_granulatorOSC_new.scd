//OSCdef.freeAll
//~buf_to_gran
(
~gran_parameters[0].size.do({|gran_index|
	~gran_parameters[1].size.do({|rotary_index|

		OSCdef.new(
			("rotary"++gran_index.asString++rotary_index.asString++~gran_parameters[1][rotary_index][0]).asString,
			{

				arg msg;
				var value = msg[1];
				if(~gran_parameters[1][rotary_index][3] == 'linlin',
					{value = value.linlin(0, 1, ~gran_parameters[1][rotary_index][1], ~gran_parameters[1][rotary_index][2]); },
					{value = value.linexp(0, 1, ~gran_parameters[1][rotary_index][1], ~gran_parameters[1][rotary_index][2]); };
				);
				~gran_parameters[0][gran_index].set(~gran_parameters[1][rotary_index][0], value);
				~adrs_granulator.sendMsg('/3/slabel'++(rotary_index+1), value.round(0.01));
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
				~adrs_granulator.sendMsg('/3/rotary'++(rotary_index+1), ~gran_parameters[1][rotary_index][4].linlin(~gran_parameters[1][rotary_index][1], ~gran_parameters[1][rotary_index][2], 0, 1 ));
				~adrs_granulator.sendMsg('/3/slabel'++(rotary_index+1), ~gran_parameters[1][rotary_index][4]);
				});

			},
			('/3/defaults'++(rotary_index+1).asString),
			nil,
			~osc_port
		);



			~adrs_granulator.sendMsg('/3/tlabel'++(rotary_index+1).asString, ~gran_parameters[1][rotary_index][0].asString);
		~gran_parameters[0][gran_index].get(~gran_parameters[1][rotary_index][0], { arg value;
			~adrs_granulator.sendMsg(('/3/rotary'++(rotary_index+1).asString), value.linlin(~gran_parameters[1][rotary_index][1], ~gran_parameters[1][rotary_index][2], 0, 1));
			~adrs_granulator.sendMsg('/3/slabel'++(rotary_index+1), value.round(0.01));
		});

	});

	});

);


(
~buf_to_gran.size.do({ |buf_i|
	var row_index, mbuf_i;
	mbuf_i = (buf_i % 4.0) + 1;
	row_index = (buf_i / 4.0).trunc(1) + 1;
	("mbuf_i: "++mbuf_i++" row_index: "++row_index).postln;
	OSCdef.new(
	"copiedBuf_"++buf_i,
	{
		arg msg, time, addr, port;
		var value = msg[1];
			if(value == 0, {
				~gran_parameters[0][0].set(\bufNum, ~buf_to_gran[buf_i].postln);
			});
			// for plotting the wave on the touchosc multifader, not working at the moment
//~buf_to_gran[buf_i].loadToFloatArray(action:{arg array; ~waveToPlot = array.resamp0(64); });
//			64.do({ arg frame; 	~adrs_granulator.sendMsg('/3/multifader1/'++frame, 0); 	~adrs_granulator.sendMsg('/3/multifader3/'++frame, 0); });

// clean the 4 multifaders
			/*
128.do({ arg frame;
	4.do({arg mf;
			~adrs_granulator.sendMsg('/3/multifader'++(mf+1)++'/'++frame, 0);
	});
});+
			*/

// resample the buffer into a 128 frames array
~buf_to_gran[buf_i.postln].loadToFloatArray(action:{arg array;
				~waveToPlot = array.resamp0(128);
        "done".postln;
			});
/*
// send the array to the 4 multifaders
128.do({ arg frame; var val, osc_msg, mf = 1, mf2 = 3;
	val = ~waveToPlot[frame];
	if(frame >64, { mf = 2; mf2 = 4; frame = frame - 64});

	if(val >0, {
		osc_msg = '/3/multifader'++mf++'/'++frame;
	~adrs_granulator.sendMsg(osc_msg, val);
		}, {
		osc_msg = '/3/multifader'++mf2++'/'++frame;
	~adrs_granulator.sendMsg(osc_msg, val);
	});
*/
	},
		('/3/multitoggle1/'++(mbuf_i)++'/'++row_index),
		nil,
		~osc_port
	);
});

~copiedBuf_to_gran.size.do({ |buf_i|
	var row_index, mbuf_i;
	// i called it row but it is actually a column, starting from the buttom
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
		('/3/multitoggle2/'++(mbuf_i)++'/'++row_index).postln,
		nil,
		~osc_port
	);
});

);
/*
(
~copiedBuf_to_gran.size.do({ |buf_i|
	var row_index, mbuf_i;
	mbuf_i = (buf_i % 5.0) + 1;
	row_index = (buf_i / 5.0).trunc(1) + 1;
mbuf_i.postln;
	 row_index.postln;
~copiedBuf_to_gran[buf_i].postln;
		('/3/multitoggle2/'++(mbuf_i)++'/'++row_index).postln;

});
)
*/

