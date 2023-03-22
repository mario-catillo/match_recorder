import 'package:flutter/material.dart';

class EventDescriptionView extends StatefulWidget {
  const EventDescriptionView({Key? key}) : super(key: key);

  @override
  _EventDescriptionViewState createState() => _EventDescriptionViewState();
}

class _EventDescriptionViewState extends State<EventDescriptionView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Description'),
      ),
      body: const Center(
        child: Text('Event Description'),
      ),
    );
  }
}
