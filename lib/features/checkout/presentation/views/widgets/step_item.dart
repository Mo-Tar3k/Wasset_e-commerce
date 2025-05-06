import 'package:e_commerce/features/checkout/presentation/views/widgets/active_step_item.dart';
import 'package:e_commerce/features/checkout/presentation/views/widgets/inactive_step_item.dart';
import 'package:flutter/material.dart';

class StepItem extends StatelessWidget {
  const StepItem({
    super.key,
    required this.index,
    required this.text,
    required this.isActive,
  });

  final String index, text;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      firstChild: InActiveStepItem(index: index, text: text),
      duration: const Duration(milliseconds: 300),
      secondChild: ActiveStepItem(text: text),
      crossFadeState:
          isActive ? CrossFadeState.showSecond : CrossFadeState.showFirst,
    );
  }
}
