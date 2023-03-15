import 'package:flutter/material.dart';

import '../../../utils/colors/color_configuration.dart';
import '../../../utils/data/universal_data.dart';

import '../../widgets/global/return_button.dart';

// ************** * Loading Ui. ************** /

List<Widget> loadingUi(VoidCallback? navigateAction) {
  navigateAction != null ? navigateAction() : () {};
  return [
    // ? Top Padding.
    const SizedBox(height: 110),

    // -~ Loading wiidget.
    Image.asset(
      'assets/images/loading_animation.gif',
      fit: BoxFit.cover,
      height: 200,
      width: 200,
    ),

    // ? Spacing.
    const SizedBox(height: 72),

    // -~ Loading Data text
    Text(
      appLanguage == 'en' ? 'Loading your data' : 'تحميل بياناتك',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 27,
        height: 1,
        fontWeight: FontWeight.w700,
        color: HexColor('#BA9062'),
        // TODO: Add Font family.
      ),
    ),

    // ? Spacing.
    const SizedBox(height: 80),

    // -~ Please wait
    Text(
      appLanguage == 'en' ? 'Please wait' : 'انتظر من فضلك',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 20,
        height: 1,
        fontWeight: FontWeight.w700,
        color: HexColor('#000000'),
        // TODO: Add Font family.
      ),
    ),
  ];
}

//////////////////////////////////////////////////////////////////

// ************** * No internet connection Ui. ************** /

Widget noInternetConnectionUi() {
  return WillPopScope(
    onWillPop: () async => false,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          appLanguage == 'en' ? 'Oups!' : 'للاسف',
          style: TextStyle(
            height: 1,
            fontSize: 35,
            fontWeight: FontWeight.w700,
            color: HexColor('#DC395F'),
            // TODO: Add Family.
          ),
        ),

        // ? Spacing.
        // const SizedBox(height: 50),

        // Image.
        Image.asset(
          'assets/images/error_connection_image.png',
          fit: BoxFit.cover,
        ),

        // -~ Message.
        Text(
          appLanguage == 'en' ? 'SomeThing went wrong' : 'هناك خطأ ما',
          style: TextStyle(
            height: 1,
            fontSize: 25,
            fontWeight: FontWeight.w700,
            color: HexColor('#FDFDFD'),
            // TODO: Add Family.
          ),
        ),

        // ? Spacing.
        // const SizedBox(height: 10),

        // -~ Message.
        Text(
          appLanguage == 'en'
              ? 'Please check \nyour internet connection'
              : 'يرجى المراجعة\nاتصالك بالإنترنت',
          textAlign: TextAlign.center,
          style: TextStyle(
            height: 1,
            fontSize: 25,
            fontWeight: FontWeight.w700,
            color: HexColor('#DC395F'),
            // TODO: Add Family.
          ),
        ),
      ],
    ),
  );
}

//////////////////////////////////////////////////////////////////

// ************** * Error Ui. ************** /

List<Widget> errorUi({
  required String errorMessage,
  required VoidCallback onPressed,
}) {
  return [
    // ? Top Padding.
    const SizedBox(height: 70),

    Text(
      appLanguage == 'en' ? 'Oups!' : 'للاسف',
      style: TextStyle(
        height: 1,
        fontSize: 35,
        fontWeight: FontWeight.w700,
        color: HexColor('#DC395F'),
        // TODO: Add Family.
      ),
    ),

    // ? Spacing.
    const SizedBox(height: 50),

    // Image.
    Image.asset(
      'assets/images/error_connection_image.png',
      fit: BoxFit.cover,
    ),

    // -~ Message.
    Text(
      appLanguage == 'en' ? 'SomeThing went wrong' : 'هناك خطأ ما',
      style: TextStyle(
        // height: 1,
        fontSize: 25,
        fontWeight: FontWeight.w700,
        color: HexColor('#DC395F'),
        // TODO: Add Family.
      ),
    ),

    // ? Spacing.
    const SizedBox(height: 25),

    // -~ Message.
    // TODO: Check how to read language cubit state to account cubit.
    Text(
      errorMessage,
      textAlign: TextAlign.center,
      style: TextStyle(
        height: 1.1,
        fontSize: 25,
        fontWeight: FontWeight.w700,
        color: HexColor('#000000'),
        // TODO: Add Family.
      ),
    ),

    // ? Spacing.
    const SizedBox(height: 140),

    // Return Action.
    returnButton(onPressed),

    // ? Spacing.
    const SizedBox(height: 90),
  ];
}

  //////////////////////////////////////////////////////