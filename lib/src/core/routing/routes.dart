import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:morpheus/morpheus.dart';

Route<T> generateRoutes<T>(RouteSettings settings) {
  switch (settings.name) {
    case '/position':
      return route(
        settings,
        builder: (_) => PositionDetails(),
      );
      break;
    case '/settings':
      return route(
        settings,
        builder: (_) => SettingsScreen(),
      );
      break;
    case '/':
      return route(
        settings,
        builder: (_) => Home(),
      );
      break;
  }
}

@visibleForTesting
Route<T> route<T>(RouteSettings settings,
    {@required WidgetBuilder builder,
    bool fullscreenDialog = false,
    Color trasitionColor}) {
  assert(settings != null);
  assert(builder != null);
  assert(fullscreenDialog != null);

  return Platform.isIOS || Platform.isMacOS
      ? CupertinoPageRoute(
          builder: builder,
          settings: settings,
          fullscreenDialog: fullscreenDialog)
      : MorpheusPageRoute(builder: builder, settings: settings);
}
