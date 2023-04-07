import 'package:flutter/material.dart';

class IconPadButton extends StatelessWidget {
  final IconData iconData;
  final VoidCallback? onPressed;

  const IconPadButton(
    this.iconData, {
    Key? key,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PadButton(
      onPressed: onPressed,
      child: Center(child: Icon(iconData)),
    );
  }
}

class LargeTextPadButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const LargeTextPadButton(
    this.text, {
    Key? key,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextPadButton(
      text: text,
      style: Theme.of(context).textTheme.displaySmall,
      onPressed: onPressed,
    );
  }
}

class TextPadButton extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final VoidCallback? onPressed;

  const TextPadButton({
    Key? key,
    required this.text,
    this.style,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PadButton(
      onPressed: onPressed,
      child: Center(
        child: Text(
          text,
          style: style,
        ),
      ),
    );
  }
}

class PadButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;

  const PadButton({Key? key, this.onPressed, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: OutlinedButton(
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
