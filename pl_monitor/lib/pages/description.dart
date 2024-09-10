import 'package:flutter/material.dart';
import 'package:pl_monitor/utils/variables.dart';

class DescriptionPage extends StatefulWidget {
  const DescriptionPage({super.key});

  @override
  State<DescriptionPage> createState() => _DescriptionPageState();
}

class _DescriptionPageState extends State<DescriptionPage> {
  int _expandedIndex = -1;

  void _onPanelTapped(int index) {
    setState(() {
      _expandedIndex = _expandedIndex == index ? -1 : index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('DESCRIPTION'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ExpansionPanelList(
            expandedHeaderPadding: EdgeInsets.zero,
            expansionCallback: (index, isExpanded) {
              _onPanelTapped(index);
            },
            animationDuration: const Duration(milliseconds: 300),
            children: List.generate(crops.length, (index) {
              return ExpansionPanel(
                canTapOnHeader: true,
                headerBuilder: (context, isExpanded) {
                  return Container(
                    margin: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                    decoration: BoxDecoration(
                        color: index != _expandedIndex
                            ? const Color.fromARGB(255, 238, 234, 251)
                            : const Color.fromARGB(255, 185, 242, 187)),
                    child: ListTile(
                        title: Text(crops[index]['name']!),
                        leading: CircleAvatar(
                            backgroundImage: AssetImage(crops[index]['image']!),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: const Color.fromARGB(255, 11, 11, 11),
                                  width: 1.0,
                                ),
                              ),
                            ))),
                  );
                },
                body: Stack(
                  children: [
                    Opacity(
                      opacity: 0.6,
                      child: Image.asset(crops[index]['image']!,
                          height: screenHeight * 0.4,
                          width: screenWidth * 0.7,
                          fit: BoxFit.cover,
                          alignment: Alignment.centerLeft),
                    ),
                    Container(
                      height: screenHeight * 0.4,
                      margin: EdgeInsets.only(
                        top: 0.0,
                        left: 0.20 * screenWidth,
                      ),
                      padding: const EdgeInsets.only(
                          top: 8.0, right: 16.0, left: 16.0, bottom: 16.0),
                      alignment: Alignment.centerRight,
                      color: Colors.white.withOpacity(0.7),
                      child: Column(
                        children: [
                          Text(
                            crops[index]['description']!,
                            style: const TextStyle(
                                fontSize: 14.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                isExpanded: _expandedIndex == index,
              );
            }),
          ),
        ),
      ),
    );
  }
}
