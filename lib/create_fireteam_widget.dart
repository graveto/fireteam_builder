import 'package:flutter/material.dart';
import 'fireteam.dart'; // Import your Fireteam class

class CreateFireteamWidget extends StatefulWidget {
  final Function(Fireteam) onFireteamCreated;

  const CreateFireteamWidget({super.key, required this.onFireteamCreated});

  @override
  State<CreateFireteamWidget> createState() => _CreateFireteamWidgetState();
}

class _CreateFireteamWidgetState extends State<CreateFireteamWidget> {
  final TextEditingController _fireteamNameController = TextEditingController();
  String _fireteamName = '';

  @override
  void initState() {
    super.initState();
    _fireteamNameController.addListener(_updateFireteamName);
  }

  @override
  void dispose() {
    _fireteamNameController.removeListener(_updateFireteamName);
    _fireteamNameController.dispose();
    super.dispose();
  }

  void _updateFireteamName() {
    setState(() {
      _fireteamName = _fireteamNameController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Fireteam'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _fireteamNameController,
              decoration: const InputDecoration(
                labelText: 'Fireteam Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _fireteamName.trim().isEmpty
                  ? null
                  : () {
                      // Get the fireteam name from the text field
                      String fireteamName = _fireteamNameController.text.trim();

                      // Create a new fireteam
                      Fireteam newFireteam = Fireteam(fireteamName);

                      // Call the callback function to add the fireteam to the list
                      widget.onFireteamCreated(newFireteam);
                    },
              child: const Text('Create'),
            ),
          ],
        ),
      ),
    );
  }
}
