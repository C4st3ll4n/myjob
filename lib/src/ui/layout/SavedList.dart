import 'package:flutter/material.dart';
import 'package:myjob/src/core/model/Position.dart';
import 'package:myjob/src/core/model/Positions.dart';
import 'package:myjob/src/ui/component/SavedPosition.dart';
import 'package:myjob/src/ui/component/LoadingTransition.dart';
import 'package:provider/provider.dart';

class SavedList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Consumer<Positions>(
      builder: (context, model, child) => LoadingTransition(
          child: model.isLoading ? _loading(context) : _content(context, model)),
    );
  }

  Widget _content(context, Positions model) {
    if (model.positions == null || model.positions.isEmpty) {
      return Container(
        key: Key('empty'),
        height: MediaQuery.of(context).size.height / 2,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Text(
          "Nenhuma posição salva",
          style: Theme.of(context).textTheme.subhead.copyWith(
                color: Colors.white54,
              ),
          textAlign: TextAlign.center,
        ),
      );
    } else {
      return AnimatedList(
        key: model.savedListKey,
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        initialItemCount: model.saved.length,
        itemBuilder: (ctx, index, animation) {
          final pos = Position.fromJson(model.saved[index]);
          return Column(
            children: <Widget>[
              SavedPosition(
                position: pos,
                animation: animation,
                parentKey: model.key['saved'][index],
              )
            ],
          );
        });
    }
  }

  Widget _loading(BuildContext context) => Container(
    key: Key('Loading'),
    height: MediaQuery.of(context).size.height / 2,
    alignment: Alignment.center,
    child: CircularProgressIndicator(),
  );
}

