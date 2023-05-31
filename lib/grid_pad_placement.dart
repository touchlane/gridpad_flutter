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

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:grid_pad/grid_pad_diagnostic.dart';

import 'grid_pad_cells.dart';

/// Implicit placement policy for items.
///
/// There are two major types of settings here: the main axis of placement
/// presented by the [mainAxis] property and the direction of placement
/// presented by [horizontalPolicy] and [verticalPolicy] properties.
///
/// The [mainAxis] property describes which axis would be used to find
/// the next position. For example, [Axis.horizontal] means that firstly
/// next position will look in a current row and if there isn't a place
/// for the item algorithm will move to the next row.
///
/// The [horizontalPolicy] property describes the direction for choosing
/// the next item on the horizontal axis: left or right side,
/// depending on LTR or RTL settings.
///
/// The [verticalPolicy] property describes the direction for choosing
/// the next item on the vertical axis: above or below.
class GridPadPlacementPolicy {
  static const GridPadPlacementPolicy defaultPolicy =
      GridPadPlacementPolicy._anchor(
    mainAxis: Axis.horizontal,
    horizontalPolicy: HorizontalPolicy.startEnd,
    verticalPolicy: VerticalPolicy.topBottom,
    anchor: GridPadSpanAnchor(
      horizontal: HorizontalAnchor.start,
      vertical: VerticalAnchor.top,
    ),
  );

  /// the main axis for selecting the next location
  final Axis mainAxis;

  /// horizontal placement policy
  final HorizontalPolicy horizontalPolicy;

  /// vertical placement policy
  final VerticalPolicy verticalPolicy;

  /// Anchor for spanned cells.
  final GridPadSpanAnchor anchor;

  GridPadPlacementPolicy({
    this.mainAxis = Axis.horizontal,
    this.horizontalPolicy = HorizontalPolicy.startEnd,
    this.verticalPolicy = VerticalPolicy.topBottom,
  }) : anchor = GridPadSpanAnchor._ofDirection(
          horizontalPolicy,
          verticalPolicy,
        );

