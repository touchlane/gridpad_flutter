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

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import '../gridpad_widget.dart';

@protected
class CellParentData extends ContainerBoxParentData<RenderBox> {
  int? row;
  int? column;
  int? rowSpan;
  int? columnSpan;
  bool? implicitly;

  @override
  String toString() {
    return '${super.toString()}; row=$row; column=$column; rowSpan=$rowSpan; columnSpan=$columnSpan; implicitly=$implicitly';
  }
}

@protected
class Cell extends ParentDataWidget<CellParentData> {
  final int row;
  final int column;
  final int rowSpan;
  final int columnSpan;
  final bool _implicitly;

  const Cell({
    super.key,
    required this.row,
    required this.column,
    this.rowSpan = 1,
    this.columnSpan = 1,
    required super.child,
  })  : _implicitly = false,
        assert(rowSpan > 0),
        assert(columnSpan > 0);

  const Cell.explicit({
    super.key,
    this.rowSpan = 1,
    this.columnSpan = 1,
    required super.child,
  })  : _implicitly = true,
        row = 0,
        column = 0,
        assert(rowSpan > 0),
        assert(columnSpan > 0);

  @override
  void applyParentData(RenderObject renderObject) {
    assert(renderObject.parentData is CellParentData);
    final CellParentData parentData =
        renderObject.parentData! as CellParentData;
    bool needsLayout = false;

    if (parentData.row != row) {
      parentData.row = row;
      needsLayout = true;
    }

    if (parentData.column != column) {
      parentData.column = column;
      needsLayout = true;
    }

    if (parentData.rowSpan != rowSpan) {
      parentData.rowSpan = rowSpan;
      needsLayout = true;
    }

    if (parentData.columnSpan != columnSpan) {
      parentData.columnSpan = columnSpan;
      needsLayout = true;
    }

    if (parentData.implicitly != _implicitly) {
      parentData.implicitly = _implicitly;
      needsLayout = true;
    }

    if (needsLayout) {
      final AbstractNode? targetParent = renderObject.parent;
      if (targetParent is RenderObject) {
        targetParent.markNeedsLayout();
      }
    }
  }

  @override
  Type get debugTypicalAncestorWidgetClass => GridPad;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IntProperty('row', row))
      ..add(IntProperty('column', column))
      ..add(IntProperty('rowSpan', rowSpan))
      ..add(IntProperty('columnSpan', columnSpan))
      ..add(FlagProperty('implicitly', value: _implicitly));
  }
}
