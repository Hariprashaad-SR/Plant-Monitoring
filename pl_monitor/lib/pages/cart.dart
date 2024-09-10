import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  final String plantName;
  final double pricePerKg;
  final String plantImage;

  const CartPage({
    super.key,
    required this.plantName,
    required this.pricePerKg,
    required this.plantImage,
  });

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int selectedShopIndex = 0;
  double selectedQuantity = 30;
  late double totalPrice;
  bool ordered = false;

  @override
  void initState() {
    super.initState();
    totalPrice = widget.pricePerKg * selectedQuantity;
  }

  void updatePrice(double quantity) {
    setState(() {
      selectedQuantity = quantity;
      totalPrice = widget.pricePerKg * selectedQuantity;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CART'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () => {},
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage(widget.plantImage),
            ),
            const SizedBox(height: 10),
            Text(
              widget.plantName,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(3, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedShopIndex = index;
                    });
                  },
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage:
                            AssetImage('assets/store${index + 1}.png'),
                        child: selectedShopIndex == index
                            ? Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.greenAccent,
                                    width: 4.0,
                                  ),
                                ),
                              )
                            : null,
                      ),
                      selectedShopIndex == index
                          ? const SizedBox(height: 10)
                          : const SizedBox(height: 5),
                      Text(
                        'Shop ${index + 1}',
                        style: TextStyle(
                          // Change text color if selected
                          fontSize: selectedShopIndex == index ? 16 : 14,
                          fontWeight: selectedShopIndex == index
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      )
                    ],
                  ),
                );
              }),
            ),
            const SizedBox(height: 40),
            const Text(
              'QUANTITY',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Slider(
              value: selectedQuantity,
              min: 0,
              max: 60,
              divisions: 12,
              label: '${selectedQuantity.round()} KG',
              onChanged: (value) {
                updatePrice(value);
              },
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '${selectedQuantity.round()} KG',
                style: const TextStyle(fontSize: 20),
              ),
            ),
            const Spacer(flex: 2),
            ElevatedButton(
              onPressed: () {
                setState(() => ordered = true);
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 8),
                backgroundColor:
                    ordered ? Colors.lightGreenAccent : Colors.amber,
                foregroundColor: Colors.black,
                minimumSize: const Size(300, 50),
              ),
              child: Column(
                children: [
                  ordered
                      ? const Text(
                          'Ordered Successfully',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )
                      : const Text(
                          'PLACE ORDER',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                  !ordered
                      ? Text(
                          '\$ ${totalPrice.toStringAsFixed(2)}',
                          style: const TextStyle(fontSize: 14),
                        )
                      : const Text('✔️'),
                ],
              ),
            ),
            const Spacer(flex: 1),
          ],
        ),
      ),
    );
  }
}
