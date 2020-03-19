import 'package:flutter/material.dart';
import 'package:myjob/src/core/model/UserLocation.dart';
import 'package:myjob/src/core/resource/JobsProvider.dart';

class Positions with ChangeNotifier {
  final _provider = JobsProvider();

  final savedListKey = GlobalKey<AnimatedListState>();
  bool _isLoading = false;
  List<dynamic> _positions;
  List<dynamic> _saved;

  Map<String, List<GlobalKey>> _keys = {
    "positions": [],
    "saved": [],
  };

  List<dynamic> get positions => List.unmodifiable(_positions);

  List<dynamic> get saved => List.unmodifiable(_saved);

  Map<String, List<GlobalKey>> get key => Map.unmodifiable(_keys);

  Future<void> getPositions({UserLocation location}) async {
    _isLoading = true;
    notifyListeners();

    if (location != null) {
      try {} catch (e) {}
    } else {
      try {} catch (e) {}
    }

    _saved = await _provider.savedPositions();
    _keys['saved'] = List.generate(_saved.length, (_) => GlobalKey());

    _isLoading = false;
    notifyListeners();
  }
}
