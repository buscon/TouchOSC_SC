[~chan, ~chan2, ~chan3, ~rvbmc, ~chorusC, ~master].do(_.free);

(
MixerChannelGUI.defaultDef = MixerGUIDef(Point(100, 600),
	[MixerMuteWidget, MixerRecordWidget, MixerPresendWidget, MixerPanWidget,
		MixerLevelSlider, MixerLevelNumber, MixerPostsendWidget, MixerPostsendWidget,  MixerNameWidget,
		MixerOutbusWidget],
	[Rect(0, 0, 50, 50), Rect(30, 0, 50, 50), Rect(0, 60, 100, 50), Rect(0, 210, 50, 15),
		Rect(10, 85, 30, 100), Rect(0, 190, 50, 15), Rect(0, 210, 50, 30), Rect(0, 110, 50, 30),
		Rect(0, 245, 50, 20), Rect(0, 270, 50, 20)]);


~master = MixerChannel(\master, s, 2, 2, level:1);

~chan = MixerChannel(\blippy, s, 2, 2, outbus:~master, postSendReady:true);
~chan2 = MixerChannel.new("pinkfilt", s, 2, 2, outbus:~master, postSendReady:true);  // defaults to mono-to-stereo
~chan3 = MixerChannel.new("harmMod", s, 2, 2, outbus:~master, postSendReady:true);  // defaults to mono-to-stereo


~rvbmc = MixerChannel.new("chn rvb", s, 2, 2);
~chorusC = MixerChannel.new("chn ch", s, 2, 2);


~dlysynth = ~chan.playfx(\blipDelay, [\bufnum, ~dlybuf.bufnum, outbus:~master, \t_repan, 1]);
~dlysynth2 = ~chan2.playfx(\blipDelay, [\bufnum, ~dlybuf.bufnum, outbus:~master,\t_repan, 1]);
~dlysynth3 = ~chan3.playfx(\blipDelay, [\bufnum, ~dlybuf.bufnum, outbus:~master,\t_repan, 1]);


~rvb = ~rvbmc.playfx({ |out|
   var numChan, maxDelay, preDelay, decay, numRefl, random;
   var sig, new, dlys;
   #numChan, maxDelay, preDelay, decay, numRefl, random = #[2, 0.181, 0.08, 4, 8, 0.1];
   sig = In.ar(out, numChan);
   new = sig;
   dlys = Array.fill(numRefl, {
      new = AllpassN.ar(new, maxDelay,
         Array.fill(numChan, { random.rand }) + preDelay, decay);
   });
   Mix.ar(dlys * Array.series(numRefl, 1, (numRefl+1).reciprocal.neg))
});

~chr = ~chorusC.playfx("fx/chorus1x1");


~chan2_s = ~chan2.play(\pinkfilt, [\freq, 2000, \rq, 0.02]);
~chan3_s = ~chan3.play(\harmMod, [\carrier, 10, \harm, 6, \bright, 3, \volume, 0.1]);
//r.play;
)
~send = ~chan.newPostSend(~rvbmc, 0.41);
~send2 = ~chan.newPostSend(~chorusC, 0);
~send3 = ~chan3.newPostSend(~rvbmc, 0.41);

~send.level = 0;
~send2.level = 0;

~board = MixingBoard("demo", nil, ~chan, ~chan2, ~chan3, ~rvbmc, ~chorusC, ~master);
~master.scope;
~send = ~chan2.newPostSend(~rvbmc, 0);