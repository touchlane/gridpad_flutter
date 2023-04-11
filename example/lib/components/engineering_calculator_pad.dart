import 'package:example/components/pad_button.dart';
import 'package:flutter/material.dart';
import 'package:grid_pad/gridpad_cells.dart';
import 'package:grid_pad/gridpad_widget.dart';

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
        Cell.explicit(
          child: SmallTextPadButton('cos', onPressed: () {}),
        ),
        Cell.explicit(
          child: SmallTextPadButton('log', onPressed: () {}),
        ),
        Cell.explicit(
          child: SmallTextPadButton('π', onPressed: () {}),
        ),
        Cell.explicit(
          child: SmallTextPadButton('√', onPressed: () {}),
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
          child: LargeTextPadButton('(', onPressed: () {}),
        ),
        Cell.explicit(
          child: LargeTextPadButton(')', onPressed: () {}),
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
          child: LargeTextPadButton('×', onPressed: () {}),
        ),
        Cell.explicit(
          child: LargeTextPadButton('÷', onPressed: () {}),
        ),
        Cell.explicit(
          child: LargeTextPadButton('1', onPressed: () {}),
        ),
        Cell.explicit(
          child: LargeTextPadButton('2', onPressed: () {}),
        ),
        Cell.explicit(
          child: LargeTextPadButton('3', onPressed: () {}),
        ),
        Cell.explicit(
          child: LargeTextPadButton('-', onPressed: () {}),
        ),
        Cell.explicit(
          child: LargeTextPadButton('+', onPressed: () {}),
        ),
        Cell.explicit(
          child: LargeTextPadButton('C', onPressed: () {}),
        ),
        Cell.explicit(
          child: LargeTextPadButton('.', onPressed: () {}),
        ),
        Cell.explicit(
          child: LargeTextPadButton('0', onPressed: () {}),
        ),
        Cell.explicit(
          child: IconPadButton(Icons.backspace, onPressed: () {}),
        ),
        Cell.explicit(
          child: LargeTextPadButton('=', onPressed: () {}),
        ),
      ],
    );
  }
}
