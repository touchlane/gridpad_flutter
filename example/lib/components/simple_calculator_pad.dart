import 'package:flutter/material.dart';
import 'package:grid_pad/grid_pad.dart';

import 'pad_button.dart';

class SimpleCalculatorPad extends StatelessWidget {
  const SimpleCalculatorPad({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridPad(
      gridPadCells: GridPadCellsBuilder(rowCount: 5, columnCount: 4).build(),
      children: [
        LargeTextPadButton('C', onPressed: () {}),
        LargeTextPadButton('÷', onPressed: () {}),
        LargeTextPadButton('×', onPressed: () {}),
        IconPadButton(Icons.backspace, onPressed: () {}),
        LargeTextPadButton('7', onPressed: () {}),
        LargeTextPadButton('8', onPressed: () {}),
        LargeTextPadButton('9', onPressed: () {}),
        LargeTextPadButton('-', onPressed: () {}),
        LargeTextPadButton('4', onPressed: () {}),
        LargeTextPadButton('5', onPressed: () {}),
        LargeTextPadButton('6', onPressed: () {}),
        LargeTextPadButton('+', onPressed: () {}),
        LargeTextPadButton('1', onPressed: () {}),
        LargeTextPadButton('2', onPressed: () {}),
        LargeTextPadButton('3', onPressed: () {}),
        Cell.explicit(
          rowSpan: 2,
          child: LargeTextPadButton('=', onPressed: () {}),
        ),
        Cell(
          row: 4,
          column: 0,
          child: LargeTextPadButton('.', onPressed: () {}),
        ),
        Cell.explicit(
          columnSpan: 2,
          child: LargeTextPadButton('0', onPressed: () {}),
        ),
      ],
    );
  }
}
