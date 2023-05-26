import 'package:flutter/material.dart';

import '../theme.dart';

class BlueprintBox extends StatelessWidget {
  const BlueprintBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: SizedBox.expand(
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: andreaBlue,
            shape: BoxShape.rectangle,
            border: Border.all(color: Colors.white, style: BorderStyle.solid),
          ),
        ),
      ),
    );
  }
}

class ContentBlueprintBox extends StatelessWidget {
  final String text;

  const ContentBlueprintBox({Key? key, this.text = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const BlueprintBox(),
        Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}
