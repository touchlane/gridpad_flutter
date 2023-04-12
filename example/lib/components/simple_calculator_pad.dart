import 'package:example/components/pad_button.dart';
import 'package:flutter/material.dart';
import 'package:grid_pad/grid_pad_cells.dart';
import 'package:grid_pad/grid_pad_widget.dart';

class SimpleCalculatorPad extends StatelessWidget {
  const SimpleCalculatorPad({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridPad(
      gridPadCells: GridPadCellsBuilder(rowCount: 5, columnCount: 4).build(),
      children: [
        Cell.explicit(child: LargeTextPadButton('C', onPressed: () {})),
        Cell.explicit(child: LargeTextPadButton('÷', onPressed: () {})),
        Cell.explicit(child: LargeTextPadButton('×', onPressed: () {})),
        Cell.explicit(child: IconPadButton(Icons.backspace, onPressed: () {})),
        Cell.explicit(child: LargeTextPadButton('7', onPressed: () {})),
        Cell.explicit(child: LargeTextPadButton('8', onPressed: () {})),
        Cell.explicit(child: LargeTextPadButton('9', onPressed: () {})),
        Cell.explicit(child: LargeTextPadButton('-', onPressed: () {})),
        Cell.explicit(child: LargeTextPadButton('4', onPressed: () {})),
        Cell.explicit(child: LargeTextPadButton('5', onPressed: () {})),
        Cell.explicit(child: LargeTextPadButton('6', onPressed: () {})),
        Cell.explicit(child: LargeTextPadButton('+', onPressed: () {})),
        Cell.explicit(child: LargeTextPadButton('1', onPressed: () {})),
        Cell.explicit(child: LargeTextPadButton('2', onPressed: () {})),
        Cell.explicit(child: LargeTextPadButton('3', onPressed: () {})),
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
