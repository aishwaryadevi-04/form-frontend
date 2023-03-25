import 'package:flutter/material.dart';
class Confirm extends StatelessWidget {
  const Confirm({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 70, 20, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Response has been saved successfully',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 35),
            Icon(Icons.check_circle, size: 80, color: Colors.blueAccent),
          ],
        ),
      ),
    );
  }
}