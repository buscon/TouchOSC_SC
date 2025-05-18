// Execute the following in order
~buf2.free;
~buf4.free;
(
// allocate a Buffer
~buf2 = Buffer.alloc(s, s.sampleRate * 2.0, 2);
~buf4 = Buffer.alloc(s, s.sampleRate * 4.0, 2);

//~buf8 = Buffer.alloc(s, s.sampleRate * 8.0, 2);

)

// record for four seconds
(
SynthDef(\RecordBuf, { arg out = 0, bufnum = 0, loop = 0, recLevel = 1, preLevel = 1, trigger = 1;
    var sig;
	sig = SoundIn.ar([0,1]);
    RecordBuf.ar(sig, bufnum, 0, recLevel, preLevel, doneAction: 2, loop: loop, trigger: trigger);
}).add;

// play it back

SynthDef(\Play, { arg out = 0, bufnum = 0, loop = 1;
    var playbuf;
    playbuf = PlayBuf.ar(2,bufnum, loop);
    //FreeSelfWhenDone.kr(playbuf); // frees the synth when the PlayBuf is finished
    Out.ar(out, playbuf);
}).add;

// overdub

SynthDef(\Overdub, { arg out=0, bufnum=0, loop;
    var sig;
	sig = SoundIn.ar([0,1]);
    // mixes equally with existing data
    RecordBuf.ar(sig, bufnum, 0, 0.5, 0.5, doneAction: 2, loop: loop);
}).add;
)
r = Synth(\RecordBuf, [\bufnum, ~buf4, \loop, 1]);
//r = Synth(\Overdub, [\bufnum, ~buf4, \loop, 1]);
r.set(\trigger, 0);
r.set(\trigger, 1);

r.set(\recLevel, 1);
r.set(\preLevel, 0);

p = Synth(\Play, [\bufnum, ~buf4, \loop, 1]);

// play back the overdubbed version
Synth.new(\help_RecordBuf_overdub, [\out, 0, \bufnum, b], s);

// write the contents of the buffer to a file (see Buffer for more options)
(
b.write(sampleFormat: 'int16');
thisProcess.platform.recordingsDir +/+ "SC_" ++ Date.localtime.stamp ++ ".aiff"; // generated path
)

b.close; b.free; // cleanup