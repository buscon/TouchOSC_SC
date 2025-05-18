//['channelN', 'synth'
~mixer = Array.newClear(9);
~senda = Array.newClear(8);
~sendb = Array.newClear(8);
~sendc = Array.newClear(8);

[~mixer[0], ~mixer[1], ~mixer[2], ~mixer[3], ~mixer[4], ~mixer[5], ~mixer[6], ~mixer[7], ~return2, ~return2, ~return3, ~master].do(_.free);

~mixer[8] = MixerChannel(\master, s, ~num_channels, ~num_channels, level:1);

~mixer[0] = MixerChannel(\glitch_sounds, s, ~num_channels, ~num_channels, outbus:~mixer[8], postSendReady:true, level:0);
~mixer[1] = MixerChannel(\harmMod, s, ~num_channels, ~num_channels, outbus:~mixer[8], postSendReady:true, level:0);
~mixer[2] = MixerChannel(\dust_touch, s, ~num_channels, ~num_channels, outbus:~mixer[8], postSendReady:true, level:0);
~mixer[3] = MixerChannel(\granulator, s, ~num_channels, ~num_channels, outbus:~mixer[8], postSendReady:true, level:0);

~mixer[4] = MixerChannel(\looper2s, s, ~num_channels, ~num_channels, outbus:~mixer[8], postSendReady:true, level:0);
~mixer[5] = MixerChannel(\looper4s, s, ~num_channels, ~num_channels, outbus:~mixer[8], postSendReady:true, level:0);

~mixer[6] = MixerChannel(\looper22, s, ~num_channels, ~num_channels, outbus:~mixer[8], postSendReady:true, level:0);
~mixer[7] = MixerChannel(\looper44, s, ~num_channels, ~num_channels, outbus:~mixer[8], postSendReady:true, level:0);



~return1 = MixerChannel.new("chn rvb", s, ~num_channels, ~num_channels, outbus:~mixer[8]);
~return2 = MixerChannel.new("chn ch", s, ~num_channels, ~num_channels, outbus:~mixer[8]);
~return3 = MixerChannel.new("chn delay", s, ~num_channels, ~num_channels, outbus:~mixer[8]);

//~dlysynth = ~chan.playfx(\blipDelay, [\bufnum, ~dlybuf.bufnum, \t_repan, 1]);
~parameters_returns[0].put(0, ~return1.playfx(~parameters_returns[0][1][0]));
~parameters_returns[1].put(0, ~return2.playfx(~parameters_returns[1][1][0]));
~parameters_returns[2].put(0, ~return3.playfx(~parameters_returns[2][1][0]));
/*
~rvb = ~rvbmc.playfx(\GVerb);
~chr = ~return3.playfx(\chorus);
~del = ~return2.playfx(\delay);
*/

//~parameters[0].put(0, ~mixer[0].play(~parameters[0][1][0]));
~parameters[0].put(0, ~mixer[0].play(~parameters[0][1][0]));
//~parameters[2].put(0, ~mixer[2].play(~parameters[2][1][0]));
~parameters[1].put(0, ~mixer[1].play(~parameters[1][1][0]), [\buf, ~waveBuf]);
~parameters[2].put(0, ~mixer[2].play(~parameters[2][1][0]));


~gran_parameters[0][0] = ~mixer[5].play(\granulator, [\bufNum, ~gbuf3]);
~looper_parameters[0][0] = ~mixer[4].play(~looper_parameters[0][1][0], [\buf, ~buf2, \input_ch, ~input_ch1] );
~looper_parameters[1][0] = ~mixer[5].play(~looper_parameters[1][1][0], [\buf, ~buf4, \input_ch, ~input_ch2]);
~looper_parameters[2][0] = ~mixer[6].play(~looper_parameters[2][1][0], [\buf, ~buf21, \input_ch, ~input_ch1]);
~looper_parameters[3][0] = ~mixer[7].play(~looper_parameters[3][1][0], [\buf, ~buf41, \input_ch, ~input_ch2]);

//~looper_parameters[3][0].set(\input_ch, 1);
//PeakMonitor(~mixer[2]);


/*
~parameters.size.do({ |i|
	var synth_name;
	//~istance_name = ~parameters[synth_index][0];
	synth_name = ~parameters[i][1][0];
	~parameters[i].put(0, ~mixer[2].play(synth_name));
});
*/


8.do({ |i|
	~senda[i] = ~mixer[i].newPostSend(~return1, 0);
	~sendb[i] = ~mixer[i].newPostSend(~return2, 0);
	~sendc[i] = ~mixer[i].newPostSend(~return3, 0);
});


