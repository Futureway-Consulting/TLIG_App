import 'package:flutter/material.dart';
import 'package:tlig_app/main.dart';
class DisclaimerScreen extends StatelessWidget {
  final VoidCallback onAccept;

  const DisclaimerScreen({super.key, required this.onAccept});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Spacer(),
              const Text(
                'Notice',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'This application is an independent wrapper that provides access '
                'to a publicly available website of True Life In God.\n\n'
                'This application is not affiliated with, endorsed by, or owned by '
                'the operators of the website.\n\n'
                'All content, trademarks, and intellectual property belong to their '
                'respective owners.\n\n'
                'This application does not host or modify website content and exists '
                'solely as a convenience method of access.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white70, fontSize: 15),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onAccept,
                  child: const Text('Continue'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class AppGate extends StatefulWidget {
  const AppGate({super.key});

  @override
  State<AppGate> createState() => _AppGateState();
}

class _AppGateState extends State<AppGate> {
  bool acceptedDisclaimer = false;

  @override
  Widget build(BuildContext context) {
    return acceptedDisclaimer
        ? MainApp()
        : DisclaimerScreen(
            onAccept: () {
              setState(() {
                acceptedDisclaimer = true;
              });
            },
          );
  }
}
