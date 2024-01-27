import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 15.0,
      width: 150,
      decoration: const BoxDecoration(
        color: Colors.red,
        shape: BoxShape.circle,
      ),
      child: const Center(
          child: Icon(
        Icons.person,
        size: 50,
        color: Colors.white,
      )),
    );
  }
}
