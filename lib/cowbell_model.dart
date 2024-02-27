import 'package:flutter/material.dart';

class CowbellModel extends ChangeNotifier {
  String _currentBell = 'assets/images/8bit.png';
  String _currentSound = 'assets/sounds/clang.mp3';
  List<String> _availableBells = [
    'assets/images/8bit.png',
    'assets/images/chello.png',
    'assets/images/cloud.png',
    'assets/images/deep pink.png',
    'assets/images/golden.png',
    'assets/images/iconapple.png',
    'assets/images/logo.png',
    'assets/images/marble.png',
    'assets/images/maroon.png',
    'assets/images/paint.png',
    'assets/images/pink.png',
    'assets/images/smoke.png',
    'assets/images/stripes.png',
    'assets/images/trendy-2.png',
  ];
List<String> _availableSounds = [
  'assets/sounds/8bit.mp3',
  'assets/sounds/chello.m4a',
  'assets/sounds/clang.mp3',
  'assets/sounds/cling.mp3',
  'assets/sounds/clong.mp3',
  'assets/sounds/clung.mp3',
  'assets/sounds/goat.mp3',
  'assets/sounds/incoming.m4a',
  'assets/sounds/mane.m4a',
  'assets/sounds/outro.mp3',
  'assets/sounds/phonk.mp3',
];

  String get currentBell => _currentBell;
  String get currentSound => _currentSound;
  List<String> get availableBells => _availableBells;
  List<String> get availableSounds => _availableSounds;

  void updateBell(String newBell) {
    _currentBell = newBell;
    notifyListeners();
  }

  void updateSound(String newSound) {
    _currentSound = newSound;
    notifyListeners();
  }

  void saveCustomization() {
    // Implement saving logic here
    notifyListeners();
  }
}