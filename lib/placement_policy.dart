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
  final Anchor anchor;

  GridPadPlacementPolicy({
    this.mainAxis = Axis.horizontal,
    this.horizontalDirection = HorizontalDirection.startEnd,
    this.verticalDirection = VerticalDirection.topBottom,
  }) : anchor = Anchor._ofDirection(horizontalDirection, verticalDirection);
}

/// Horizontal placement policy.
enum HorizontalDirection { startEnd, endStart }

/// Vertical placement policy.
enum VerticalDirection { topBottom, bottomTop }

/// Anchor for spanned cells.
class Anchor {
  final HorizontalAnchor horizontal;
  final VerticalAnchor vertical;

  const Anchor({
    required this.horizontal,
    required this.vertical,
  });

  static Anchor _ofDirection(
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
    return Anchor(horizontal: horizontalAnchor, vertical: verticalAnchor);
  }
}

/// Horizontal anchor position for cells.
enum HorizontalAnchor { start, end }

/// Vertical anchor position for cells.
enum VerticalAnchor { top, bottom }
