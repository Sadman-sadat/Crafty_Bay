import 'package:crafty_bay/presentation/screens/auth/otp_verification_screen.dart';
import 'package:crafty_bay/presentation/state_holders/auth/verify_email_controller.dart';
import 'package:crafty_bay/presentation/utility/constants.dart';
import 'package:crafty_bay/presentation/widgets/app_logo.dart';
import 'package:crafty_bay/presentation/widgets/centered_circular_progress_indicator.dart';
import 'package:crafty_bay/presentation/widgets/snack_bar_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 120),
              const AppLogo(),
              const SizedBox(height: 16),
              Text("Welcome Back", style: textTheme.headlineLarge),
              const SizedBox(height: 4),
              Text("Please Enter Your Email Address", style: textTheme.headlineSmall),
              const SizedBox(height: 24),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: _emailTEController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: 'Email',
                ),
                validator: (String? value) {
                  if(value?.isEmpty ?? true){
                    return 'Enter your Email';
                  }
                  if (!Constants.emailValidatorRegExp.hasMatch(value!)) {
                    return 'Enter a valid Email address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              GetBuilder<VerifyEmailController>(
                builder: (verifyEmailController) {
                  if(verifyEmailController.inProgress){
                    return const CenteredCircularProgressIndicator();
                  }
                  return ElevatedButton(
                    onPressed: (){
                      if(_formKey.currentState!.validate()){
                         verifyEmailController.verifyEmail(_emailTEController.text.trim()).then((result) {
                           if(result){
                              Get.to(() => OtpVerificationScreen(email: _emailTEController.text));
                           } else {
                             showSnackMessage(context, verifyEmailController.errorMessage);
                           }
                         });
                      }
                    },
                    child: const Text('Next'));
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    super.dispose();
    _emailTEController;
  }
}
