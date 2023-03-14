import 'package:auth_app/utils/data/universal_data.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../data/repositories/address_repository.dart';

import '../../data/models/citymodel.dart';
import '../../data/models/clientmodel.dart' show ClientLocationModel;

part 'address_state.dart';

enum AddressScreenStateEnum {
  newAddressState,
  loadingState,
  completeState,
  errorState,
}

class AddressCubit extends Cubit<AddressState> {
  final AddressRepository _repository = AddressRepository();
  final List<CityModel> availableCities = [];
  AddressScreenStateEnum privateScreenState =
      AddressScreenStateEnum.loadingState;

  ///////////////////////////////////////////////////////////////////////////////

  /// ************ * Constructor. ************ /

  AddressCubit()
      : super(
          const AddressState(
            addressScreenState: AddressScreenStateEnum.loadingState,
            selectedAreaIndex: 0,
            selectedCityIndex: 0,
          ),
        ) {
    _readAvailableCities();
  }

  ///////////////////////////////////////////////////////////////////////////////

  /// ************ * Public methods. ************ /
  void changeSelectedAddressAction(
      {int? selectedCityIndex, int selectedAreaIndex = 0}) {
    emit(
      AddressState(
        addressScreenState: AddressScreenStateEnum.newAddressState,
        selectedCityIndex: selectedCityIndex ?? state.selectedCityIndex,
        selectedAreaIndex: selectedAreaIndex,
      ),
    );
  }

  ///////////////////////////////////////////////

  void goToPreviousState() {
    emit(
      AddressState(
        addressScreenState: availableCities.isNotEmpty
            ? AddressScreenStateEnum.newAddressState
            : AddressScreenStateEnum.loadingState,
        selectedCityIndex: state.selectedCityIndex,
        selectedAreaIndex: state.selectedAreaIndex,
      ),
    );
  }

  ///////////////////////////////////////////////

  void sendAddressAction({
    required String tagName,
    required String buildingNo,
    required String floorNo,
    required String address,
    required int areaIndex,
    required int cityIndex,
  }) async {
    ClientLocationModel? tempLocation = _verifyAddressEntities(
      tagName: tagName,
      buildingNo: buildingNo,
      floorNo: floorNo,
      address: address,
      areaIndex: areaIndex,
      cityIndex: cityIndex,
    );

    if (tempLocation != null) {
      emit(
        AddressState(
          addressScreenState: AddressScreenStateEnum.loadingState,
          selectedAreaIndex: state.selectedAreaIndex,
          selectedCityIndex: state.selectedCityIndex,
        ),
      );

      _repository
          .saveLocationRepository(
              clientLocation: tempLocation, clientId: clientData.clientId)
          .then(
            (repositorySide) => repositorySide.fold(
              (leftMessage) => emit(
                AddressState(
                  addressScreenState: AddressScreenStateEnum.errorState,
                  selectedAreaIndex: state.selectedAreaIndex,
                  selectedCityIndex: state.selectedCityIndex,
                  errorMessage: leftMessage,
                ),
              ),
              (rightSide) {
                clientData.clientLocation.add(rightSide);

                emit(
                  AddressState(
                    addressScreenState: AddressScreenStateEnum.completeState,
                    selectedAreaIndex: state.selectedAreaIndex,
                    selectedCityIndex: state.selectedCityIndex,
                  ),
                );
              },
            ),
          );
    } else {
      emit(
        AddressState(
          addressScreenState: AddressScreenStateEnum.errorState,
          selectedAreaIndex: state.selectedAreaIndex,
          selectedCityIndex: state.selectedCityIndex,
          errorMessage: appLanguage == 'en'
              ? 'There is something missing data'
              : 'هناك شيء مفقود من البيانات',
        ),
      );
    }
  }
  
  ///////////////////////////////////////////////////////////////////////////////

  /// ************ * Private methods. ************ /

  void _readAvailableCities() {
    _repository.readCitiesRepository().then(
          (repositorySide) => repositorySide.fold(
            (leftMessage) => emit(
              AddressState(
                addressScreenState: AddressScreenStateEnum.errorState,
                errorMessage: leftMessage,
                selectedAreaIndex: state.selectedAreaIndex,
                selectedCityIndex: state.selectedCityIndex,
              ),
            ),
            (rightLocation) {
              availableCities.addAll(rightLocation);

              emit(
                AddressState(
                  addressScreenState: AddressScreenStateEnum.newAddressState,
                  selectedAreaIndex: state.selectedAreaIndex,
                  selectedCityIndex: state.selectedCityIndex,
                ),
              );
            },
          ),
        );
  }

  ///////////////////////////////////////////////

  ClientLocationModel? _verifyAddressEntities({
    required String tagName,
    required String buildingNo,
    required String floorNo,
    required String address,
    required int areaIndex,
    required int cityIndex,
  }) {
    if ((tagName.isNotEmpty) &&
        (buildingNo.isNotEmpty) &&
        (floorNo.isNotEmpty) &&
        (address.isNotEmpty) &&
        (areaIndex != 0) &&
        (cityIndex != 0)) {
      final String selectedArea = appLanguage == 'en'
          ? availableCities[cityIndex].areas[areaIndex].nameEN
          : availableCities[cityIndex].areas[areaIndex].nameAR;

      final String selectedCity = appLanguage == 'en'
          ? availableCities[cityIndex].nameEN
          : availableCities[cityIndex].nameAR;

      return ClientLocationModel(
        clientLocationId: -1,
        locationName: tagName,
        buildingNo: buildingNo,
        floorNo: floorNo,
        address: address,
        area: selectedArea,
        city: selectedCity,
      );
    } else {
      return null;
    }
  }

  ///////////////////////////////////////////////////////////////////////////////
}
