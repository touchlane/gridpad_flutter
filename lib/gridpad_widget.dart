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
import 'package:flutter/widgets.dart';

import 'gridpad_cells.dart';
import 'placement.dart';

class Cell extends StatelessWidget {
  final int row;
  final int column;
  final int rowSpan;
  final int columnSpan;
  final bool _implicitly;
  final Widget child;

  const Cell({
    Key? key,
    required this.row,
    required this.column,
    this.rowSpan = 1,
    this.columnSpan = 1,
    required this.child,
  })  : _implicitly = false,
        assert(rowSpan > 0),
        assert(columnSpan > 0),
        super(key: key);

  const Cell.explicit({
    Key? key,
    this.rowSpan = 1,
    this.columnSpan = 1,
    required this.child,
  })  : _implicitly = true,
        row = 0,
        column = 0,
        assert(rowSpan > 0),
        assert(columnSpan > 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return child;
  }
}

class _GridPadDelegate extends MultiChildLayoutDelegate {
  final GridPadCells cells;
  final List<GridPadContent> content;
  final TextDirection direction;

  _GridPadDelegate(this.cells, this.content, this.direction);

  @override
  void performLayout(Size size) {
    final cellPlaces = calculateCellPlaces(cells, size.width, size.height);
    content.forEachIndexed((index, item) {
      double maxWidth = 0;
      for (var column = item.left; column <= item.right; column++) {
        maxWidth += cellPlaces[item.top][column].width;
      }
      double maxHeight = 0;
      for (var row = item.top; row <= item.bottom; row++) {
        maxHeight += cellPlaces[row][item.left].height;
      }
      layoutChild(
        index,
        BoxConstraints(maxHeight: maxHeight, maxWidth: maxWidth),
      );
      final cellPlace = cellPlaces[item.top][item.left];
      if (direction == TextDirection.ltr) {
        positionChild(index, Offset(cellPlace.x, cellPlace.y));
      } else {
        positionChild(
          index,
          Offset(size.width - cellPlace.x - cellPlace.width, cellPlace.y),
        );
      }
    });
  }

  @override
  bool shouldRelayout(covariant _GridPadDelegate oldDelegate) {
    // First - do fast check (only count), after - full comparing
    return direction != oldDelegate.direction ||
        cells.rowCount != oldDelegate.cells.rowCount ||
        cells.columnCount != oldDelegate.cells.columnCount ||
        cells != oldDelegate.cells;
  }

  List<List<_CellPlaceInfo>> calculateCellPlaces(
    GridPadCells cells,
    double width,
    double height,
  ) {
    final cellWidths = calculateSizesForDimension(
      width,
      cells.columnSizes,
      cells.columnsTotalSize,
    );
    final cellHeights = calculateSizesForDimension(
      height,
      cells.rowSizes,
      cells.rowsTotalSize,
    );
    double y = 0;
    return cellHeights.map((cellHeight) {
      double x = 0;
      double cellY = y;
      y += cellHeight;
      return cellWidths.map((cellWidth) {
        double cellX = x;
        x += cellWidth;
        return _CellPlaceInfo(
          x: cellX,
          y: cellY,
          width: cellWidth,
          height: cellHeight,
        );
      }).toList();
    }).toList();
  }

  List<double> calculateSizesForDimension(
    double availableSize,
    List<GridPadCellSize> cellSizes,
    TotalSize totalSize,
  ) {
    final availableWeight = availableSize - totalSize.fixed;
    return cellSizes.map((cellSize) {
      switch (cellSize.runtimeType) {
        case Fixed:
          return (cellSize as Fixed).size;
        case Weight:
          return availableWeight * (cellSize as Weight).size / totalSize.weight;
        default:
          throw ArgumentError(
            "Unknown type of cell size: ${cellSize.runtimeType}",
          );
      }
    }).toList();
  }
}

class GridPad extends StatelessWidget {
  final GridPadCells gridPadCells;
  final List<GridPadContent> _content = [];
  final GridPadPlacementPolicy placementPolicy;
  final PlacementStrategy _placementStrategy;

  GridPad({
    Key? key,
    required this.gridPadCells,
    required List<Widget> children,
    this.placementPolicy = GridPadPlacementPolicy.defaultPolicy,
  })  : _placementStrategy = GridPlacementStrategy(
          gridPadCells,
          placementPolicy,
        ),
        super(key: key) {
    for (var contentCell in children) {
      final Cell cell;
      if (contentCell is Cell) {
        cell = contentCell;
      } else {
        cell = Cell.explicit(child: contentCell);
      }
      if (cell._implicitly) {
        _placementStrategy.placeImplicitly(
          rowSpan: cell.rowSpan,
          columnSpan: cell.columnSpan,
          content: cell.child,
        );
      } else {
        _placementStrategy.placeExplicitly(
          row: cell.row,
          column: cell.column,
          rowSpan: cell.rowSpan,
          columnSpan: cell.columnSpan,
          content: cell.child,
        );
      }
    }
    _content.addAll(_placementStrategy.content);
  }

  @override
  Widget build(BuildContext context) {
    return CustomMultiChildLayout(
      delegate: _GridPadDelegate(
        gridPadCells,
        _content,
        Directionality.of(context),
      ),
      children: <Widget>[
        for (var i = 0; i < _content.length; i++)
          LayoutId(
            id: i,
            child: _content[i].content,
          ),
      ],
    );
  }
}

/// Stores information about the position and size of the cell
/// in the parent bounds.
class _CellPlaceInfo {
  /// x position.
  final double x;

  /// y position.
  final double y;

  /// Cell width.
  final double width;

  /// Cell height.
  final double height;

  const _CellPlaceInfo({
    required this.x,
    required this.y,
    required this.width,
    required this.height,
  });
}
