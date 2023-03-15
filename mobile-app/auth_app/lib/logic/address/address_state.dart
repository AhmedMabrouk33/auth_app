part of 'address_cubit.dart';

class AddressState extends Equatable {
  final String? selectedArea;
  final String selectedCity;
  final AddressScreenStateEnum addressScreenState;
  final String errorMessage;

  const AddressState({
    this.errorMessage = '',
    required this.addressScreenState,
    this.selectedArea,
    required this.selectedCity,
  });

  @override
  List<Object> get props =>
      [selectedArea ?? '', selectedCity, addressScreenState, errorMessage];
}
