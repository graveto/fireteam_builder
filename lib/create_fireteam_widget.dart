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
        title: Center(
          child: Text(
            'Create Fireteam',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _fireteamNameController,
              decoration: const InputDecoration(
                labelText: 'Enter Fireteam Name',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
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
        shape: const CircleBorder(),
        backgroundColor: Color.fromARGB(255, 54, 75, 68),
        foregroundColor: Color.fromARGB(255, 150, 161, 148),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
