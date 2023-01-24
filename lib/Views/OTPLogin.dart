import 'package:alpha_app/utils/AppColors.dart';
import 'package:alpha_app/utils/ImageUtils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

enum LoginState { ENTER_NUMBER, ENTER_OTP }

class OTPLogin extends StatefulWidget {
  const OTPLogin({Key? key}) : super(key: key);

  @override
  State<OTPLogin> createState() => _OTPLoginState();
}

class _OTPLoginState extends State<OTPLogin> {
  final pinController = TextEditingController();
  final numController = TextEditingController();
  final focusNode = FocusNode();

  @override
  void dispose() {
    numController.dispose();
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  bool showError = false;

  static const length = 4;
  static const borderColor = Color.fromRGBO(114, 178, 238, 1);
  static const errorColor = Color.fromRGBO(255, 234, 238, 1);
  static const fillColor = Color.fromRGBO(222, 231, 240, .57);
  final defaultPinTheme = PinTheme(
    width: 56,
    height: 60,
    textStyle:
        const TextStyle(fontSize: 22, color: Color.fromRGBO(30, 60, 87, 1)),
    decoration: BoxDecoration(
      color: fillColor,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.transparent),
    ),
  );

  LoginState pageState = LoginState.ENTER_NUMBER;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
        padding: const EdgeInsets.all(24),
        width: Get.width,
        height: Get.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 80),
            Image.asset(
              ImageUtils.Logo,
              height: 200,
            ),
            const SizedBox(height: 20),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _enterNumberField(),
                const SizedBox(height: 40),
                pageState == LoginState.ENTER_OTP
                    ? _getOTPfield()
                    : Container(),
                const SizedBox(height: 40),
                _getActionButton(),
              ],
            )
          ],
        ),
      )),
    );
  }

  SizedBox _getActionButton() {
    return SizedBox(
      width: double.infinity,
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        onPressed: pageState == LoginState.ENTER_NUMBER
            ? () {
                //VALIDATORS
                pageState = LoginState.ENTER_OTP;
                setState(() {});
              }
            : () {},
        color: AppColors.primaryColor,
        child: Padding(
          padding: EdgeInsets.all(14.0),
          child: Text(
            pageState == LoginState.ENTER_NUMBER ? 'Get OTP' : 'Continue',
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Pinput _getOTPfield() {
    return Pinput(
      length: length,
      controller: pinController,
      focusNode: focusNode,
      defaultPinTheme: defaultPinTheme,
      onCompleted: (pin) {
        pageState = LoginState.ENTER_OTP;
        setState(() {});
      },
      focusedPinTheme: defaultPinTheme.copyWith(
        height: 68,
        width: 64,
        decoration: defaultPinTheme.decoration!.copyWith(
          border: Border.all(color: borderColor),
        ),
      ),
      errorPinTheme: defaultPinTheme.copyWith(
        decoration: BoxDecoration(
          color: errorColor,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  TextFormField _enterNumberField() {
    return TextFormField(
      controller: numController,
      keyboardType: TextInputType.number,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        hintText: 'Enter Number',
        enabled: pageState == LoginState.ENTER_NUMBER,
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.primaryColor),
            borderRadius: BorderRadius.circular(20)),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.primaryColor),
            borderRadius: BorderRadius.circular(20)),
        disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.primaryColor),
            borderRadius: BorderRadius.circular(20)),
        prefix: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            '(+1)',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor),
          ),
        ),
        suffixIcon: pageState == LoginState.ENTER_NUMBER
            ? Container()
            : IconButton(
                onPressed: () {
                  pageState = LoginState.ENTER_NUMBER;
                  setState(() {});
                },
                icon: const Icon(
                  Icons.edit,
                  size: 32,
                ),
              ),
      ),
    );
  }
}
