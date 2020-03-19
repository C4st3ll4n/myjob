import 'dart:convert';

import 'package:http/http.dart';
import 'package:myjob/src/core/model/UserLocation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JobsProvider {
  JobsProvider() {
    _getInstance();
  }

  SharedPreferences _preferences;

  final _client = Client();

  final _baseUrl = "https://www.jobs.github.com";

  Future<List<dynamic>> positionsFromLocation(UserLocation location) async {
    Response response;
    if (location != null) {
      final lat = Uri.encodeComponent(location.latitude.toString());
      final long = Uri.encodeComponent(location.longitude.toString());
      response =
          await _client.get("$_baseUrl/positions.json?lat=$lat&long=$long");
    } else {
      response = await _client.get("$_baseUrl/positions.json");
    }

    return _handleResponse(response);
  }

  Future<List<dynamic>> positions() async {
    final Response response = await _client.get("$_baseUrl/positions.json");
    return _handleResponse(response);
  }

  Future<List<dynamic>> savedPositions() async {
    if (_preferences == null) await _getInstance();
    final savedPositions = _preferences.getStringList("savedPositions") ?? [];
    final List<dynamic> positions = savedPositions.map((p) {
      try {
        return json.decode(p);
      } catch (e) {
        return null;
      }
    }).toList()
      ..removeWhere((pos) => pos == null);

    return positions;
  }

  Future<List<dynamic>> positionFromId(String id) async {
    final saved = await savedPositions();
    final match = saved.firstWhere((p) => p['id'] == id, orElse: () => null);

    if (match != null)
      return match;
    else {
      final response = await _client.get("$_baseUrl/positions.json");
      return _handleResponse(response, error: "Falha na busca da vaga");
    }
  }

  Future<void> _getInstance() async {
    final prefs = await SharedPreferences.getInstance();
    _preferences = prefs;
  }

  dynamic _handleResponse(Response response, {String error}) {
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw error ?? "Failed unknow";
    }
  }
}
