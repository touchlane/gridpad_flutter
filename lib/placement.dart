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
import 'package:gridpad/gridpad_widget.dart';

import 'gridpad_cells.dart';

/// Implicit placement policy for items.
///
/// There are two major types of settings here: the main axis of placement
/// presented by the [mainAxis] property and the direction of placement
/// presented by [horizontalDirection] and [verticalDirection] properties.
///
/// The [mainAxis] property describes which axis would be used to find
/// the next position. For example, [Axis.horizontal] means that firstly
/// next position will look in a current row and if there isn't a place
/// for the item algorithm will move to the next row.
///
/// The [horizontalDirection] property describes the direction for choosing
/// the next item on the horizontal axis: left or right side,
/// depending on LTR or RTL settings.
///
/// The [verticalDirection] property describes the direction for choosing
/// the next item on the vertical axis: above or below.
class GridPadPlacementPolicy {
  /// the main axis for selecting the next location
  final Axis mainAxis;

  /// horizontal placement policy
  final HorizontalDirection horizontalDirection;

  /// vertical placement policy
  final VerticalDirection verticalDirection;

  /// Anchor for spanned cells.
  final GridPadSpanAnchor anchor;

  GridPadPlacementPolicy({
    this.mainAxis = Axis.horizontal,
    this.horizontalDirection = HorizontalDirection.startEnd,
    this.verticalDirection = VerticalDirection.topBottom,
  }) : anchor = GridPadSpanAnchor._ofDirection(
          horizontalDirection,
          verticalDirection,
        );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GridPadPlacementPolicy &&
          runtimeType == other.runtimeType &&
          mainAxis == other.mainAxis &&
          horizontalDirection == other.horizontalDirection &&
          verticalDirection == other.verticalDirection &&
          anchor == other.anchor;

  @override
  int get hashCode =>
      mainAxis.hashCode ^
      horizontalDirection.hashCode ^
      verticalDirection.hashCode ^
      anchor.hashCode;
}

/// Horizontal placement policy.
enum HorizontalDirection { startEnd, endStart }

/// Vertical placement policy.
enum VerticalDirection { topBottom, bottomTop }

/// Anchor for spanned cells.
class GridPadSpanAnchor {
  final HorizontalAnchor horizontal;
  final VerticalAnchor vertical;

  const GridPadSpanAnchor({
    required this.horizontal,
    required this.vertical,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GridPadSpanAnchor &&
          runtimeType == other.runtimeType &&
          horizontal == other.horizontal &&
          vertical == other.vertical;

  @override
  int get hashCode => horizontal.hashCode ^ vertical.hashCode;

  static GridPadSpanAnchor _ofDirection(
    HorizontalDirection horizontal,
    VerticalDirection vertical,
  ) {
    final HorizontalAnchor horizontalAnchor;
    switch (horizontal) {
      case HorizontalDirection.startEnd:
        horizontalAnchor = HorizontalAnchor.start;
        break;
      case HorizontalDirection.endStart:
        horizontalAnchor = HorizontalAnchor.end;
        break;
    }
    final VerticalAnchor verticalAnchor;
    switch (vertical) {
      case VerticalDirection.topBottom:
        verticalAnchor = VerticalAnchor.top;
        break;
      case VerticalDirection.bottomTop:
        verticalAnchor = VerticalAnchor.bottom;
        break;
    }
    return GridPadSpanAnchor(
        horizontal: horizontalAnchor, vertical: verticalAnchor);
  }
}

/// Horizontal anchor position for cells.
enum HorizontalAnchor { start, end }

/// Vertical anchor position for cells.
enum VerticalAnchor { top, bottom }

abstract class PlacementStrategy {
  final GridPadPlacementPolicy placementPolicy;
  final List<Cell> _cells = [];

  PlacementStrategy({
    required this.placementPolicy,
  });

  placeExplicitly(Cell cell) {
    final anchor = placementPolicy.anchor;
  }
}

class GridPlacementStrategy {

}

class GridPadContent {
  final int left;
  final int top;
  final int right;
  final int bottom;
  final int rowSpan;
  final int columnSpan;
  final Widget content;

  const GridPadContent({
    required this.left,
    required this.top,
    required this.right,
    required this.bottom,
    required this.content,
  })  : rowSpan = bottom - top + 1,
        columnSpan = right - left + 1;
}

extension GridPadCellsExt on GridPadCells {
  /// Returns the first row index for a specific grid,
  /// depends on the [placementPolicy].
  int firstRow(GridPadPlacementPolicy placementPolicy) {
    switch (placementPolicy.verticalDirection) {
      case VerticalDirection.topBottom:
        return 0;
      case VerticalDirection.bottomTop:
        return rowCount - 1;
    }
  }

  /// Returns the first column index for a specific grid,
  /// depends on the [placementPolicy].
  int firstColumn(GridPadPlacementPolicy placementPolicy) {
    switch (placementPolicy.horizontalDirection) {
      case HorizontalDirection.startEnd:
        return 0;
      case HorizontalDirection.endStart:
        return columnCount - 1;
    }
  }

  /// Checks if the [row] with the span = [rowSpan] and specific [anchor]
  /// is outside the defined grid.
  bool isRowOutsideOfGrid(int row, int rowSpan, GridPadSpanAnchor anchor) {
    final top = anchor.topBound(row, rowSpan);
    final bottom = anchor.bottomBound(row, rowSpan);
    return top < 0 || bottom >= rowCount;
  }

  /// Checks if the [column] with the span = [columnSpan] and specific [anchor]
  /// is outside the defined grid.
  bool isColumnOutsideOfGrid(
      int column, int columnSpan, GridPadSpanAnchor anchor) {
    final left = anchor.leftBound(column, columnSpan);
    final right = anchor.bottomBound(column, columnSpan);
    return left < 0 || right >= columnCount;
  }
}

extension GridPadSpanAnchorExt on GridPadSpanAnchor {
  /// Left column index for a specific [column] and [span] base on
  /// the caller anchor.
  int leftBound(int column, int span) {
    switch (horizontal) {
      case HorizontalAnchor.start:
        return column;
      case HorizontalAnchor.end:
        return column - span + 1;
    }
  }

  /// Right column index for a specific [column] and [span] base on
  /// the caller anchor.
  int rightBound(int column, int span) {
    switch (horizontal) {
      case HorizontalAnchor.start:
        return column + span - 1;
      case HorizontalAnchor.end:
        return column;
    }
  }

  /// Top row index for a specific [row] and [span] base on the caller anchor.
  int topBound(int row, int span) {
    switch (vertical) {
      case VerticalAnchor.top:
        return row;
      case VerticalAnchor.bottom:
        return row - span + 1;
    }
  }

  /// Bottom row index for a specific [row] and [span] base on the caller anchor.
  int bottomBound(int row, int span) {
    switch (vertical) {
      case VerticalAnchor.top:
        return row + span - 1;
      case VerticalAnchor.bottom:
        return row;
    }
  }
}
