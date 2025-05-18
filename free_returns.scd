// clear all the texts
(
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

OSCdef.freeAll;

)