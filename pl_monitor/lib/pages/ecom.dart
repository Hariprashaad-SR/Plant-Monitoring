import 'package:flutter/material.dart';
import 'package:pl_monitor/pages/cart.dart';
import 'package:pl_monitor/utils/variables.dart';

class Ecom extends StatelessWidget {
  const Ecom({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('E - COMMERCE'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(plantImages[index]),
                ),
                title: Text(plantNames[index]),
                subtitle: const Text('This is the description of the plant.'),
                trailing: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartPage(
                          plantName: plantNames[index],
                          pricePerKg: 78.13,
                          plantImage: plantImages[index],
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightGreenAccent,
                    foregroundColor: Colors.black,
                  ),
                  child: const Text('ORDER'),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