  const GridPadPlacementPolicy._anchor({
    required this.mainAxis,
    required this.horizontalPolicy,
    required this.verticalPolicy,
    required this.anchor,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GridPadPlacementPolicy &&
          runtimeType == other.runtimeType &&
          mainAxis == other.mainAxis &&
          horizontalPolicy == other.horizontalPolicy &&
          verticalPolicy == other.verticalPolicy &&
          anchor == other.anchor;

  @override
  int get hashCode =>
      mainAxis.hashCode ^
      horizontalPolicy.hashCode ^
      verticalPolicy.hashCode ^
      anchor.hashCode;
}

/// Horizontal placement policy.
enum HorizontalPolicy { startEnd, endStart }

/// Vertical placement policy.
enum VerticalPolicy { topBottom, bottomTop }

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
    HorizontalPolicy horizontal,
    VerticalPolicy vertical,
  ) {
    final HorizontalAnchor horizontalAnchor;
    switch (horizontal) {
      case HorizontalPolicy.startEnd:
        horizontalAnchor = HorizontalAnchor.start;
        break;
      case HorizontalPolicy.endStart:
        horizontalAnchor = HorizontalAnchor.end;
        break;
    }
    final VerticalAnchor verticalAnchor;
    switch (vertical) {
      case VerticalPolicy.topBottom:
        verticalAnchor = VerticalAnchor.top;
        break;
      case VerticalPolicy.bottomTop:
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
  final GridPadCells _cells;
  final GridPadPlacementPolicy _placementPolicy;
  final List<GridPadContent> _content = [];

  List<GridPadContent> get content => _content.toList();

  PlacementStrategy(this._cells, this._placementPolicy);

  placeImplicitly({
    required int rowSpan,
    required int columnSpan,
    required Widget content,
  });

  placeExplicitly({
    required int row,
    required int column,
    required int rowSpan,
    required int columnSpan,
    required Widget content,
  }) {
    final anchor = _placementPolicy.anchor;
    final rowOutside = _cells.isRowOutsideOfGrid(row, rowSpan, anchor);
    final columnOutside =
        _cells.isColumnOutsideOfGrid(column, columnSpan, anchor);
    if (rowOutside || columnOutside) {
      onSkipped(
        row: row,
        column: column,
        rowSpan: rowSpan,
        columnSpan: columnSpan,
      );
    } else {
      onPlaced(
        left: anchor.leftBound(column, columnSpan),
        top: anchor.topBound(row, rowSpan),
        right: anchor.rightBound(column, columnSpan),
        bottom: anchor.bottomBound(row, rowSpan),
        content: content,
      );
    }
  }

  onSkipped({
    required int row,
    required int column,
    required int rowSpan,
    required int columnSpan,
  }) {
    GridPadDiagnosticLogger().onItemSkipped(
      "Skipped position: [${row}x$column], span size: [${rowSpan}x$columnSpan]\nGrid size: [${_cells.rowCount}x${_cells.columnCount}]",
    );
  }

  onPlaced({
    required int left,
    required int top,
    required int right,
    required int bottom,
    required Widget content,
  }) {
    _content.add(GridPadContent(
      left: left,
      top: top,
      right: right,
      bottom: bottom,
      content: content,
    ));
  }

  int findCurrentRow(
    GridPadCells cells,
    GridPadPlacementPolicy placementPolicy,
    GridPadContent? lastItem,
  ) {
    if (lastItem == null) {
      return cells.firstRow(placementPolicy);
    }
    switch (placementPolicy.verticalPolicy) {
      case VerticalPolicy.topBottom:
        return lastItem.top;
      case VerticalPolicy.bottomTop:
        return lastItem.bottom;
    }
  }

  int findCurrentColumn(
    GridPadCells cells,
    GridPadPlacementPolicy placementPolicy,
    GridPadContent? lastItem,
  ) {
    if (lastItem == null) {
      return cells.firstColumn(placementPolicy);
    }
    switch (placementPolicy.horizontalPolicy) {
      case HorizontalPolicy.startEnd:
        return lastItem.left;
      case HorizontalPolicy.endStart:
        return lastItem.right;
    }
  }
}

class GridPlacementStrategy extends PlacementStrategy {
  GridPlacementStrategy(super.cells, super.placementPolicy);

  @override
  placeImplicitly({
    required int rowSpan,
    required int columnSpan,
    required Widget content,
  }) {
    final anchor = _placementPolicy.anchor;
    final lastItem = _content.lastOrNull;
    int row;
    int column;
    switch (_placementPolicy.mainAxis) {
      case Axis.horizontal:
        row = findCurrentRow(_cells, _placementPolicy, lastItem);
        column = findNextColumn(_cells, _placementPolicy, lastItem);
        if (_cells.isColumnOutsideOfGrid(column, columnSpan, anchor)) {
          column = _cells.firstColumn(_placementPolicy);
          row = findNextRow(_cells, _placementPolicy, lastItem);
        }
        break;
      case Axis.vertical:
        column = findCurrentColumn(_cells, _placementPolicy, lastItem);
        row = findNextRow(_cells, _placementPolicy, lastItem);
        if (_cells.isRowOutsideOfGrid(row, rowSpan, anchor)) {
          row = _cells.firstRow(_placementPolicy);
          column = findNextColumn(_cells, _placementPolicy, lastItem);
        }
        break;
    }
    placeExplicitly(
      row: row,
      column: column,
      rowSpan: rowSpan,
      columnSpan: columnSpan,
      content: content,
    );
  }

  int findNextRow(
    GridPadCells cells,
    GridPadPlacementPolicy placementPolicy,
    GridPadContent? lastItem,
  ) {
    final lastRow = findCurrentRow(cells, placementPolicy, lastItem);
    final lastFowSpan = lastItem?.rowSpan ?? 0;
    switch (placementPolicy.verticalPolicy) {
      case VerticalPolicy.topBottom:
        return lastRow + lastFowSpan;
      case VerticalPolicy.bottomTop:
        return lastRow - lastFowSpan;
    }
  }

  int findNextColumn(
    GridPadCells cells,
    GridPadPlacementPolicy placementPolicy,
    GridPadContent? lastItem,
  ) {
    final lastColumn = findCurrentColumn(cells, placementPolicy, lastItem);
    final lastColumnSpan = lastItem?.columnSpan ?? 0;
    switch (placementPolicy.horizontalPolicy) {
      case HorizontalPolicy.startEnd:
        return lastColumn + lastColumnSpan;
      case HorizontalPolicy.endStart:
        return lastColumn - lastColumnSpan;
    }
  }
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
    switch (placementPolicy.verticalPolicy) {
      case VerticalPolicy.topBottom:
        return 0;
      case VerticalPolicy.bottomTop:
        return rowCount - 1;
    }
  }

  /// Returns the first column index for a specific grid,
  /// depends on the [placementPolicy].
  int firstColumn(GridPadPlacementPolicy placementPolicy) {
    switch (placementPolicy.horizontalPolicy) {
      case HorizontalPolicy.startEnd:
        return 0;
      case HorizontalPolicy.endStart:
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
