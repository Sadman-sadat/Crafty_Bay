import 'package:crafty_bay/presentation/utility/app_colors.dart';
import 'package:flutter/material.dart';

class BottomActionCard extends StatelessWidget {
  final String mainText;
  final String? subText;
  final Widget buttonChild;
  final VoidCallback onButtonPressed;
  final double buttonSize;

  const BottomActionCard({
    super.key,
    required this.mainText,
    this.subText,
    required this.buttonChild,
    required this.onButtonPressed,
    required this.buttonSize,
  });

  @override
  Widget build(BuildContext context) {
    bool isIcon = buttonChild is Icon;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: AppColors.primaryColor.withOpacity(0.1),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildInfoSection(),
          _buildButtonSection(isIcon, buttonSize),
        ],
      ),
    );
  }

  Widget _buildButtonSection(bool isIcon, double buttonSize) {
    return SizedBox(
      width: buttonSize,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: isIcon
              ? const CircleBorder()
              : RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
          padding: EdgeInsets.symmetric(
            horizontal: isIcon ? 16.0 : 24.0,
            vertical: isIcon ? 16.0 : 12.0,
          ),
        ),
        onPressed: onButtonPressed,
        child: buttonChild,
      ),
    );
  }

  Widget _buildInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          mainText,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        if (subText != null)
          Text(
            subText!,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 24,
              color: AppColors.primaryColor,
            ),
          ),
      ],
    );
  }
}
