import 'package:flutter/material.dart';

class PriceCard extends StatelessWidget {
  const PriceCard({
    Key? key,
    required this.crypto,
    required this.price,
    required this.fiat,
  }) : super(key: key);

  final String crypto;
  final String price;
  final String fiat;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.lightBlueAccent,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
        child: Text(
          '1 $crypto = $price $fiat',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
