import 'package:crafty_bay/presentation/screens/main_bottom_nav_bar_screen.dart';
import 'package:crafty_bay/presentation/state_holders/auth/create_profile_controller.dart';
import 'package:crafty_bay/presentation/widgets/app_logo.dart';
import 'package:crafty_bay/presentation/widgets/centered_circular_progress_indicator.dart';
import 'package:crafty_bay/presentation/widgets/snack_bar_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({
    super.key,
  });

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _nameTEController = TextEditingController();
  final _mobileTEController = TextEditingController();
  final _cityTEController = TextEditingController();
  final _shippingAddressTEController = TextEditingController();
  final _stateTEController = TextEditingController();
  final _postcodeTEController = TextEditingController();
  final _countryTEController = TextEditingController();
  final _faxTEController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                const SizedBox(height: 40),
                const AppLogo(),
                const SizedBox(height: 16),
                Text("Complete Profile", style: textTheme.headlineLarge),
                const SizedBox(height: 4),
                Text("Get started with us by providing your details",
                    style: textTheme.headlineSmall),
                const SizedBox(height: 24),
                _buildCompleteProfileForm(),
                const SizedBox(height: 16),
                GetBuilder<CreateProfileController>(
                    builder: (createProfileController) {
                  if (createProfileController.inProgress) {
                    return const CenteredCircularProgressIndicator();
                  }
                  return ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final createProfileController =
                              Get.find<CreateProfileController>();
                                createProfileController.createProfile(
                                  _nameTEController.text,
                                  _shippingAddressTEController.text,
                                  _cityTEController.text,
                                  _stateTEController.text,
                                  _postcodeTEController.text,
                                  _countryTEController.text,
                                  _mobileTEController.text,
                                  _faxTEController.text,
                                ).then((isSuccess) {
                            if (isSuccess) {
                              Get.to(() => const MainBottomNavBarScreen());
                            } else {
                              showSnackMessage(context,
                                  createProfileController.errorMessage);
                            }
                          });
                        }
                      },
                      child: const Text('Next'));
                }),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCompleteProfileForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _nameTEController,
            decoration: const InputDecoration(hintText: 'Name'),
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Enter your Name';
              }
              return null;
            },
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _shippingAddressTEController,
            maxLines: 3,
            decoration: const InputDecoration(hintText: 'Shipping Address'),
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Enter your Shipping Address';
              }
              return null;
            },
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _cityTEController,
            decoration: const InputDecoration(hintText: 'City'),
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Enter your City';
              }
              return null;
            },
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _stateTEController,
            decoration: const InputDecoration(hintText: 'State'),
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Enter your State';
              }
              return null;
            },
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _postcodeTEController,
            decoration: const InputDecoration(hintText: 'Postcode'),
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Enter your Postcode';
              }
              return null;
            },
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _countryTEController,
            decoration: const InputDecoration(hintText: 'Country'),
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Enter your Country';
              }
              return null;
            },
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _mobileTEController,
            decoration: const InputDecoration(hintText: 'Mobile'),
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Enter your Mobile';
              }
              return null;
            },
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _faxTEController,
            decoration: const InputDecoration(hintText: 'Fax'),
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Enter your Fax';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nameTEController.dispose();
    _mobileTEController.dispose();
    _cityTEController.dispose();
    _shippingAddressTEController.dispose();
    _stateTEController.dispose();
    _postcodeTEController.dispose();
    _countryTEController.dispose();
    _faxTEController.dispose();
    super.dispose();
  }
}
