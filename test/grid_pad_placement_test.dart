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

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grid_pad/grid_pad_placement.dart';

void main() {
  test('Check equals and hashCode for the same GridPadPlacementPolicy', () {
    final left = GridPadPlacementPolicy(
      mainAxis: Axis.horizontal,
      verticalPolicy: VerticalPolicy.topBottom,
      horizontalPolicy: HorizontalPolicy.endStart,
    );
    final right = GridPadPlacementPolicy(
      mainAxis: Axis.horizontal,
      verticalPolicy: VerticalPolicy.topBottom,
      horizontalPolicy: HorizontalPolicy.endStart,
    );
    expect(left.hashCode, right.hashCode);
    expect(left, right);
  });

  test('Check equals and hashCode for the same GridPadSpanAnchor ', () {
    // ignore: prefer_const_constructors
    final left = GridPadSpanAnchor(
      horizontal: HorizontalAnchor.start,
      vertical: VerticalAnchor.bottom,
    );
    // ignore: prefer_const_constructors
    final right = GridPadSpanAnchor(
      horizontal: HorizontalAnchor.start,
      vertical: VerticalAnchor.bottom,
    );
    expect(left.hashCode, right.hashCode);
    expect(left, right);
  });

  test('Test anchor default initialization', () {
    final policy = GridPadPlacementPolicy();
    expect(
        policy.anchor,
        const GridPadSpanAnchor(
          horizontal: HorizontalAnchor.start,
          vertical: VerticalAnchor.top,
        ));
  });

  test('Test anchor top start', () {
    final policy = GridPadPlacementPolicy(
      horizontalPolicy: HorizontalPolicy.startEnd,
      verticalPolicy: VerticalPolicy.topBottom,
    );
    expect(
        policy.anchor,
        const GridPadSpanAnchor(
          horizontal: HorizontalAnchor.start,
          vertical: VerticalAnchor.top,
        ));
  });

  test('Test anchor top end', () {
    final policy = GridPadPlacementPolicy(
      horizontalPolicy: HorizontalPolicy.endStart,
      verticalPolicy: VerticalPolicy.topBottom,
    );
    expect(
        policy.anchor,
        const GridPadSpanAnchor(
          horizontal: HorizontalAnchor.end,
          vertical: VerticalAnchor.top,
        ));
  });

  test('Test anchor bottom end', () {
    final policy = GridPadPlacementPolicy(
      horizontalPolicy: HorizontalPolicy.endStart,
      verticalPolicy: VerticalPolicy.bottomTop,
    );
    expect(
        policy.anchor,
        const GridPadSpanAnchor(
          horizontal: HorizontalAnchor.end,
          vertical: VerticalAnchor.bottom,
        ));
  });

  test('Test anchor bottom start', () {
    final policy = GridPadPlacementPolicy(
      horizontalPolicy: HorizontalPolicy.startEnd,
      verticalPolicy: VerticalPolicy.bottomTop,
    );
    expect(
        policy.anchor,
        const GridPadSpanAnchor(
          horizontal: HorizontalAnchor.start,
          vertical: VerticalAnchor.bottom,
        ));
  });
}
