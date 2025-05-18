OSCFunc.trace(false);
(
OSCdef.new(\preset1, {|msg|
	msg.postln;

},('/2/preset/1/1').postln);
OSCdef.new(\preset2, {|msg|
	msg.postln;

},('/2/preset/2/1').postln);
)
OSCdef("presetglitch_sounds1").free;
OSCdef("presetglitch_sounds1",{});

OSCdef
(
	10.do({ |i|
					OSCdef(\preset++(i+1).asString).postln;
	});
)

OSCdef.freeAll

	10.do({ |i|
			OSCdef(\preset++(i).asString).postln;
	});