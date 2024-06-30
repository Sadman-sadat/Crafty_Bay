import 'dart:async';
import 'package:crafty_bay/presentation/screens/auth/complete_profile_screen.dart';
import 'package:crafty_bay/presentation/screens/main_bottom_nav_bar_screen.dart';
import 'package:crafty_bay/presentation/state_holders/auth/read_profile_controller.dart';
import 'package:crafty_bay/presentation/state_holders/auth/verify_email_controller.dart';
import 'package:crafty_bay/presentation/state_holders/auth/verify_otp_controller.dart';
import 'package:crafty_bay/presentation/utility/app_colors.dart';
import 'package:crafty_bay/presentation/widgets/app_logo.dart';
import 'package:crafty_bay/presentation/widgets/snack_bar_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String email;

  const OtpVerificationScreen({super.key, required this.email});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final _otpTEController = TextEditingController();
  static const int _initialTime = 5;
  final _isButtonEnabled = false.obs;
  final _remainingTime = _initialTime.obs;
  Timer? _buttonTimer;

  final ReadProfileController _readProfileController = Get.find<ReadProfileController>();
  final VerifyEmailController _verifyEmailController = Get.find<VerifyEmailController>();

  @override
  void initState() {
    super.initState();
    _startCountDownTimer();
  }

  void _startCountDownTimer() {
    _buttonTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime.value <= 0) {
        _isButtonEnabled.value = true;
        timer.cancel();
      } else {
        _remainingTime.value--;
      }
    });
  }

  void _resetTimer() {
    _verifyEmailController.verifyEmail(widget.email).then((success) {
      if (success) {
        _buttonTimer?.cancel();
        _remainingTime.value = _initialTime;
        _isButtonEnabled.value = false;
        _startCountDownTimer();
        showSnackMessage(context, 'OTP resent successfully');
      } else {
        showSnackMessage(context, _verifyEmailController.errorMessage);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const SizedBox(height: 120),
              const AppLogo(),
              const SizedBox(height: 16),
              Text("Enter OTP Code", style: textTheme.headlineLarge),
              const SizedBox(height: 4),
              Text("A 4 digit OTP code has been sent",
                  style: textTheme.headlineSmall),
              const SizedBox(height: 24),
              _buildPinField(context),
              const SizedBox(height: 16),
              GetBuilder<VerifyOtpController>(builder: (verifyOtpController) {
                if (verifyOtpController.inProgress) {
                  return const CircularProgressIndicator();
                }

                return ElevatedButton(
                  onPressed: () async {
                    final result = await verifyOtpController.verifyOtp(
                        widget.email, _otpTEController.text);
                    if (result) {
                      final hasProfile = await _readProfileController.readProfile();
                      if(hasProfile) {
                        Get.offAll(() => const MainBottomNavBarScreen());
                      } else {
                        Get.to(() => const CompleteProfileScreen());
                      }
                    } else {
                      if(mounted){
                        showSnackMessage(
                            context, verifyOtpController.errorMessage);
                      }
                    }
                  },
                  child: const Text('Next'),
                );
              }),
              const SizedBox(height: 24),
              _buildResendCodeMessage(),
              Obx(
                () => TextButton(
                  onPressed: _isButtonEnabled.value ? _resetTimer : null,
                  child: const Text('Resend Code'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResendCodeMessage() {
    return Obx(
      () => RichText(
        text: TextSpan(
          style: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
          children: [
            const TextSpan(text: 'This code will expired in '),
            TextSpan(
              text: _remainingTime.value > 0 ? "${_remainingTime.value}s" : '',
              style: const TextStyle(color: AppColors.primaryColor),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPinField(BuildContext context) {
    return PinCodeTextField(
      length: 6,
      obscureText: false,
      animationType: AnimationType.fade,
      keyboardType: TextInputType.number,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5),
        fieldHeight: 50,
        fieldWidth: 40,
        activeFillColor: Colors.white,
        inactiveFillColor: Colors.transparent,
        selectedFillColor: Colors.white,
      ),
      animationDuration: const Duration(milliseconds: 300),
      enableActiveFill: true,
      controller: _otpTEController,
      appContext: context,
    );
  }

  @override
  void dispose() {
    _buttonTimer?.cancel();
    super.dispose();
  }
}
