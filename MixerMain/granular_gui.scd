
(

// general color palette
QtGUI.palette = QPalette.dark;

// main window (for now)
~gwin = Window.new(
	"Granulators",
	Rect( left:20, top:20,
		width: 1000, height: 400 ));
~gwin.background = Color.gray(0.3,1);

~gwin.layout = HLayout(

	VLayout(

		StaticText().string_("GRANULATOR"),
		Button()
		.states_([
			["OFF", Color.gray(0.2), Color.gray(0.8)],
			["ON", Color.gray(0.8), Color.grey(0.2)] ])
		.mouseDownAction_({
			arg state;
			state.value.postln;
			if (state.value == 0) {
				~granSynth = Synth(\Granny, [\bufnum, ~buf_to_gran[0]]);
			} {
				~granSynth.free;
			}
		})
		.minHeight_(70)
		.minWidth_(70),
		nil
	),

	VLayout(
		PopUpMenu().items_([~buf_to_gran[0].path.split.reverse[0],
			~buf_to_gran[1].path.split.reverse[0],
			~buf_to_gran[2].path.split.reverse[0],
			~buf_to_gran[3].path.split.reverse[0],
			~buf_to_gran[4].path.split.reverse[0],
			~buf_to_gran[5].path.split.reverse[0],
			~buf_to_gran[6].path.split.reverse[0]
		]).font_(Font("Sans",20))
		.action_({arg menu;
			//menu.item.postln;
			menu.value.postln;
			~mixer[5].set(\bufNum, ~buf_to_gran[menu.value.postln]);
		}),
		StaticText().string_("Filter vs. Position"),
		Slider2D()
		.x_(0.05)
		.y_(0.05)
		.action_({ arg slider;
			~gran_parameters[0][0].set(\pos, slider.x.postln);
			~gran_parameters[0][0].set(\trigRateR, slider.y.value.linexp(0,1.0,0.01,15.5).postln)
		}),

		StaticText().string_("Position variation"),
		Slider(nil,Rect(0,0,50,10))
		.minHeight_(20)
		.thumbSize_(50)
		.action_({ arg posvar;
			posvar = posvar.value;
			~mixer[5].set(\posvar, posvar.value);
		})
	),

	VLayout(

		StaticText().string_("amtRnd"),
		HLayout(
			Slider(nil,Rect(0,0,2,1)).minHeight_(50).thumbSize_(50)
			.action_({ arg dur;

				~gran_parameters[0][0].set(\amtRnd, dur.value);
				~nbf.value_(dur.value);

			}),
			VLayout(nil,
				~nbf = NumberBox(nil,Rect(0,0,1,1))
				.font_(Font("Sans",20))
				.maxWidth_(50)
				.minHeight_(30);
			)
		),
		HLayout(
			StaticText().string_("variation"),
			Slider(nil,Rect(0,0,2,1)).thumbSize_(50)
			.action_({ arg fvar;
				fvar = fvar.value * 2;
				~granSynth.set(\fvar, fvar.value);
			})
		),
		nil,
		StaticText().string_("Duration of grains"),
		HLayout(
			Slider(nil,Rect(0,0,2,1)).minHeight_(50).thumbSize_(50)
			.action_({ arg dur;
				dur = dur.value;
				~gran_parameters[0][0].set(\dur, dur.value);
				~nbd.value_((dur.value * 100).asInt);

			}),
			VLayout(nil,
				~nbd = NumberBox(nil,Rect(0,0,1,1))
				.font_(Font("Sans", 20))
				.maxWidth_(50)
				.minHeight_(30);)
		),
		HLayout(StaticText().string_("variation"),
			Slider(nil,Rect(0,0,2,1)).thumbSize_(50)
			.action_({ arg durvar;
				durvar = durvar.value * 2;
				~granSynth.set(\durvar, durvar.value);
			})
		),
		nil,
		StaticText().string_("Pitch"),
		HLayout(
			Slider(nil,Rect(0,0,2,1)).minHeight_(20).thumbSize_(50)
			.action_({ arg pitch;
				pitch = pitch.value * 2;
				~gran_parameters[0][0].set(\rate, pitch.value);
				~nbp.value_(pitch.value); }),
			VLayout(nil,
				~nbp = NumberBox()
				.font_(Font("Sans", 20))
				.maxWidth_(50)
				.minHeight_(30);)
		),
		HLayout(StaticText().string_("variation"),
			Slider(nil,Rect(0,0,2,1)).thumbSize_(50)
			.action_({ arg pitchvar;
				pitchvar = pitchvar.value;
				~granSynth.set(\pitchvar, pitchvar.value);
			})
		),
		nil,
		StaticText().string_("Width (Stereo)"),
		HLayout(
			Slider(nil,Rect(0,0,2,1)).minHeight_(20).thumbSize_(50).maxHeight_(20)
			.action_({ arg width;
				width = width.value;
				~granSynth.set(\width, width.value);
				~nbw.value_(width.value);
			}),
			VLayout(nil,
				~nbw = NumberBox()
				.font_(Font("Sans", 12))
				.maxWidth_(50).maxHeight_(20)
				.minHeight_(20);)
		)
	),
	VLayout(
		StaticText().string_("Gain")
		.align_(\center),
		Slider(nil, Rect(0,0,1,2))
		.minWidth_(50)
		.thumbSize_(50)
		.action_({ arg gain;
			~granSynth.set(\gain, gain.value.linexp(0,1,0.01,10,nil)-0.01 * 0.05)})
		.valueAction_(0)
		;
	)
);

~gwin.front;

~gwin.onClose_({
	~granSynth.free;
})

)