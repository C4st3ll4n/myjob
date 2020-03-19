import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myjob/src/core/model/Positions.dart';
import 'package:myjob/src/core/model/Settings.dart';
import 'package:provider/provider.dart';

import 'core/model/UserLocation.dart';
import 'core/service/LocationService.dart';

class MyJobApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final tema = buildTheme();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return MultiProvider(
      providers: [
        StreamProvider.value(value: LocationService().locationStream),
        ChangeNotifierProvider<Settings>.value(value: appSettings)
      ],
      child: Consumer<UserLocation>(
        builder: (ctx, model, _) => ChangeNotifierProvider(
          builder: (ctx) => Positions()
            ..getPositions(location: appSettings.useLocation ? model : null),
        ),
      ),
    );
  }
}
