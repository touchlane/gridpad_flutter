import 'package:example/theme.dart';
import 'package:flutter/material.dart';

import 'components/interactive_pin_pad.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: darkThemeData,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GridPad'),
      ),
      body: const ListOfPads(),
    );
  }
}

class ListOfPads extends StatelessWidget {
  const ListOfPads({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(children: const [InteractivePinPadCard()]);
  }
}

class InteractivePinPadCard extends StatelessWidget {
  const InteractivePinPadCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: InteractivePinPad(),
      ),
    );
  }
}
