import 'package:flutter/foundation.dart';

/// City Model.
class CityModel {
  final String nameEN;
  final String nameAR;
  final List<AreaModel> areas;

  ///////////////////////////////////////////////////////////////

  // ************** * Constructor. ************** /

  CityModel({
    required this.nameEN,
    required this.nameAR,
    required this.areas,
  });

  ///////////////////////////////////////////////////////////////

  // ************** * From web services. ************** /
  factory CityModel.fromWebService(Map<String, dynamic> json) {
    List<AreaModel> tempAreas = [];
    if (json['attributes']['areas']['data'].isNotEmpty) {
      int areaLength = json['attributes']['areas']['data'].length;
      for (int index = 0; index < areaLength; index++) {
        tempAreas.add(
          AreaModel.fromWebService(
            json['attributes']['areas']['data'][index],
          ),
        );
      }
    }
    return CityModel(
      nameEN: json['attributes']['nameen'],
      nameAR: json['attributes']['namear'],
      areas: tempAreas,
    );
  }

  ///////////////////////////////////////////////////////////////

  // ************** * To web services. ************** /

  ///////////////////////////////////////////////////////////////
}

///////////////////////////////////////////////////////////////

/// Areas Model {Private class}.
class AreaModel {
  final String nameEN;
  final String nameAR;

  ///////////////////////////////////////////////////////////////

  // ************** * Constructor. ************** /

  AreaModel({
    required this.nameEN,
    required this.nameAR,
  });

  ///////////////////////////////////////////////////////////////

  // ************** * From web services. ************** /
  factory AreaModel.fromWebService(Map<String, dynamic> json) {
    return AreaModel(
      nameEN: json['attributes']['nameen'],
      nameAR: json['attributes']['namear'],
    );
  }

  ///////////////////////////////////////////////////////////////

  // ************** * To web services. ************** /

  ///////////////////////////////////////////////////////////////
}

///////////////////////////////////////////////////////////////
