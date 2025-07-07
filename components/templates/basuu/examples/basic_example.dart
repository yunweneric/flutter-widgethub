import 'package:flutter/material.dart';

class BasicExample extends StatelessWidget {
  const BasicExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Basuu Example')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.widgets, size: 64, color: Colors.blue),
            SizedBox(height: 16),
            Text(
              'Basuu Component',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'This component contains multiple widget files.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 16),
            Text(
              'Available files:',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),

          ],
        ),
      ),
    );
  }
}
