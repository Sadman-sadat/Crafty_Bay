import 'package:crafty_bay/data/models/create_product_review_model.dart';
import 'package:crafty_bay/presentation/state_holders/create_product_review_controller.dart';
import 'package:crafty_bay/presentation/widgets/centered_circular_progress_indicator.dart';
import 'package:crafty_bay/presentation/widgets/snack_bar_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateReviewScreen extends StatefulWidget {
  const CreateReviewScreen({super.key, required this.productId,});

  final int productId;

  @override
  State<CreateReviewScreen> createState() => _CreateReviewScreenState();
}

class _CreateReviewScreenState extends State<CreateReviewScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _writeReviewTEController = TextEditingController();
  final _productRatingTEController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reviews')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              _buildCompleteProfileForm(),
              const SizedBox(height: 16),
              GetBuilder<CreateProductReviewController>(
                builder: (createProductReviewController) {
                  if(createProductReviewController.inProgress){
                    return const CenteredCircularProgressIndicator();
                  }

                  return ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        CreateProductReviewModel productReview = CreateProductReviewModel(
                          productId: widget.productId,
                          description: _writeReviewTEController.text.trim(),
                          rating: _productRatingTEController.text.trim(),
                        );

                        bool success = await createProductReviewController.createReview(productReview);
                        if (!success) {
                          showSnackMessage(context, createProductReviewController.errorMessage);
                        } else {
                          showSnackMessage(context, 'Review submitted successfully!');
                        }
                      }
                    },

                    child: const Text('Submit'),
                  );
                }
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
            controller: _writeReviewTEController,
            maxLines: 10,
            decoration: const InputDecoration(hintText: 'Write Review'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please write a review.';
              }
              return null;
            },
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _productRatingTEController,
            decoration: const InputDecoration(hintText: 'Rating'),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value != null && value.isNotEmpty) {
                final int? parsedRating = int.tryParse(value);
                if (parsedRating == null || parsedRating < 1 || parsedRating > 5) {
                  return 'Rating must be between 1 and 5.';
                }
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
    _writeReviewTEController.dispose();
    _productRatingTEController.dispose();
    super.dispose();
  }
}