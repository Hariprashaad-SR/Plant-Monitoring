import 'dart:async'; // Importing Timer
import 'package:flutter/material.dart';

class PlantProvider with ChangeNotifier {
  final List<int> _moistureLevels = [45, 55, 60, 40, 52];
  int _weatherTemp = 24;
  List<bool> _isOnList =
      List<bool>.filled(5, false); // Tracks the ON/OFF state for each plant
  List<Timer?> _timers =
      List<Timer?>.filled(5, null); // Tracks the Timer for each plant

  List<int> get moistureLevels => _moistureLevels;
  int get weatherTemp => _weatherTemp;
  List<bool> get isOnList => _isOnList;

  void updateMoistureLevel(int index, int value) {
    _moistureLevels[index] = value;
    notifyListeners();
  }

  void updateWeatherTemp(int value) {
    _weatherTemp = value;
    notifyListeners();
  }

  void incrementMoistureLevel(int index) {
    _moistureLevels[index] += 1;
    notifyListeners();
  }

  void toggleButton(int index) {
    if (_isOnList[index]) {
      _timers[index]?.cancel();
      _isOnList[index] = false;
    } else {
      _startMoistureIncrement(index);
      _isOnList[index] = true;
    }
    notifyListeners();
  }

  void _startMoistureIncrement(int index) {
    _timers[index] = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      incrementMoistureLevel(index);
    });
  }

  @override
  void dispose() {
    for (var timer in _timers) {
      timer?.cancel();
    }
    super.dispose();
  }
}
