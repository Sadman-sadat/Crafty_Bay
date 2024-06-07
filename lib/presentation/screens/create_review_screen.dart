import 'package:flutter/material.dart';

class CreateReviewScreen extends StatefulWidget {
  const CreateReviewScreen({super.key,});

  @override
  State<CreateReviewScreen> createState() => _CreateReviewScreenState();
}

class _CreateReviewScreenState extends State<CreateReviewScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _firstNameTEController = TextEditingController();
  final _lastNameTEController = TextEditingController();
  final _writeReviewTEController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reviews')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const SizedBox(height: 16),
              _buildCompleteProfileForm(),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Submit'),
              ),
              const SizedBox(height: 24),
            ],
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
            controller: _firstNameTEController,
            decoration: const InputDecoration(hintText: 'First Name'),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _lastNameTEController,
            decoration: const InputDecoration(hintText: 'Last Name'),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _writeReviewTEController,
            maxLines: 10,
            decoration: const InputDecoration(hintText: 'Write Review'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _writeReviewTEController.dispose();
    super.dispose();
  }
}