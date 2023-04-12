import 'package:example/components/pad_button.dart';
import 'package:flutter/material.dart';
import 'package:grid_pad/grid_pad_cells.dart';
import 'package:grid_pad/grid_pad_widget.dart';

class EngineeringCalculatorPad extends StatelessWidget {
  const EngineeringCalculatorPad({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GridPad(
      gridPadCells: GridPadCellsBuilder(rowCount: 5, columnCount: 5)
          .rowSize(0, const Fixed(48))
          .build(),
      children: [
        //BG space
        Cell(
          row: 1,
          column: 0,
          rowSpan: 4,
          columnSpan: 3,
          child: DecoratedBox(
            decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                shape: BoxShape.rectangle,
                borderRadius: const BorderRadius.all(Radius.circular(8.0))),
          ),
        ),
        Cell(
          row: 0,
          column: 0,
          child: SmallTextPadButton('sin', onPressed: () {}),
        ),
        SmallTextPadButton('cos', onPressed: () {}),
        SmallTextPadButton('log', onPressed: () {}),
        SmallTextPadButton('π', onPressed: () {}),
        SmallTextPadButton('√', onPressed: () {}),
        LargeTextPadButton('7', onPressed: () {}),
        LargeTextPadButton('8', onPressed: () {}),
        LargeTextPadButton('9', onPressed: () {}),
        LargeTextPadButton('(', onPressed: () {}),
        LargeTextPadButton(')', onPressed: () {}),
        LargeTextPadButton('4', onPressed: () {}),
        LargeTextPadButton('5', onPressed: () {}),
        LargeTextPadButton('6', onPressed: () {}),
        LargeTextPadButton('×', onPressed: () {}),
        LargeTextPadButton('÷', onPressed: () {}),
        LargeTextPadButton('1', onPressed: () {}),
        LargeTextPadButton('2', onPressed: () {}),
        LargeTextPadButton('3', onPressed: () {}),
        LargeTextPadButton('-', onPressed: () {}),
        LargeTextPadButton('+', onPressed: () {}),
        LargeTextPadButton('C', onPressed: () {}),
        LargeTextPadButton('.', onPressed: () {}),
        LargeTextPadButton('0', onPressed: () {}),
        IconPadButton(Icons.backspace, onPressed: () {}),
        LargeTextPadButton('=', onPressed: () {}),
      ],
    );
  }
}
