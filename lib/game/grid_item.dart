import 'package:dualnback/game/visual_input.dart';
import 'package:flutter/material.dart';

class GridItem extends StatefulWidget {
  VisualInput visualInput;

  GridItem(VisualInput visInput, {Key key}) : super(key: key) {
    visualInput = visInput;
  }

  @override
  _GridItemState createState() => _GridItemState();
}

class _GridItemState extends State<GridItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(5.0),
        child: new DecoratedBox(
          decoration: new BoxDecoration(
            color: widget.visualInput.color, 
            shape: widget.visualInput.shape),
        ));
  }
}
