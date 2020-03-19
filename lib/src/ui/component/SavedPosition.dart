import 'package:flutter/material.dart';
import 'package:myjob/src/core/model/Position.dart';
import 'package:myjob/src/core/routing/position_deetails_arguments.dart';

class SavedPosition extends StatelessWidget {
  final GlobalKey parentKey;
  final Animation<double> animation;
  final Position position;

  const SavedPosition(
      {Key key, this.parentKey, this.animation, @required this.position})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Widget tile = ListTile(
      key: parentKey,
      title: Text(position.title),
      subtitle: Text(position.location),
      onTap: () => showPositionDetails(context),
    );

    if (animation == null) {
      return tile;
    } else {
      final Animation<double> transitionAnimation =
          Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.fastOutSlowIn,
              reverseCurve: Curves.fastOutSlowIn.flipped));

      return SizeTransition(
        sizeFactor: transitionAnimation,
        child: FadeTransition(
          opacity: transitionAnimation,
          child: tile,
        ),
      );
    }
  }

  showPositionDetails(BuildContext context) async {
    await Navigator.of(context).pushNamed("/position",
        arguments: PositionDetailsArguments(
            title: position.title,
            id: position.id,
            showSaveToggle: false,
            parentKey: parentKey));
  }
}
