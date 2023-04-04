/*
 * MIT License
 *
 * Copyright (c) 2023 Touchlane LLC tech@touchlane.com
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gridpad/gridpad_cells.dart';

class Cell {
  final Widget child;
  final int row;
  final int column;
  final int rowSpan;
  final int columnSpan;
  final bool _implicitly;

  const Cell({
    required this.row,
    required this.column,
    this.rowSpan = 1,
    this.columnSpan = 1,
    required this.child,
  }) : _implicitly = false;

  const Cell.explicit({
    this.rowSpan = 1,
    this.columnSpan = 1,
    required this.child,
  })  : _implicitly = true,
        row = 0,
        column = 0;
}

class _GridPadDelegate extends MultiChildLayoutDelegate {
  final GridPadCells gridPadCells;

  _GridPadDelegate(this.gridPadCells);

  @override
  void performLayout(Size size) {}

  @override
  bool shouldRelayout(covariant _GridPadDelegate oldDelegate) {
    // First - do fast check (only count), after - full comparing
    return gridPadCells.rowCount != oldDelegate.gridPadCells.rowCount ||
        gridPadCells.columnCount != oldDelegate.gridPadCells.columnCount ||
        gridPadCells != oldDelegate.gridPadCells;
  }
}

class GridPad extends StatelessWidget {
  final GridPadCells gridPadCells;
  final List<Cell> children;

  const GridPad({
    Key? key,
    required this.gridPadCells,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomMultiChildLayout(
      delegate: _GridPadDelegate(gridPadCells),
      children: <Widget>[
        for (var i = 0; i < children.length; i++)
          LayoutId(
            id: i,
            child: children[i].child,
          ),
      ],
    );
  }
}
