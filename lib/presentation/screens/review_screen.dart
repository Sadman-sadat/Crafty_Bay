import 'package:crafty_bay/presentation/screens/create_review_screen.dart';
import 'package:crafty_bay/presentation/screens/auth/email_verification_screen.dart';
import 'package:crafty_bay/presentation/state_holders/review_list_controller.dart';
import 'package:crafty_bay/presentation/state_holders/auth/user_auth_controller.dart';
import 'package:crafty_bay/presentation/widgets/bottomActonCard.dart';
import 'package:crafty_bay/presentation/widgets/product_review_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key, required this.productId});

  final int productId;

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {

  @override
  void initState() {
    super.initState();
    Get.find<ReviewListController>().getReviewList(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reviews'),
      ),
      body: GetBuilder<ReviewListController>(
        builder: (reviewListController) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: reviewListController.reviewList.length,
                  itemBuilder: (context, index) {
                    return ProductReviewCard(reviewItem: reviewListController.reviewList[index],);
                  },
                ),
              ),
              BottomActionCard(
                buttonSize: 100,
                mainText: 'Reviews (${reviewListController.reviewList.length})',
                buttonChild: const Icon(Icons.add),
                onButtonPressed: () async {
                  final isLoggedIn = await UserAuthController.checkLoggedInState();
                  if(!isLoggedIn){
                    Get.to(() => const EmailVerificationScreen());
                    return;
                  }
                  Get.to(() => CreateReviewScreen(productId: widget.productId,));
                },
              ),
            ],
          );
        }
      ),
    );
  }
}
