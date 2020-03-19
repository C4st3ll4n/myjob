import 'package:flutter/cupertino.dart';
import 'package:morpheus/morpheus.dart';

class PositionDetailsArguments extends MorpheusRouteArguments {
  final String id;
  final String title;
  final bool showSaveToggle;

  PositionDetailsArguments({
    @required this.title,
    @required this.id,
    this.showSaveToggle = true,
    GlobalKey parentKey,
    Color transitionColor,
  })  : assert(title != null),
        assert(id != null),
        assert(showSaveToggle != null),
        super(parentKey: parentKey, transitionColor: transitionColor);
}
