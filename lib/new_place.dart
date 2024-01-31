import 'package:flutter/material.dart';

class AddNewPlace extends StatelessWidget {
  const AddNewPlace({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add new place')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const TextField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                label: Text(
                  'Title',
                  style: TextStyle(color: Colors.white),
                ),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Wrap(
                children: [
                  Icon(Icons.add),
                  SizedBox(width: 5),
                  Text('Add Place'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
