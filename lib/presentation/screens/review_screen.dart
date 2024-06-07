import 'package:crafty_bay/presentation/screens/create_review_screen.dart';
import 'package:crafty_bay/presentation/widgets/bottomActonCard.dart';
import 'package:crafty_bay/presentation/widgets/product_review_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reviews'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 7,
              itemBuilder: (context, index) {
                return const ProductReviewCard();
              },
            ),
          ),
          BottomActionCard(
            buttonSize: 100,
            mainText: 'Reviews (1000)',
            buttonChild: const Icon(Icons.add),
            onButtonPressed: () {
              Get.to(() => const CreateReviewScreen());
            },
          ),
        ],
      ),
    );
  }
}
