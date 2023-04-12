import 'package:flutter/material.dart';
import 'package:grid_pad/grid_pad_cells.dart';
import 'package:grid_pad/grid_pad_widget.dart';

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
        Cell.explicit(
          child: MediumTextPadButton('C', onPressed: () {}),
        ),
        Cell.explicit(
          columnSpan: 2,
          child: MediumTextPadButton('(', onPressed: () {}),
        ),
        Cell.explicit(
          columnSpan: 2,
          child: MediumTextPadButton(')', onPressed: () {}),
        ),
        Cell.explicit(
          child: LargeTextPadButton('7', onPressed: () {}),
        ),
        Cell.explicit(
          child: LargeTextPadButton('8', onPressed: () {}),
        ),
        Cell.explicit(
          child: LargeTextPadButton('9', onPressed: () {}),
        ),
        Cell.explicit(
          child: LargeTextPadButton('×', onPressed: () {}),
        ),
        Cell.explicit(
          child: LargeTextPadButton('÷', onPressed: () {}),
        ),
        Cell.explicit(
          child: LargeTextPadButton('4', onPressed: () {}),
        ),
        Cell.explicit(
          child: LargeTextPadButton('5', onPressed: () {}),
        ),
        Cell.explicit(
          child: LargeTextPadButton('6', onPressed: () {}),
        ),
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
        Cell.explicit(
          child: LargeTextPadButton('2', onPressed: () {}),
        ),
        Cell.explicit(
          child: LargeTextPadButton('3', onPressed: () {}),
        ),
        Cell(
          row: 4,
          column: 0,
          child: LargeTextPadButton('0', onPressed: () {}),
        ),
        Cell.explicit(
          child: LargeTextPadButton('.', onPressed: () {}),
        ),
        Cell.explicit(
          child: IconPadButton(Icons.backspace, onPressed: () {}),
        ),
        Cell.explicit(
          columnSpan: 2,
          child: LargeTextPadButton('=', onPressed: () {}),
        ),
      ],
    );
  }
}
