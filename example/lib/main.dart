import 'package:example/components/blueprint.dart';
import 'package:example/theme.dart';
import 'package:flutter/material.dart';
import 'package:grid_pad/gridpad_cells.dart';
import 'package:grid_pad/gridpad_widget.dart';

import 'components/engineering_calculator_pad.dart';
import 'components/interactive_pin_pad.dart';
import 'components/simple_calculator_pad.dart';
import 'components/simple_priority_calculator_pad.dart';

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
    return ListView(children: const [
      InteractivePinPadCard(),
      EngineeringCalculatorPadCard(),
      SimplePriorityCalculatorPadCard(),
      SimpleCalculatorPadCard(),
      SimpleBlueprintCard(),
      CustomSizeBlueprintCard(),
      SimpleBlueprintCardWithContent(),
      SimpleBlueprintCardWithContentMixOrdering(),
    ]);
  }
}

class PadCard extends StatelessWidget {
  final double ratio;
  final Widget child;

  const PadCard({
    Key? key,
    required this.ratio,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: AspectRatio(aspectRatio: ratio, child: child),
      ),
    );
  }
}

class BlueprintCard extends StatelessWidget {
  final double ratio;
  final Widget child;

  const BlueprintCard({
    Key? key,
    this.ratio = 1,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: AspectRatio(aspectRatio: ratio, child: child),
      ),
    );
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

class EngineeringCalculatorPadCard extends StatelessWidget {
  const EngineeringCalculatorPadCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const PadCard(ratio: 1.1, child: EngineeringCalculatorPad());
  }
}

class SimplePriorityCalculatorPadCard extends StatelessWidget {
  const SimplePriorityCalculatorPadCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const PadCard(ratio: 1, child: SimplePriorityCalculatorPad());
  }
}

class SimpleCalculatorPadCard extends StatelessWidget {
  const SimpleCalculatorPadCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const PadCard(ratio: 0.9, child: SimpleCalculatorPad());
  }
}

class SimpleBlueprintCard extends StatelessWidget {
  const SimpleBlueprintCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlueprintCard(
      ratio: 1.5,
      child: GridPad(
        gridPadCells: GridPadCells.gridSize(rowCount: 3, columnCount: 4),
        children: [
          for (var i = 0; i < 13; i++)
            const Cell.explicit(child: BlueprintBox())
        ],
      ),
    );
  }
}

class CustomSizeBlueprintCard extends StatelessWidget {
  const CustomSizeBlueprintCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlueprintCard(
      ratio: 1.5,
      child: GridPad(
        gridPadCells: GridPadCellsBuilder(rowCount: 3, columnCount: 4)
            .rowSize(0, const Weight(2))
            .columnSize(3, const Fixed(30))
            .build(),
        children: [
          for (var i = 0; i < 12; i++)
            const Cell.explicit(child: BlueprintBox())
        ],
      ),
    );
  }
}

class SimpleBlueprintCardWithContent extends StatelessWidget {
  const SimpleBlueprintCardWithContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const rowCount = 3;
    const columnCount = 4;
    const cellCount = rowCount * columnCount;
    return BlueprintCard(
      ratio: 1.5,
      child: Stack(
        children: [
          GridPad(
            gridPadCells: GridPadCells.gridSize(
              rowCount: rowCount,
              columnCount: columnCount,
            ),
            children: [
              for (var i = 0; i < cellCount; i++)
                const Cell.explicit(child: BlueprintBox())
            ],
          ),
          GridPad(
            gridPadCells: GridPadCells.gridSize(
              rowCount: rowCount,
              columnCount: columnCount,
            ),
            children: const [
              Cell.explicit(child: ContentBlueprintBox(text: '[0;0]')),
              Cell.explicit(child: ContentBlueprintBox(text: '[0;1]')),
            ],
          ),
        ],
      ),
    );
  }
}

class SimpleBlueprintCardWithContentMixOrdering extends StatelessWidget {
  const SimpleBlueprintCardWithContentMixOrdering({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const rowCount = 3;
    const columnCount = 4;
    const cellCount = rowCount * columnCount;
    return BlueprintCard(
      ratio: 1.5,
      child: Stack(
        children: [
          GridPad(
            gridPadCells: GridPadCells.gridSize(
              rowCount: rowCount,
              columnCount: columnCount,
            ),
            children: [
              for (var i = 0; i < cellCount; i++)
                const Cell.explicit(child: BlueprintBox())
            ],
          ),
          GridPad(
            gridPadCells: GridPadCells.gridSize(
              rowCount: rowCount,
              columnCount: columnCount,
            ),
            children: const [
              Cell(
                row: 1,
                column: 2,
                child: ContentBlueprintBox(text: '[1;2]\nOrder: 1'),
              ),
              Cell(
                row: 0,
                column: 1,
                child: ContentBlueprintBox(text: '[0;1]\nOrder: 2'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
