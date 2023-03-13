import 'imagemodel.dart';

///
/// Client Model.
/// Note: This call will use in local service and web services.
///
class ClientModel {
  final int clientId;
  String phoneNo;
  String dateOfBirth;
  UserModel user;
  List<ClientLocationModel> clientLocation;
  ImageModel? clientImage;

  ///////////////////////////////////////////////////////////////

  // ************** * Constructor. ************** /

  ClientModel({
    required this.clientId,
    required this.phoneNo,
    required this.dateOfBirth,
    required this.user,
    required this.clientLocation,
    this.clientImage,
  });

  ///////////////////////////////////////////////////////////////

  // ************** * From web service. ************** /
  factory ClientModel.fromWebServices(Map<String, dynamic> json,
      {required String password}) {
    List<ClientLocationModel> tempClientLocations = [];

    print(
        'Client location attribute is ${json['attributes']['clientlocations']}');

    if (json['attributes']['clientlocations']['data'].isNotEmpty) {
      final int lengthOfJson =
          json['attributes']['clientlocations']['data'].length;

      for (int index = 0; index < lengthOfJson; index++) {
        tempClientLocations.add(
          ClientLocationModel.fromWebService(
            json['attributes']['clientlocations']['data'][index],
          ),
        );
      }
    }
    return ClientModel(
      clientId: json['id'],
      phoneNo: json['attributes']['phoneno'],
      dateOfBirth: json['attributes']['dateofbirth'],
      user: UserModel.fromWebService(
        json['attributes']['user']['data'],
        isAttributeJson: true,
        password: password,
      ),
      clientImage: json['attributes']['image']['data'] != null
          ? ImageModel.fromWebService(
              json['attributes']['image']['data'],
              isAttributeJson: true,
            )
          : null,
      clientLocation: tempClientLocations,
    );
  }

  ///////////////////////////////////////////////////////////////

  // ************** * To web service. ************** /
  Map<String, dynamic> toWebService() {
    return {
      'phoneno': phoneNo,
      'dateofbirth': dateOfBirth,
      'image': clientImage != null ? clientImage!.imageId : null,
      'user': user.userId,
    };
  }

  @override
  String toString() {
    return 'ClientModel(clientId: $clientId, phoneNo: $phoneNo, dateOfBirth: $dateOfBirth, user: $user, clientLocation: $clientLocation, clientImage: $clientImage)';
  }
}

///////////////////////////////////////////////////////////////

///
/// User Model.
/// Note: This call will use in local service and web services.
///
class UserModel {
  final int userId;
  String userName;
  String email;
  String password;
  bool isAutoLogin;

  ///////////////////////////////////////////////////////////////

  // ************** * Constructor. ************** /
  UserModel({
    required this.userId,
    required this.userName,
    required this.email,
    required this.password,
    required this.isAutoLogin,
  });

  ///////////////////////////////////////////////////////////////

  // ************** * From web services. ************** /

  factory UserModel.fromWebService(Map<String, dynamic> json,
      {required bool isAttributeJson, required String password}) {
    return UserModel(
      userId: json['id'] ?? 0,
      userName: isAttributeJson
          ? json['attributes']['username'] ?? ''
          : json['username'] ?? '',
      email: isAttributeJson
          ? json['attributes']['email'] ?? ''
          : json['email'] ?? '',
      password: password,
      isAutoLogin: isAttributeJson ? true : false,
    );
  }

  ///////////////////////////////////////////////////////////////

  // ************** * To web services. ************** /

  Map<String, dynamic> toWebService({required bool isLogin}) {
    return isLogin
        ? {
            'identifier': email,
            'password': password,
          }
        : {
            'username': userName,
            'email': email,
            'password': password,
          };
  }

  ///////////////////////////////////////////////////////////////

  // ************** * From Local service. ************** /
  factory UserModel.fromLocalServices(Map<String, dynamic> json) {
    return UserModel(
      userId: 0,
      userName: '',
      email: json['email'],
      password: json['password'],
      isAutoLogin: json['flag'],
    );
  }

  ///////////////////////////////////////////////////////////////

  // ************** * To Local service. ************** /
  Map<String, dynamic> toLocalService() {
    return {
      'email': email,
      'password': password,
      'flag': isAutoLogin,
    };
  }

  @override
  String toString() {
    return 'UserModel(userId: $userId, userName: $userName, email: $email, password: $password, isAutoLogin: $isAutoLogin)';
  }
}

///////////////////////////////////////////////////////////////

///
/// Client Location Model.
/// Note: This call will use in local service and web services.
///
class ClientLocationModel {
  final int clientLocationId;
  String locationName;
  String buildingNo;
  String floorNo;
  String address;
  String area;
  String city;

  ///////////////////////////////////////////////////////////////

  // *********** * Constructor. ********** /
  ClientLocationModel({
    required this.clientLocationId,
    required this.locationName,
    required this.buildingNo,
    required this.floorNo,
    required this.address,
    required this.area,
    required this.city,
  });

  ///////////////////////////////////////////////////////////////

  // *********** * From web service. ********** /
  factory ClientLocationModel.fromWebService(Map<String, dynamic> json) {
    return ClientLocationModel(
      clientLocationId: (json['id'] as int?) ?? 0,
      locationName: json['attributes']['name'] ?? '',
      buildingNo: json['attributes']['buildingno'] ?? '',
      floorNo: json['attributes']['floorno'] ?? '',
      address: json['attributes']['address'] ?? '',
      area: json['attributes']['area'] ?? '',
      city: json['attributes']['city'] ?? '',
    );
  }

  ///////////////////////////////////////////////////////////////

  // *********** * To web service. ********** /

  ///
  /// This method will send client location and send relation with client.
  /// Note: Don't update send location to client api.
  ///
  Map<String, dynamic> toWebService({required int clientId}) {
    return {
      'name': locationName,
      'buildingno': buildingNo,
      'floorno': floorNo,
      'address': address,
      'area': area,
      'city': city,
      'client': clientId,
    };
  }

  ///////////////////////////////////////////////////////////////

  @override
  String toString() {
    return 'ClientLocationModel(clientLocationId: $clientLocationId, locationName: $locationName, buildingNo: $buildingNo, floorNo: $floorNo, address: $address, area: $area, city: $city)';
  }
}

///////////////////////////////////////////////////////////////
