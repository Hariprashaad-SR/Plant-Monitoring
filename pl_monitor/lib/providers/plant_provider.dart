import 'package:flutter/material.dart';

class PlantProvider with ChangeNotifier {
  final List<int> _moistureLevels = [45, 55, 60, 40, 52];
  int _weatherTemp = 24;

  List<int> get moistureLevels => _moistureLevels;
  int get weatherTemp => _weatherTemp;

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
}
