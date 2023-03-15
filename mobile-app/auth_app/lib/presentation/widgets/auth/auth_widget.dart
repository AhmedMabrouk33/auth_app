import 'package:flutter/material.dart';

import '../../../utils/data/universal_data.dart';
import '../../../utils/colors/color_configuration.dart';

class AuthWidget {
  // ********* * Language Card ************* /
  Widget languageCard(String textWidget, VoidCallback onPressed) {
    return Card(
      color: HexColor('#DC8E22'),
      shadowColor: HexColor('#E4D7C3'),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: onPressed,
        child: SizedBox(
          height: 50,
          width: 50,
          child: Center(
            child: Text(
              textWidget,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                height: 1,
                color: HexColor('#383838'),
                fontWeight: FontWeight.w700,
                // TODO: ADD Font Family.
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ********* * Buttons ************* /
  Widget loginButton(VoidCallback onPressed) {
    // Login Action.
    return Container(
      height: 51,
      width: 254,
      decoration: BoxDecoration(
        color: HexColor('#BA9062'),
        borderRadius: BorderRadius.circular(25),
      ),
      child: InkWell(
        onTap: onPressed,
        child: Center(
          child: Text(
            appLanguage == 'en' ? 'Login' : 'تسجيل الدخول',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25,
              height: 1,
              color: HexColor('#383838'),
              fontWeight: FontWeight.w700,
              // TODO: ADD Font Family.
            ),
          ),
        ),
      ),
    );
  }

  Widget signUpButton(VoidCallback onPressed) {
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
            appLanguage == 'en' ? 'Sign Up' : 'اشتراك',
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

  Widget returnButton(VoidCallback onPressed) {
    return Container(
      height: 51,
      width: 254,
      decoration: BoxDecoration(
        color: HexColor('#DC395F'),
        borderRadius: BorderRadius.circular(25),
      ),
      child: InkWell(
        onTap: onPressed,
        child: Center(
          child: Text(
            appLanguage == 'en' ? 'Return ' : 'عودة',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25,
              height: 1,
              color: HexColor('#E4D7C3'),
              fontWeight: FontWeight.w700,
              // TODO: ADD Font Family.
            ),
          ),
        ),
      ),
    );
  }
  
  //////////////////////////////////////////////////////////////////

  // ********* * Screen Header ************* /
  Widget screenHeader({
    required VoidCallback onPressed,
    required bool hasHeaderText,
  }) {
    // -~ Row for Pop icon and text.
    return Directionality(
      textDirection:
          appLanguage == 'en' ? TextDirection.ltr : TextDirection.rtl,
      child: SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ? Padding.
            const SizedBox(width: 31),

            // -~ Pop icon.
            IconButton(
              onPressed: onPressed,
              alignment: appLanguage == 'en'
                  ? Alignment.centerLeft
                  : Alignment.centerRight,
              icon: Icon(
                Icons.disabled_by_default_outlined,
                size: 25,
                color: HexColor('#000000'),
              ),
            ),

            // ? Spacing.
            const SizedBox(width: 29),

            // -~ Text {Page title}.
            hasHeaderText
                ? Text(
                    appLanguage == 'en' ? 'Personal details' : 'بيانات شخصية',
                    style: TextStyle(
                      fontSize: 30,
                      height: 1,
                      color: HexColor('#DC8E22'),
                      fontWeight: FontWeight.w700,
                      // TODO: Add fontFamily.
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  //////////////////////////////////////////////////////////////////

  // ********* * Text field ************* /
  Widget regularTextField({
    required String hint,
    required TextInputType keyboardType,
    required TextDirection textDirection,
    required TextEditingController controller,
  }) {
    // -~ User name text field.
    return Directionality(
      textDirection: textDirection,
      child: SizedBox(
        height: 50,
        width: 300,
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
          keyboardType: keyboardType,

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
            hintText: hint,
            hintStyle: TextStyle(
              color: HexColor('#5B5B5B'),
              fontSize: 20,
              fontWeight: FontWeight.w700,
              height: 1,
            ),
          ),
        ),
      ),
    );
  }

  ///////////////////////////////////////

  Widget passwordTextField({
    required String hint,
    required bool obscureTextState,
    required VoidCallback onPressed,
    required TextEditingController controller,
  }) {
    // -~ Confirm password text field.
    return Directionality(
      textDirection: TextDirection.ltr,
      child: SizedBox(
        height: 50,
        width: 300,
        child: TextField(
          // TODO: Add focusNode.
          // autofocus: true,

          // **** Important data in case text field used for password. ** /
          obscureText: !obscureTextState,
          obscuringCharacter: '#',

          enabled: true,

          style: TextStyle(
            color: HexColor('#19335A'),
            fontSize: 20,
            fontWeight: FontWeight.w700,
            height: 1,
          ),

          // **** Data for text field. ** /
          controller: controller,
          keyboardType: TextInputType.visiblePassword,

          // **** Text field Decoration. ** /
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 15),
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

            // ***** Data for Hint:
            // ** Hint text.
            // ** Hint Text style.
            // ********* //

            hintText: hint,
            hintStyle: TextStyle(
              color: HexColor('#5B5B5B'),
              fontSize: 20,
              fontWeight: FontWeight.w700,
              height: 1,
            ),

            // ***** Border style in case:
            // ** Hint text.
            // ** Hint Text style.
            // ********* //
            // TODO: How to Rebuild single enitity in cubit.
            suffixIcon: IconButton(
              onPressed: onPressed,
              icon: obscureTextState == false
                  ? Icon(Icons.visibility)
                  : Icon(Icons.visibility_off),

              // icon: context.Icon(Icons.visibility),
              color: HexColor('#19335A'),
              iconSize: 30,
            ),
          ),
        ),
      ),
    );
  }

  //////////////////////////////////////////////////////////////////
}
