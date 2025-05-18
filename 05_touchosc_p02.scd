(
var adrs = NetAddr("192.168.0.102", 9000),
osc_port = 5000;
adrs.sendMsg('/3/rotary1', 0);
adrs.sendMsg('/3/rotary2', 0);
adrs.sendMsg('/3/rotary3', 0);
adrs.sendMsg('/3/rotary4', 0);
adrs.sendMsg('/3/rotary5', 0);
adrs.sendMsg('/3/rotary6', 0);
adrs.sendMsg('/3/rotary7', 0);
adrs.sendMsg('/3/rotary8', 0);


OSCdef.new(
	\modAmp,
	{
		arg msg, time, addr, port;
		var value = msg[1];
		~glitch.set(\modAmp, value.linlin(0, 1, 20000, 200000));
	},
	'/2/fader2',
	nil,
	osc_port
);

OSCdef.new(
	\volume,
	{
		arg msg, time, addr, port;
		var value = msg[1];
		~glitch.set(\master_volume, value);
	},
	'/2/fader3',
	nil,
	osc_port
);
OSCdef.new(
	\modF,
	{
		arg msg, time, addr, port;
		var value ;
		value = msg[1];
		~glitch.set(\modF, value.linlin(0.0, 1, 0, 8));
	},
	'/2/rotary3',
	nil,
	osc_port
);
OSCdef.new(
	\modC,
	{
		arg msg, time, addr, port;
		var value ;
		value = msg[1];
			~glitch.set(\modC, value.linexp(0.001, 1, 0.001, 1.0).postln);
	},
	'/2/rotary4',
	nil,
	osc_port
);
OSCdef.new(
	\shiftBins,
	{
		arg msg, time, addr, port;
		var value ;
		value = msg[1];
				~glitch.set(\shiftBins, value.linlin(0, 1, 0.0, 1.0));
	},
	'/2/rotary5',
	nil,
	osc_port
);

OSCdef.new(
	\stretchBins,
	{
		arg msg, time, addr, port;
		var value ;
		value = msg[1];
		~glitch.set(\stretchBins, value.linlin(0, 1, 0.7, 1.0));
	},
	'/2/rotary6',
	nil,
	osc_port
);

OSCdef.new(
	\volumeChain,
	{
		arg msg, time, addr, port;
		var value ;
		value = msg[1];
		~glitch.set(\volumeChain, value.linlin(0, 1, 2, 7.5));
	},
	'/2/rotary8',
	nil,
	osc_port
);
)