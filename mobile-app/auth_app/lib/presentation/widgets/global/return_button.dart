import 'package:flutter/material.dart';

import '../../../utils/colors/color_configuration.dart';
import '../../../utils/data/universal_data.dart';

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
