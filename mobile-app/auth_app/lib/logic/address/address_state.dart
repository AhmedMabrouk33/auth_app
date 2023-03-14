part of 'address_cubit.dart';

class AddressState extends Equatable {
  final int selectedAreaIndex;
  final int selectedCityIndex;
  final AddressScreenStateEnum addressScreenState;
  final String errorMessage;

  const AddressState({
    this.errorMessage = '',
    required this.addressScreenState,
    required this.selectedAreaIndex,
    required this.selectedCityIndex,
  });

  @override
  List<Object> get props =>
      [selectedCityIndex, selectedAreaIndex, addressScreenState, errorMessage];
}
