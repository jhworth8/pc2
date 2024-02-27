import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:provider/provider.dart';
import 'package:shake/shake.dart';
import 'cowbell_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  AudioPlayer audioPlayer = AudioPlayer();
  ShakeDetector? detector;
  AnimationController? _animationController;
  bool isPlaying = false;

@override
void initState() {
  super.initState();
  _animationController = AnimationController(
    vsync: this,
    duration: Duration(milliseconds: 100),
    lowerBound: -0.05,
    upperBound: 0.05,
  )..addListener(() {
      setState(() {});
    });

  detector = ShakeDetector.waitForStart(onPhoneShake: () {
    if (!isPlaying) {
      CowbellModel model = Provider.of<CowbellModel>(context, listen: false);
      audioPlayer.play(AssetSource(model.currentSound));
      _animationController?.repeat(reverse: true);
      isPlaying = true;
    }
  });

  detector?.startListening();

  // Listen for when the audio playback is complete
  audioPlayer.onPlayerComplete.listen((event) {
    _animationController?.stop();
    _animationController?.value = 0; // Reset to the original position
    isPlaying = false;
  });
}




  @override
  void dispose() {
    detector?.stopListening();
    audioPlayer.release();
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CowbellModel>(
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Home'),
          ),
          body: Row( // Use Row to place items side by side
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                // Cowbell image displayed prominently with shaking animation
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Transform.rotate(
                    angle: _animationController?.value ?? 0,
                    child: Image.asset(model.currentBell),
                  ),
                ),
              ),
              // A column for the dropdown menus to the side
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  DropdownButton<String>(
                    value: model.currentBell,
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        Provider.of<CowbellModel>(context, listen: false).updateBell(newValue);
                      }
                    },
                    items: model.availableBells.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value.split('/').last),
                      );
                    }).toList(),
                  ),
                  DropdownButton<String>(
                    value: model.currentSound,
                    icon: const Icon(Icons.arrow_downward),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        model.updateSound(newValue);
                      }
                    },
                    items: model.availableSounds.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value.split('/').last),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
