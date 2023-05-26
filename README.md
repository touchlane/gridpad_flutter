# GridPad Flutter layout

**GridPad** is a Flutter library that allows you to place UI elements in a predefined grid,
manage spans in two dimensions, have flexible controls to manage row and column sizes.

# Usage

GridPad is inspired by Row and Column APIs, which makes its use intuitive.

Key features and limitations:

* Follows slot API concept.
* Not lazy. All content will be measured and placed instantly.
* GridPad must have limited bounds.
* It's possible to specify the exact place on the grid for each element.
* A cell can contain more than one item. The draw order will be the same as the place order.
* Each item in a cell can have different spans.
* Each item can have horizontal and vertical spans simultaneously.
* Each row and column can have a specific size: fixed or weight-based.

## Install

```shell
flutter pub add grid_pad
```

The command above add the following dependency:

```yaml
dependencies:
  grid_pad: version
```

To start using the library is enough import the package:

```dart
import 'package:grid_pad/grid_pad.dart';
```

## Define the grid

Specifying the exact grid size is required, but specifying each row and column size is optional. The
following code initializes a 3x4 grid with rows and columns weights equal to 1:

```dart
GridPad(
  gridPadCells: GridPadCells.gridSize(rowCount: 4, columnCount: 3),       
  children: [],
);
```

By default rows and columns have **weight** size equal to 1, but it's possible specify different
size to specific row or column.
The library support 2 types of sizes:

* **Fixed** - fixed size, not change when the bounds of GridPad change.
* **Weight** - a relative, depends on other weights, remaining space after placing fixed sizes, 
  and the GridPad bounds.

To define a specific size for a row or column you need to use `GridPadCellsBuilder` API:

```dart
GridPad(
  gridPadCells: GridPadCellsBuilder(rowCount: 3, columnCount: 4)
    .rowSize(0, const Weight(2))
    .columnSize(3, const Fixed(90))
    .build(),
  children: [],
);
```

The algorithm for allocating available space between cells:

1. All fixed (**Fixed**) values are subtracted from the available space.
2. The remaining space is allocated between the remaining cells according to their weight value.

## Place the items

Items in a GridPad can be placed **explicitly** and **implicitly**. Implicit placing placed 
the item **next to the last placed item** (including span size). Placement direction and 
first placement position depend on [`placementPolicy`](#placement-policy). By default, 
the first placing will be at position \[0;0] with a horizontal direction from start to end.

```dart
GridPad(
  gridPadCells: GridPadCells.gridSize(rowCount: 4, columnCount: 3),       
  children: [
    // 1-st item, row = 0, column = 0
    ChildWidget(),
    // 2-nd item, row = 0, column = 1
    ChildWidget(),
    // 3-rd item, row = 0, column = 2
    ChildWidget(),
    // 4-th item, row = 1, column = 0
    ChildWidget(),
  ],
);
```

> :warning: When the placement reaches the last cell, the following items will be ignored.
> Placing items outside the grid is not allowed.

To place an item explicitly or specify row and column span for implicitly placement need to wrap
child widget into the `Cell` widget. When defines `row` and `column` property it's also possible 
to place all items in a different order without regard to the actual location.