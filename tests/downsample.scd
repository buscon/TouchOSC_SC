
~wave =  Wavetable.chebyFill(512, [1]);
~waveBuf = Signal.sineFill(1024, Array.fill(200, {0}).add(1));
~waveBuf.sendCollection(~wave.asWavetableNoWrap);
~waveToPlot = ~waveBuf.resamp1(64);
~waveToPlot[2]
~waveBuf.get(0, {|msg| msg.postln});
~buf_to_gran[0].plot
(
~waveToPlot = ~waveBuf.resamp0(64);
64.do({ arg frame; var val, osc_msg;
	val = ~waveToPlot[frame];
	if(val >0, {
		osc_msg = '/3/multifader1/'++frame;
	~adrs_granulator.sendMsg(osc_msg.postln, val.postln).asString;
		}, {
		osc_msg = '/3/multifader3/'++frame;
	~adrs_granulator.sendMsg(osc_msg, val).asString.postln;
	});
});
)

	~adrs_granulator.sendMsg('/3/multifader1/2', 0.5).asString.postln;


	~adrs_granulator.sendMsg('/3/multifader3/'++frame++'/'++msg).asString, ~gran_parameters[1][rotary_index][0].asString);
(~waveBuf.numFrames / 16).plot
~waveBuf.plot
~waveBuf.getMsg(2)
(16/~waveBuf)

Env.perc.plot
Env.perc.at(0.5)
b.plot
~waveBuf.get(32.linlin(0, 64, 0, ~waveBuf.numFrames), {|msg| msg.postln});
~waveBuf.getn(~waveBuf.numFrames.rand(), 16, {|msg| msg.postln});
~waveBuf.getn(7, 16, {|msg| (msg.sum/16).postln});
~waveBuf.getn(5, 16, {|msg| ~l.add(msg)});
~l
~l.size
~waveBuf
collect
~waveBuf.getn()
~l = Array.new();
(
v = Signal.sineFill(128, 1.0/[1,2,3,4,5,6]);
b = Buffer.alloc(s, 128);
)
c = Buffer.alloc(s, 64);
Latch
c.copyData(~waveBuf, numSamples: 64);
c.plot
Buffer.asString
64.do({ arg frame; var val = 0, res; b.getn(frame.postln, b.numFrames/64, {|msg| val = (msg.sum/16).postln;});  });
[1,2,3].sum
~buf_to_gran
~buf_to_gran[1].asArray.resamp0(64)
~buf_to_gran[10].plot
~buf_to_gran[8].plot
~waveToPlot = ~buf_to_gran[0].getToFloatArray;
~waveToPlot[6]
~waveToPlot.plot
~adrs_granulator.sendMsg('/3/multifader3/'++2, 0);
(
64.do({ arg frame;
	4.do({arg mf;
		~adrs_granulator.sendMsg(('/1/multifader'++(mf+1)++'/'++frame).postln, 0);
	});
});
)
Routine
r.stop;
r.play;
p.stop;
p.play;
~waveToPlot.plot
(
~buf_to_gran[10].loadToFloatArray(action:{arg array; ~waveToPlot = array.resamp0(256); });
)
(
64.do({ arg frame; var val, osc_msg, mf = 1, mf2 = 3;
	val = ~waveToPlot[frame];
	//if(frame >64, { mf = 2; mf2 = 4; frame = frame - 64});

	if(val >0, {
		osc_msg = '/1/multifader'++mf++'/'++frame;
	~adrs_granulator.sendMsg(osc_msg, val);
		}, {
		osc_msg = '/1/multifader'++mf2++'/'++frame;
	~adrs_granulator.sendMsg(osc_msg.postln, val.postln);
	});
});
)
254/64
(254/64).floor() +1
128+64+64
256/4
var frame = 1;frame - (64 * (frame%4))
(
256.do({ arg frame; var val, osc_msg, fader, mf;
	val = ~waveToPlot[frame];

	fader = frame%64;
	mf = (frame/64).floor+1;
	if(val >0, {
	osc_msg = '/1/multifader'++mf++'/'++fader;
	~adrs_granulator.sendMsg(osc_msg.postln, val.postln);
		}, {
			osc_msg = '/1/multifader'++(mf+4)++'/'++fader;
	~adrs_granulator.sendMsg(osc_msg.postln, val.postln);
	});

});
)