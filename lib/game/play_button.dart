import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'game_state_provider.dart';

class PlayButton extends StatelessWidget {
  const PlayButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GameStateProvider gameStateProvider =
        Provider.of<GameStateProvider>(context, listen: true);

    return Container(
        child: new SizedBox(
      width: 200,
      height: 50,
      child: new RaisedButton(
          onPressed: () => gameStateProvider.toggleIsPlaying(),
          child: new Text("PLAY!")),
    ));
  }
}
