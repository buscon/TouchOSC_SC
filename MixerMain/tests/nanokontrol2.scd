


~nk2 = MKtl('myNK2', "korg-nanokontrol2");

// turn on trace, then move some elements to see that it works
~nk2.trace;
~nk2.trace(false);

// If no such controller is connected, use its gui instead:
~nk2.gui;

// the elements (knobs, sliders, buttons) are in hierarchical groups
~nk2.elementGroup;
~nk2.postElements;
~nk2.elAt( \bt, 0 )
~nk2.elementAt( \bt, 0 ).flat
a = MKtlElementGroup( 'group', ~nk2, ~nk2.elementAt( \bt, 0 ).flat );//.action = {|...args| args[0].value.postln;};

// assign an action to be fired when any element in the group is touched
// the first argument will be the touched MKtlElement, the second argument
// in this case will be the MKtlElementGroup we just created.
(
a.action = { |...args|
//	args[1].postln;
//	~nk2.elAt(\bt, 0, 4).action = {|el| el.value.postln;};

//	args[0].value.postln;
	};
)
a.action = { |...args| args.postln; };
a.action = { 10.postln; };

// elements can be accessed by hierarchical names or indices:
~nk2.elAt(\kn, 0);
~nk2.elAt(\kn, \1);
~nk2.elAt(\tr, \play);
~nk2.elAt(\bt, 0, 4).action = {|el| el.value.postln;};
~nk2.elAt(\bt, \M);
~nk2.elAt(\bt, \S, \1).action = {|el| el.value.postln;}; // the first  button

	~nk2.sendSpecialMessage('makeButtonLEDsWriteable');
~nk2.outputElements.do(_.value_(1));
~nk2.outputElements.do(_.value_(0));
~nk2.elAt(\tr_play, 'button', 'play');
~nk2.MKtlElement.types
	~nk2.outputElements

// make sure there are no current assigned actions
~nk2.resetActions;

// boot the server
s.boot;

(
// play a sound
x = {
    Splay.ar(
        SinOsc.ar([
            \freq1.kr(700, lag: 0.3),
            \freq2.kr(150, lag: 0.3),
            \freq3.kr(100, lag: 0.3)
    ]))/3
}.play;

// add a spec for the controls
Spec.add(\freq1, [100, 1000, \exp]);
)

// set actions to the first three sliders
(
~nk2.elAt(\sl, 0).action = {arg el; x.set(\freq1, \freq1.asSpec.map(el.value)) };
~nk2.elAt(\sl, 1).action = {arg el; x.set(\freq2, \freq1.asSpec.map(el.value)) };
~nk2.elAt(\sl, 2).action = {arg el; x.set(\freq3, \freq1.asSpec.map(el.value)) };
)
~nk2.elAt(\bt, 0, 1).action = {arg el; el.value.postln };
// after testing, free sound
x.free;

// and free the device
~nk2.free;