import 'package:flutter/material.dart';
import 'package:grid_pad/gridpad_cells.dart';
import 'package:grid_pad/gridpad_widget.dart';
import 'package:grid_pad/placement.dart';

import 'pad_button.dart';

class PinPad extends StatelessWidget {
  final PadActionCallback? callback;

  const PinPad({Key? key, this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridPad(
      gridPadCells: GridPadCells.gridSize(rowCount: 4, columnCount: 3),
      placementPolicy: GridPadPlacementPolicy(
        verticalPolicy: VerticalPolicy.bottomTop,
      ),
      children: [
        Cell(
          row: 3,
          column: 1,
          child: LargeTextPadButton('0', onPressed: () => callback?.call('0')),
        ),
        Cell.explicit(
          child: IconPadButton(
            Icons.backspace,
            onPressed: () => callback?.call('r'),
          ),
        ),
        Cell.explicit(
          child: LargeTextPadButton('1', onPressed: () => callback?.call('1')),
        ),
        Cell.explicit(
          child: LargeTextPadButton('2', onPressed: () => callback?.call('2')),
        ),
        Cell.explicit(
          child: LargeTextPadButton('3', onPressed: () => callback?.call('3')),
        ),
        Cell.explicit(
          child: LargeTextPadButton('4', onPressed: () => callback?.call('4')),
        ),
        Cell.explicit(
          child: LargeTextPadButton('5', onPressed: () => callback?.call('5')),
        ),
        Cell.explicit(
          child: LargeTextPadButton('6', onPressed: () => callback?.call('6')),
        ),
        Cell.explicit(
          child: LargeTextPadButton('7', onPressed: () => callback?.call('7')),
        ),
        Cell.explicit(
          child: LargeTextPadButton('8', onPressed: () => callback?.call('8')),
        ),
        Cell.explicit(
          child: LargeTextPadButton('9', onPressed: () => callback?.call('9')),
        ),
      ],
    );
  }
}

typedef PadActionCallback = void Function(String action);
