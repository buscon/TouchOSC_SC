

OSCFunc.trace(false);
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
	\buf1,
	{
		arg msg, time, addr, port;
		msg.postln;
		~granulator.set(\bufNum, ~gbuf1);
	},
	'/3/multitoggle1/1/1',
	nil,
	osc_port
);
OSCdef.new(
	\buf2,
	{
		arg msg, time, addr, port;
		msg.postln;
		~granulator.set(\bufNum, ~gbuf2);
	},
	'/3/multitoggle1/2/1',
	nil,
	osc_port
);
OSCdef.new(
	\buf3,
	{
		arg msg, time, addr, port;
		msg.postln;
		~granulator.set(\bufNum, ~gbuf3);
	},
	'/3/multitoggle1/3/1',
	nil,
	osc_port
);
OSCdef.new(
	\buf4,
	{
		arg msg, time, addr, port;
		msg.postln;
		~granulator.set(\bufNum, ~gbuf4);
	},
	'/3/multitoggle1/4/1',
	nil,
	osc_port
);
OSCdef.new(
	\buf21,
	{
		arg msg, time, addr, port;
		msg.postln;
		~granulator.set(\bufNum, ~buf2);
	},
	'/3/multitoggle1/1/2',
	nil,
	osc_port
);
OSCdef.new(
	\buf22,
	{
		arg msg, time, addr, port;
		msg.postln;
		~granulator.set(\bufNum, ~buf4);
	},
	'/3/multitoggle1/2/2',
	nil,
	osc_port
);

OSCdef.new(
	\buf,
	{
		arg msg, time, addr, port;
		msg.postln;
		~granulator.set(\bufNum, ~gbuf4);
	},
	'/3/multitoggle1/4/1',
	nil,
	osc_port
);
OSCdef.new(
	\trigRate,
	{
		arg msg, time, addr, port;
		~granulator.set(\trigRate, msg[1].linlin(0, 1, 1, 100) );
	},
	'/3/rotary1',
	nil,
	osc_port
);
OSCdef.new(
	\amtRnd,
	{
		arg msg, time, addr, port;
		//msg[1].postln;
		~granulator.set(\amtRnd, msg[1] );
	},
	'/3/rotary2',
	nil,
	osc_port
);
OSCdef.new(
	\LFORnd,
	{
		arg msg, time, addr, port;
		//msg[1].postln;
		~granulator.set(\lfoR, msg[1].linlin(0, 1, 1, 50) );
	},
	'/3/rotary3',
	nil,
	osc_port
);

OSCdef.new(
	\AMVol,
	{
		arg msg, time, addr, port;
		//msg[1].postln;
		~granulator.set(\amVol, msg[1] );
	},
	'/3/rotary4',
	nil,
	osc_port
);

OSCdef.new(
	\AMFreq,
	{
		arg msg, time, addr, port;
		//msg[1].postln;
		~granulator.set(\amFreq, msg[1].linlin(0, 1, 20, 15000) );
	},
	'/3/rotary5',
	nil,
	osc_port
);

OSCdef.new(
	\rate,
	{
		arg msg, time, addr, port;
		//msg[1].postln;
		~granulator.set(\rate, msg[1].linlin(0, 1, -1.0, 2.0).postln );
	},
	'/3/rotary6',
	nil,
	osc_port
);

OSCdef.new(
	\rate_default,
	{
		arg msg, time, addr, port;
		//msg[1].postln;
		~granulator.set(\rate, 1 );
		adrs.sendMsg('/3/rotary6', 1.linlin(-1.0, 2.0, 0, 1).postln);

	},
	'/3/push1',
	nil,
	osc_port
);
OSCdef.new(
	\volume,
	{
		arg msg, time, addr, port;
		//msg[1].postln;
		~granulator.set(\volume, msg[1] );
	},
	'/3/fader1',
	nil,
	osc_port
);
/*
OSCdef.new(
	\drywet,
	{
		arg msg, time, addr, port;
		//msg[1].postln;
		~granulator.set(\drywet, msg[1].linlin(0, 1, -1.0, 1.0).postln );
	},
	'/3/rotary7'
);
*/
OSCdef.new(
	\pos,
	{
		arg msg, time, addr, port;
		//msg[1].postln;
		~granulator.set(\pos, msg[1] );
	},
	'/3/rotary8',
	nil,
	osc_port
);
)
