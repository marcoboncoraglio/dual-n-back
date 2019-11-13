import 'package:dualnback/game/grid_item.dart';
import 'package:dualnback/game/visual_input.dart';
import 'package:flutter/material.dart';

class Grid extends StatefulWidget {
  List<GridItem> gridItems = [];

  // take element nr
  Grid(int index, VisualInput visInput) {
    for (int i = 0; i < 9; i++) {
      if (i == index)
        gridItems.add(new GridItem(visInput));
      else
        gridItems.add(
            new GridItem(new VisualInput(BoxShape.rectangle, Colors.grey)));
    }
  }

  @override
  _GridState createState() => _GridState();
}

class _GridState extends State<Grid> {
  @override
  Widget build(BuildContext context) {
    return Container(child: _buildGrid());
  }

  Widget _buildGrid() {
    return Column(children: <Widget>[
      new Expanded(
        child: new GridView.builder(
          padding: const EdgeInsets.all(35.0),
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.0,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 4.0),
          itemCount: widget.gridItems.length,
          itemBuilder: (context, i) => new SizedBox(
              width: 100.0, height: 100.0, child: widget.gridItems[i]),
        ),
      )
    ]);
  }
}
