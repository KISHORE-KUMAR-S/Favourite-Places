import 'package:flutter/material.dart';

class AddNewPlace extends StatefulWidget {
  const AddNewPlace({super.key});

  @override
  State<AddNewPlace> createState() => _AddNewPlaceState();
}

class _AddNewPlaceState extends State<AddNewPlace> {
  final _titleController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add new place')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
              decoration: InputDecoration(
                // label: Text(
                //   'Title',
                //   style: Theme.of(context).textTheme.titleMedium!.copyWith(
                //       color: Theme.of(context).colorScheme.onBackground),
                // ),
                labelText: 'Title',
                labelStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            // ElevatedButton(
            //   onPressed: () {},
            //   child: const Wrap(
            //     children: [
            //       Icon(Icons.add),
            //       SizedBox(width: 5),
            //       Text('Add Place'),
            //     ],
            //   ),
            // ),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text('Add Place'),
            ),
          ],
        ),
      ),
    );
  }
}
