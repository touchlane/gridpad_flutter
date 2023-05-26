import 'package:flutter/widgets.dart';

class PadThemeProvider<T> extends InheritedWidget {
  final T theme;

  const PadThemeProvider({
    super.key,
    required this.theme,
    required super.child,
  });

  static PadThemeProvider<T>? of<T>(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<PadThemeProvider<T>>();
  }

  @override
  bool updateShouldNotify(PadThemeProvider oldWidget) {
    return theme != oldWidget.theme;
  }
}
