import 'package:flutter/material.dart';
import 'package:myjob/src/core/model/Positions.dart';
import 'package:myjob/src/core/model/Settings.dart';
import 'package:myjob/src/core/model/UserLocation.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:provider/provider.dart';

import 'RefreshButton.dart';

class HomeAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      pinned: true,
      snap: true,
      forceElevated: true,
      title: Text(
        "Jobber",
        style: Theme.of(context)
            .textTheme
            .title
            .copyWith(color: Theme.of(context).accentColor),
      ),
      leading: IconButton(
        icon: Icon(OMIcons.settings),
        tooltip: "Configurações",
        onPressed: () => Navigator.of(context).pushNamed("/settings"),
      ),
      actions: <Widget>[
        RefreshButton(
          onPressed: () {
            Provider.of<Positions>(context).getPositions(
                location: Provider.of<Settings>(context).useLocation
                    ? Provider.of<UserLocation>(context)
                    : null);
          },
        ),
      ],
      bottom: TabBar(indicatorColor: Theme.of(context).accentColor, tabs: [
        Tab(
          text: "Próximo",
        ),
        Tab(
          text: "Salvo",
        )
      ]),
    );
  }
}
