import 'package:flutter/material.dart';
import 'package:myjob/src/core/resource/JobsProvider.dart';

class Position with ChangeNotifier {
  final String id;
  bool isLoading = false;
  String type = '';
  String url = '';
  String createdAt;
  String company;
  String companyUrl;
  String location;
  String title;
  String description;
  String howToApply;
  String companyLogo;

  Position(
      {@required this.id,
      this.isLoading,
      this.type,
      this.url,
      this.createdAt,
      this.company,
      this.companyUrl,
      this.location,
      this.title,
      this.description,
      this.howToApply,
      this.companyLogo});

  Position.fromId(this.id) {
    getPosition();
  }

  Position.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        type = json['type'],
        url = json['url'],
        createdAt = json['created_at'],
        company = json['company'],
        companyUrl = json['company_url'],
        location = json['location'],
        title = json['title'],
        howToApply = json['how_to_apply'],
        description = json['description'],
        companyLogo = json['company_logo'];

  final _provider = JobsProvider();

  Future<void> getPosition() async {
    isLoading = true;
    notifyListeners();
    final positionData = await _provider.positionFromId(this.id);
//    positionData.asMap();
    type = positionData.asMap()['type'];
    url = positionData.asMap()['url'];
    createdAt = positionData.asMap()['created_at'];
    company = positionData.asMap()['company'];
    companyUrl = positionData.asMap()['company_url'];
    location = positionData.asMap()['location'];
    title = positionData.asMap()['title'];
    description = positionData.asMap()['description'];
    howToApply = positionData.asMap()['how_to_apply'];
    companyLogo = positionData.asMap()['company_logo'];
    isLoading = false;
    notifyListeners();
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'type': type,
        'url': url,
        'created_at': createdAt,
        'company': company,
        'company_url': companyUrl,
        'location': location,
        'title': title,
        'description': description,
        'how_to_apply': howToApply,
        'companyLogo': companyLogo,
      };
}
