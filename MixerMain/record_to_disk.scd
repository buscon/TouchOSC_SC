(
~copiedBuf_to_gran.size.do({ |i|
	var path = thisProcess.platform.recordingsDir +/+ i ++ "SC_"  ++ Date.localtime.stamp ++ ".aiff";
	~copiedBuf_to_gran[i].write(path: path,sampleFormat: 'int24');
	//~copiedBuf_to_gran[i].post; path.postln; // generated path
})
)

