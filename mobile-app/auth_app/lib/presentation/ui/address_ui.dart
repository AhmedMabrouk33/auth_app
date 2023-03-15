import 'package:auth_app/utils/data/universal_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/address/address_cubit.dart';
import '../../utils/colors/color_configuration.dart';
import '../widgets/address/address_widgets.dart';

class AddressUi {
  final AddressCubit addressActions;

  //////////////////////////////////////////////////////

  AddressUi({
    required this.addressActions,
  });

  //////////////////////////////////////////////////////

  // ************** * Local Attribute. ************** /
  final AddressWidget _addressWidget = AddressWidget();
  final TextEditingController _tagNameController = TextEditingController();
  final TextEditingController _buildingNoController = TextEditingController();
  final TextEditingController _floorNoController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  //////////////////////////////////////////////////////

  // ************** * New address. ************** /

  List<Widget> newAddressUi(VoidCallback navigateAction) {
    return [
      // ? Top padding.
      const SizedBox(height: 45),

      // -~ Screen Header.
      Text(
        appLanguage == 'en' ? 'Add Address' : 'اضف عنوان',
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w700,
          color: HexColor('#DC8E22'),
          height: 1,
        ),
      ),

      // ? Padding.
      const SizedBox(height: 30),

      // -~ Name Text field.
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ? Start padding.
          const SizedBox(width: 15),

          // -~ Address text field.
          _addressWidget.textFieldContainer(
            isFullScreen: true,
            labelText: appLanguage == 'en' ? 'Tag Name' : 'اسم',
            isTextInput: true,
            textDirection:
                appLanguage == 'en' ? TextDirection.ltr : TextDirection.rtl,
            controller: _tagNameController,
          ),

          // ? End padding.
          const SizedBox(width: 21),
        ],
      ),

      // ? Padding.
      const SizedBox(height: 30),

      // -~ Building No and floor no Row.
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ? Start padding.
          const SizedBox(width: 15),

          // -~ Building No text field.
          _addressWidget.textFieldContainer(
            isFullScreen: false,
            labelText: appLanguage == 'en' ? 'Building No' : 'رقم المبنى',
            isTextInput: false,
            textDirection:
                appLanguage == 'en' ? TextDirection.ltr : TextDirection.rtl,
            controller: _buildingNoController,
          ),

          // ? Spacer.
          const Spacer(),

          // -~ Floor No text field.
          _addressWidget.textFieldContainer(
            isFullScreen: false,
            labelText: appLanguage == 'en' ? 'Floor No' : 'رقم الطابق',
            isTextInput: false,
            textDirection:
                appLanguage == 'en' ? TextDirection.ltr : TextDirection.rtl,
            controller: _floorNoController,
          ),

          // ? End padding.
          const SizedBox(width: 21),
        ],
      ),

      // ? Padding.
      const SizedBox(height: 30),

      // -~ Address Text field.
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ? Start padding
          const SizedBox(width: 15),

          _addressWidget.textFieldContainer(
            isFullScreen: true,
            labelText: appLanguage == 'en' ? 'Address' : 'عنوان',
            isTextInput: true,
            textDirection:
                appLanguage == 'en' ? TextDirection.ltr : TextDirection.rtl,
            controller: _addressController,
          ),

          // ? End padding
          const SizedBox(width: 21),
        ],
      ),

      // ? Padding.
      const SizedBox(height: 30),

      // -~ City and areas drop down options.
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ? Start padding.
          const SizedBox(width: 15),

          // -~ Cities options Widget.
          BlocBuilder<AddressCubit, AddressState>(
            buildWhen: (previous, current) =>
                previous.selectedCity != current.selectedCity,
            builder: (context, state) {
              return _addressWidget.dropDownWidget(
                labelText: appLanguage == 'en' ? 'City' : 'مدينة',
                hintText: addressActions.state.selectedCity,
                onSelected: (selectedCity) {
                  if (selectedCity != addressActions.state.selectedCity) {
                    addressActions.changeSelectedAddressAction(
                      selectedCityOption: selectedCity,
                    );
                  }
                },
                optionsList: addressActions.citiesOptions,
              );
            },
          ),

          // ? Spacer
          const Spacer(),

          // -~ Areas options Widget.
          BlocBuilder<AddressCubit, AddressState>(
            builder: (context, state) {
              return _addressWidget.dropDownWidget(
                labelText: appLanguage == 'en' ? 'Area' : 'منطقة',
                optionsList: addressActions.areasOptions,
                hintText: state.selectedArea,
                // hintText: 'Maadi',
                onSelected: (selectedArea) {
                  if (selectedArea != state.selectedArea) {
                    addressActions.changeSelectedAddressAction(
                      selectedAreaOption: selectedArea,
                    );
                  }
                },
              );
            },
          ),

          // ? End padding.
          const SizedBox(width: 21),
        ],
      ),

      // ? Padding.
      const SizedBox(height: 120),

      // -~ Add Address button.
      _addressWidget.addAddressButtonWidget(
        () => addressActions.sendAddressAction(
          tagName: _tagNameController.text,
          buildingNo: _buildingNoController.text,
          floorNo: _floorNoController.text,
          address: _addressController.text,
          
        ),
      ),

      // ? Padding.
      const SizedBox(height: 30),

      // -~ Skip process button.
      _addressWidget.skipProcessButtonWidget(navigateAction),
    ];
  }

  //////////////////////////////////////////////////////
}
