import 'package:flutter/material.dart';
import 'package:grid_pad/grid_pad.dart';

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
        IconPadButton(
          Icons.backspace,
          onPressed: () => callback?.call('r'),
        ),
        LargeTextPadButton('1', onPressed: () => callback?.call('1')),
        LargeTextPadButton('2', onPressed: () => callback?.call('2')),
        LargeTextPadButton('3', onPressed: () => callback?.call('3')),
        LargeTextPadButton('4', onPressed: () => callback?.call('4')),
        LargeTextPadButton('5', onPressed: () => callback?.call('5')),
        LargeTextPadButton('6', onPressed: () => callback?.call('6')),
        LargeTextPadButton('7', onPressed: () => callback?.call('7')),
        LargeTextPadButton('8', onPressed: () => callback?.call('8')),
        LargeTextPadButton('9', onPressed: () => callback?.call('9')),
      ],
    );
  }
}

typedef PadActionCallback = void Function(String action);
