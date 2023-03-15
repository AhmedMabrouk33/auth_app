import 'package:auth_app/utils/data/universal_data.dart';
import 'package:flutter/material.dart';

import '../../../utils/colors/color_configuration.dart';

class AddressWidget {
  // ********* * Button widget. ************* /

  // ***** * Add address button. ****** /
  Widget addAddressButtonWidget(VoidCallback onPressed) {
    return Container(
      height: 51,
      width: 254,
      decoration: BoxDecoration(
        color: HexColor('#BA9062'),
        borderRadius: BorderRadius.circular(25),
      ),
      alignment: Alignment.center,
      child: InkWell(
        onTap: onPressed,
        child: Text(
          appLanguage == 'en' ? 'Add Address' : 'اضف عنوان',
          style: TextStyle(
            fontSize: 25,
            height: 1,
            color: HexColor('#383838'),
            fontWeight: FontWeight.w700,
            // TODO: ADD Font Family.
          ),
        ),
      ),
    );
  }

  Widget skipProcessButtonWidget(VoidCallback onPressed) {
    // -~ Sign up Action button.
    // Sign up Action.
    return Container(
      height: 51,
      width: 254,
      decoration: BoxDecoration(
        color: HexColor('#E4D7C3'),
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: onPressed,
        child: Center(
          child: Text(
            appLanguage == 'en' ? 'Skip Process' : 'تخطي العملية',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              height: 1,
              color: HexColor('#262833'),
              fontWeight: FontWeight.w700,
              // TODO: ADD Font Family.
            ),
          ),
        ),
      ),
    );
  }

  ////////////////////////////////////////////

  // ***** * Skip process button. ****** /

  /////////////////////////////////////////////////////

  // ********* * Text field widget. ************* /

  Widget textFieldContainer({
    required bool isFullScreen,
    required String labelText,
    required bool isTextInput,
    required TextDirection textDirection,
    required TextEditingController controller,
  }) {
    // -~ User name text field.
    return Directionality(
      textDirection: textDirection,
      child: SizedBox(
        height: 82,
        width: isFullScreen ? 324 : 134,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // -~ Label Text.
            SizedBox(
              width: isFullScreen ? 324 : 134,
              child: Text(
                labelText,
                style: TextStyle(
                  fontSize: 15,
                  color: HexColor('#5B5B5B'),
                  fontWeight: FontWeight.w700,
                  height: 1,
                ),
              ),
            ),

            // ? Padding.
            const SizedBox(height: 15),

            // -~ Text field.
            SizedBox(
              height: 50,
              width: isFullScreen ? 324 : 134,
              child: TextField(
                // TODO: Add focusNode.
                // autofocus: true,

                // **** Important data in case text field used for password. ** /
                // obscureText: true,
                // obscuringCharacter: '#',

                enabled: true,

                style: TextStyle(
                  color: HexColor('#19335A'),
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  height: 1,
                ),

                // **** Data for text field. ** /
                controller: controller,
                keyboardType:
                    isTextInput ? TextInputType.text : TextInputType.number,

                // **** Text field Decoration. ** /
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 15),
                  // **** Text filed background color. ** /
                  filled: true,
                  fillColor: HexColor('#E4D7C3').withOpacity(0.5),

                  // ***** Border style in case:
                  // ** Focus.
                  // ** Enable.
                  // ** Border.
                  // ********* //
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      width: 1,
                      color: HexColor('#DC8E22'),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),

                  // ***** Border style in case:
                  // ** Hint text.
                  // ** Hint Text style.
                  // ********* //
                  hintText: labelText,
                  hintStyle: TextStyle(
                    color: HexColor('#5B5B5B'),
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    height: 1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /////////////////////////////////////////////////////

  // ********* * Drop down widget. ************* /

  Widget dropDownWidget({
    required String labelText,
    required List<String> optionsList,
    required String? hintText,
    required void Function(String?) onSelected,
  }) {
    return SizedBox(
      height: 80,
      width: 144,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // -~ Label Text.
          SizedBox(
            width: 144,
            child: Text(
              labelText,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 15,
                color: HexColor('#5B5B5B'),
                fontWeight: FontWeight.w700,
                height: 1,
              ),
            ),
          ),

          // ? Padding.
          const SizedBox(height: 15),

          // -~ Drop Down List.
          Container(
            // color: Colors.blue,
            height: 50,
            width: 144,
            padding: const EdgeInsets.only(left: 15, right: 15),
            decoration: BoxDecoration(
              color: HexColor('#E4D7C3').withOpacity(0.5),
              borderRadius: BorderRadius.circular(15),
            ),
            child: DropdownButton<String>(
              // focusColor: Colors.blue,
              // iconEnabledColor: Colors.black,
              isExpanded: true,
              items: [
                ...optionsList
                    .map(
                      (optionWidget) => DropdownMenuItem<String>(
                        value: optionWidget,
                        child: Text(
                          optionWidget,
                          style: TextStyle(
                            color: HexColor('#19335A'),
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            height: 1,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ],
              onChanged: onSelected,
              underline: Divider(height: 0, color: Colors.transparent),
              hint: Text(
                labelText,
                style: TextStyle(
                  color: HexColor('#5B5B5B'),
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  height: 1,
                ),
              ),
              borderRadius: BorderRadius.circular(15),
              // dropdownColor: HexColor('#E4D7C3').withOpacity(0.5),
              dropdownColor: HexColor('#E4D7C3'),
              // elevation: 1,
              value: hintText,
              // itemHeight: 20,
            ),
          ),
        ],
      ),
    );
  }
}
