import 'package:flutter/material.dart';
import 'package:grid_pad/grid_pad.dart';

import 'pad_button.dart';

class SimplePriorityCalculatorPad extends StatelessWidget {
  const SimplePriorityCalculatorPad({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridPad(
      gridPadCells: GridPadCellsBuilder(rowCount: 5, columnCount: 5)
          .rowSize(0, const Fixed(48))
          .build(),
      children: [
        MediumTextPadButton('C', onPressed: () {}),
        Cell.explicit(
          columnSpan: 2,
          child: MediumTextPadButton('(', onPressed: () {}),
        ),
        Cell.explicit(
          columnSpan: 2,
          child: MediumTextPadButton(')', onPressed: () {}),
        ),
        LargeTextPadButton('7', onPressed: () {}),
        LargeTextPadButton('8', onPressed: () {}),
        LargeTextPadButton('9', onPressed: () {}),
        LargeTextPadButton('×', onPressed: () {}),
        LargeTextPadButton('÷', onPressed: () {}),
        LargeTextPadButton('4', onPressed: () {}),
        LargeTextPadButton('5', onPressed: () {}),
        LargeTextPadButton('6', onPressed: () {}),
        Cell.explicit(
          rowSpan: 2,
          child: LargeTextPadButton('-', onPressed: () {}),
        ),
        Cell.explicit(
          rowSpan: 2,
          child: LargeTextPadButton('+', onPressed: () {}),
        ),
        Cell(
          row: 3,
          column: 0,
          child: LargeTextPadButton('1', onPressed: () {}),
        ),
        LargeTextPadButton('2', onPressed: () {}),
        LargeTextPadButton('3', onPressed: () {}),
        Cell(
          row: 4,
          column: 0,
          child: LargeTextPadButton('0', onPressed: () {}),
        ),
        LargeTextPadButton('.', onPressed: () {}),
        IconPadButton(Icons.backspace, onPressed: () {}),
        Cell.explicit(
          columnSpan: 2,
          child: LargeTextPadButton('=', onPressed: () {}),
        ),
      ],
    );
  }
}
