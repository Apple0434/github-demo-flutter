import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const SettingsTabScrenn();
  }
}

class SettingsTabScrenn extends StatefulWidget {
  const SettingsTabScrenn({super.key});

  @override
  State<SettingsTabScrenn> createState() => _SettingsTabScrennState();
}

class _SettingsTabScrennState extends State<SettingsTabScrenn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Thong bao'),),
      body: ListView(
        children: [
           const Divider(),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Divider(
                color: Colors.black,
                thickness: 1,
                height: 1,
                indent: 20,
                endIndent: 20,
              )
            ],
          )
        ],
      )
        );
  }
}

