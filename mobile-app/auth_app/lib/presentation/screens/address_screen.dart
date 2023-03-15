import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../router/screens_name.dart';
import '../ui/address_ui.dart';
import '../ui/global/global_ui.dart';

import '../../logic/address/address_cubit.dart';
import '../../logic/setting/appsetting_cubit.dart';
import '../../logic/connection/network_connection_cubit.dart';

import '../../utils/colors/color_configuration.dart';
import '../../utils/data/universal_data.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  late AddressUi _addressUi;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _addressUi = AddressUi(addressActions: context.read<AddressCubit>());
  }

  @override
  Widget build(BuildContext context) {
    print('Address has been called');
    return Scaffold(
      body: Directionality(
        textDirection:
            appLanguage == 'en' ? TextDirection.ltr : TextDirection.rtl,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: BlocBuilder<NetworkConnectionCubit, NetworkConnectionState>(
            builder: (context, state) {
              return state is InternetConnectedState
                  ? _addressScreens()
                  : noInternetConnectionUi();
            },
          ),
        ),
      ),
    );
  }

  Widget _addressScreens() {
    return BlocBuilder<AddressCubit, AddressState>(
      buildWhen: (previous, current) =>
          previous.addressScreenState != current.addressScreenState,
      builder: (context, state) {
        return WillPopScope(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisSize: MainAxisSize.min,
              children: [
                // **** * Add address UI ******* /
                if (state.addressScreenState ==
                    AddressScreenStateEnum.newAddressState)
                  ..._addressUi.newAddressUi(
                    () =>
                        Navigator.of(context).pushReplacementNamed(HOME_SCREEN),
                  )

                // **** * Loading UI ******* /
                else if (state.addressScreenState ==
                    AddressScreenStateEnum.loadingState)
                  ...loadingUi(null)

                // **** * Complete UI ******* /
                else if (state.addressScreenState ==
                    AddressScreenStateEnum.completeState)
                  // TODO: Add method which will
                  ...loadingUi(
                    () => Future.delayed(
                      const Duration(microseconds: 25),
                      () => Navigator.of(context)
                          .pushReplacementNamed(HOME_SCREEN),
                    ),
                  )

                // **** * Error UI ******* /
                else
                  ...errorUi(
                    errorMessage: state.errorMessage,
                    onPressed:
                        context.read<AddressCubit>().goToPreviousStateAction,
                  ),
              ],
            ),
          ),
          onWillPop: () async {
            state.addressScreenState == AddressScreenStateEnum.errorState
                ? context.read<AddressCubit>().goToPreviousStateAction()
                : null;

            return false;
          },
        );
      },
    );
  }
}
