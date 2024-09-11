import 'dart:async'; // For Timer
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:pl_monitor/utils/variables.dart';
import 'package:pl_monitor/providers/plant_provider.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedPlantIndex = 0;
  final FlutterTts flutterTts = FlutterTts();
  List<bool> hasAlertPlayed = List<bool>.filled(5, false);

  @override
  void initState() {
    super.initState();
    _checkMoistureLevel(_selectedPlantIndex);
  }

  Future<void> _checkMoistureLevel(int plantIndex) async {
    final moistureLevel =
        context.read<PlantProvider>().moistureLevels[plantIndex];
    if (moistureLevel < 50 && !hasAlertPlayed[plantIndex]) {
      await flutterTts.speak(
          'Warning! The moisture level for ${plantNames[plantIndex]} is below 50 percent. Irrigate it!!');
      hasAlertPlayed[plantIndex] = true;
    } else if (moistureLevel >= 50) {
      hasAlertPlayed[plantIndex] = false;
    }
  }

  void _onPlantTapped(int index) {
    setState(() {
      _selectedPlantIndex = index;
      _checkMoistureLevel(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final plantProvider = context.watch<PlantProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('CROP MONITOR'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(plantImages.length, (index) {
                return GestureDetector(
                  onTap: () => _onPlantTapped(index),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(plantImages[index]),
                    child: _selectedPlantIndex == index
                        ? Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color.fromARGB(255, 11, 11, 11),
                                width: 2.0,
                              ),
                            ),
                          )
                        : null,
                  ),
                );
              }),
            ),
            SizedBox(height: screenHeight * 0.04),
            Text(plantNames[_selectedPlantIndex],
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: screenHeight * 0.01),
            Image.asset(
              plantImages[_selectedPlantIndex],
              height: screenHeight * 0.35,
              width: screenWidth * 0.8,
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    const Icon(Icons.water_drop, size: 30),
                    const Text(
                      'Moisture',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      '${plantProvider.moistureLevels[_selectedPlantIndex]}%',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Icon(Icons.sunny, size: 30),
                    const Text(
                      'Weather',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      '${plantProvider.weatherTemp}°C',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () => context
                  .read<PlantProvider>()
                  .toggleButton(_selectedPlantIndex),
              style: ElevatedButton.styleFrom(
                backgroundColor: !plantProvider.isOnList[_selectedPlantIndex]
                    ? const Color.fromARGB(255, 242, 168, 65)
                    : const Color.fromARGB(255, 255, 66, 82),
                minimumSize: const Size(140, 40),
              ),
              child: Text(
                plantProvider.isOnList[_selectedPlantIndex] ? 'OFF' : 'ON',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            const Spacer()
          ],
        ),
      ),
    );
  }
}
