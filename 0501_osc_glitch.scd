(
~i1 = {

~adrs.sendMsg('/2/rotary1', 0);
~adrs.sendMsg('/2/text1', "Mod Ampa");

~adrs.sendMsg('/2/rotary2', 0);
~adrs.sendMsg('/2/text2', "Mod F");

~adrs.sendMsg('/2/rotary3', 0);
~adrs.sendMsg('/2/text3', "Mod C");

~adrs.sendMsg('/2/rotary4', 0);
~adrs.sendMsg('/2/text4', "Shift Bins");

~adrs.sendMsg('/2/rotary5', 0);
~adrs.sendMsg('/2/text5', "Stretch Bins");

~adrs.sendMsg('/2/rotary6', 0);
~adrs.sendMsg('/2/text6', "Vol Chain");


~adrs.sendMsg('/2/rotary7', 0);
~adrs.sendMsg('/2/rotary8', 0);

~adrs.sendMsg('/2/fader1', 0);
~adrs.sendMsg('/2/lfader1', "Vol");

OSCdef.new(
	\modAmp,
	{
		arg msg, time, addr, port;
		var value = msg[1];
		~glitch.set(\modAmp, value.linlin(0, 1, 20000, 200000));
	},
	'/2/rotary1',
	nil,
	~osc_port
);

OSCdef.new(
	\volume,
	{
		arg msg, time, addr, port;
		var value = msg[1];
		~glitch.set(\master_volume, value);
	},
	'/2/fader1',
	nil,
	~osc_port
);
OSCdef.new(
	\modF,
	{
		arg msg, time, addr, port;
		var value ;
		value = msg[1];
		~glitch.set(\modF, value.linlin(0.0, 1, 0, 8));
	},
	'/2/rotary2',
	nil,
	~osc_port
);
OSCdef.new(
	\modC,
	{
		arg msg, time, addr, port;
		var value ;
		value = msg[1];
			~glitch.set(\modC, value.linexp(0.001, 1, 0.001, 1.0).postln);
	},
	'/2/rotary3',
	nil,
	~osc_port
);
OSCdef.new(
	\shiftBins,
	{
		arg msg, time, addr, port;
		var value ;
		value = msg[1];
				~glitch.set(\shiftBins, value.linlin(0, 1, 0.0, 1.0));
	},
	'/2/rotary4',
	nil,
	~osc_port
);

OSCdef.new(
	\stretchBins,
	{
		arg msg, time, addr, port;
		var value ;
		value = msg[1];
		~glitch.set(\stretchBins, value.linlin(0, 1, 0.7, 1.0));
	},
	'/2/rotary5',
	nil,
	~osc_port
);

OSCdef.new(
	\volumeChain,
	{
		arg msg, time, addr, port;
		var value ;
		value = msg[1];
		~glitch.set(\volumeChain, value.linlin(0, 1, 2, 7.5));
	},
	'/2/rotary6',
	nil,
	~osc_port
);
};
)
~glitch=Synth(\glitch_sounds);
~i1.value;