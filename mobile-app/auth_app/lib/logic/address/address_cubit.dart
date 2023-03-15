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
  final List<CityModel> _availableCitiesModels = [];
  final List<String> citiesOptions = [];
  final List<String> areasOptions = [];
  AddressScreenStateEnum privateScreenState =
      AddressScreenStateEnum.loadingState;

  ///////////////////////////////////////////////////////////////////////////////

  /// ************ * Constructor. ************ /

  AddressCubit()
      : super(
          const AddressState(
            addressScreenState: AddressScreenStateEnum.loadingState,
            selectedCity: '',
          ),
        ) {
    _readAvailableCities();
  }

  ///////////////////////////////////////////////////////////////////////////////

  /// ************ * Public methods. ************ /
  void changeSelectedAddressAction(
      {String? selectedCityOption, String? selectedAreaOption}) {
    if (selectedCityOption != null) {
      print('Get new Selected city options');
      _getAvailableAreasNames(selectedCityOption);
    }
    emit(
      AddressState(
        addressScreenState: AddressScreenStateEnum.newAddressState,
        selectedCity: selectedCityOption ?? state.selectedCity,
        selectedArea: selectedCityOption == null ? selectedAreaOption : null,
      ),
    );
  }

  ///////////////////////////////////////////////

  void goToPreviousStateAction() {
    emit(
      AddressState(
        addressScreenState: _availableCitiesModels.isNotEmpty
            ? AddressScreenStateEnum.newAddressState
            : AddressScreenStateEnum.loadingState,
        selectedCity: state.selectedCity,
        selectedArea: state.selectedArea,
      ),
    );
  }

  ///////////////////////////////////////////////

  void sendAddressAction({
    required String tagName,
    required String buildingNo,
    required String floorNo,
    required String address,
  }) async {
    ClientLocationModel? tempLocation = _verifyAddressEntities(
      tagName: tagName,
      buildingNo: buildingNo,
      floorNo: floorNo,
      address: address,
    );

    if (tempLocation != null) {
      emit(
        AddressState(
          addressScreenState: AddressScreenStateEnum.loadingState,
          selectedArea: state.selectedArea,
          selectedCity: state.selectedCity,
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
                  selectedArea: state.selectedArea,
                  selectedCity: state.selectedCity,
                  errorMessage: leftMessage,
                ),
              ),
              (rightSide) {
                clientData.clientLocation.add(rightSide);

                emit(
                  AddressState(
                    addressScreenState: AddressScreenStateEnum.completeState,
                    selectedArea: state.selectedArea,
                    selectedCity: state.selectedCity,
                  ),
                );
              },
            ),
          );
    } else {
      emit(
        AddressState(
          addressScreenState: AddressScreenStateEnum.errorState,
          selectedArea: state.selectedArea,
          selectedCity: state.selectedCity,
          errorMessage: appLanguage == 'en'
              ? 'There is something missing data'
              : 'هناك شيء مفقود من البيانات',
        ),
      );
    }
  }

  ///////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////

  /// ************ * Private methods. ************ /
  void _getAvailableAreasNames(String selectedCityName) {
    areasOptions.clear();
    List<AreaModel> tempAreas = _availableCitiesModels
        .singleWhere(
          (city) =>
              (appLanguage == 'en'
                  ? (city.nameEN == selectedCityName)
                  : (city.nameAR == selectedCityName)) ==
              true,
        )
        .areas;
    areasOptions.addAll(
      tempAreas.map(
        (area) => appLanguage == 'en' ? area.nameEN : area.nameAR,
      ),
    );
  }

  ///////////////////////////////////////////////////////////////////////////////
  void _readAvailableCities() {
    _repository.readCitiesRepository().then(
          (repositorySide) => repositorySide.fold(
            (leftMessage) => emit(
              AddressState(
                addressScreenState: AddressScreenStateEnum.errorState,
                errorMessage: leftMessage,
                selectedArea: state.selectedArea,
                selectedCity: state.selectedCity,
              ),
            ),
            (rightLocation) {
              _availableCitiesModels.addAll(rightLocation);

              citiesOptions.addAll(
                _availableCitiesModels.map(
                  (cityOption) => appLanguage == 'en'
                      ? cityOption.nameEN
                      : cityOption.nameAR,
                ),
              );

              areasOptions.addAll(
                _availableCitiesModels.first.areas.map(
                  (areasOptions) => appLanguage == 'en'
                      ? areasOptions.nameEN
                      : areasOptions.nameAR,
                ),
              );

              emit(
                AddressState(
                  addressScreenState: AddressScreenStateEnum.newAddressState,
                  selectedCity: citiesOptions.first,
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
  }) {
    if ((tagName.isNotEmpty) &&
        (buildingNo.isNotEmpty) &&
        (floorNo.isNotEmpty) &&
        (address.isNotEmpty) &&
        (state.selectedArea != null)) {
      return ClientLocationModel(
        clientLocationId: -1,
        locationName: tagName,
        buildingNo: buildingNo,
        floorNo: floorNo,
        address: address,
        area: state.selectedArea!,
        city: state.selectedCity,
      );
    } else {
      return null;
    }
  }

  ///////////////////////////////////////////////////////////////////////////////
}
