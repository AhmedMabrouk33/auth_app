import 'package:dartz/dartz.dart';

import '../web/address_web_services.dart';
import '../models/citymodel.dart';
import '../models/clientmodel.dart' show ClientLocationModel;

import '../../utils/data/universal_data.dart' show appLanguage;

class AddressRepository {
  // ******************* * Private attributes. **************** /
  final AddressWebService _webService = AddressWebService();

  ////////////////////////////////////////////////////////////////////////////

  // ******************* * Read cities. **************** /

  Future<Either<String, List<CityModel>>> readCitiesRepository() async {
    List<CityModel> tempCities = await _webService.readCitiesRequest();

    if (tempCities.isNotEmpty) {
      return Right(tempCities);
    } else {
      return Left(
        appLanguage == 'en'
            ? 'Can\'t read cities \nPlease try again'
            : 'لا يمكن قراءة المدن \n الرجاء المحاولة مرة أخرى',
      );
    }
  }

  ////////////////////////////////////////////////////////////////////////////

  // ******************* * Post Locations. **************** /
  Future<Either<String, ClientLocationModel>> saveLocationRepository({
    required ClientLocationModel clientLocation,
    required int clientId,
  }) async {
    ClientLocationModel? tempLocation = await _webService.sendLocationRequest(
      clientLocation: clientLocation,
      clientId: clientId,
    );

    if (tempLocation != null) {
      return Right(tempLocation);
    } else {
      return Left(
        appLanguage == 'en'
            ? 'Can\'t save your location \nPlease try again'
            : 'لا يمكن حفظ موقعك \n الرجاء المحاولة مرة أخرى',
      );
    }
  }
}
