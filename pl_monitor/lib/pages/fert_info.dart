import 'package:flutter/material.dart';
import 'package:pl_monitor/utils/variables.dart';

class Fert extends StatefulWidget {
  const Fert({super.key});

  @override
  _FertState createState() => _FertState();
}

class _FertState extends State<Fert> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("FERTILIZER USES"), centerTitle: true),
      body: Column(
        children: [
          // Top Row for Crop Selection
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(cropNames.length, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: _selectedIndex == index
                        ? Colors.green
                        : Colors.grey.shade300,
                    child: Text(cropNames[index][0], // First letter of the crop
                        style: TextStyle(
                            color: _selectedIndex == index
                                ? Colors.white
                                : Colors.black)),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 10),
          // Crop Name Display
          Text(
            cropNames[_selectedIndex],
            style: const TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          const SizedBox(height: 20),
          // Transparent Description Box
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Opacity(
                  opacity: 1.0,
                  child: Image.asset(plantImages[_selectedIndex],
                      fit: BoxFit.cover,
                      alignment: Alignment.centerLeft,
                      height: MediaQuery.sizeOf(context).height * 0.5,
                      width: MediaQuery.sizeOf(context).width * 0.93),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.symmetric(horizontal: 16),
                height: MediaQuery.sizeOf(context).height * 0.53,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.8), // Transparent yellow
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text("N",
                            style: TextStyle(
                                fontSize: 48,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, right: 8.0, left: 32.0, bottom: 8.0),
                          child: SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.6,
                            child: Text(
                              npkDescriptions[_selectedIndex]["N"]!,
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, right: 32.0, left: 8.0, bottom: 8.0),
                          child: SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.6,
                            child: Text(
                              npkDescriptions[_selectedIndex]["P"]!,
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ),
                        const Text("P",
                            style: TextStyle(
                                fontSize: 48,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        const Text("K",
                            style: TextStyle(
                                fontSize: 48,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, right: 8.0, left: 32.0, bottom: 8.0),
                          child: SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.6,
                            child: Text(
                              npkDescriptions[_selectedIndex]["K"]!,
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
