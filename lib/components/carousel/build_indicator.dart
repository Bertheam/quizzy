import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BuildIndicator extends StatelessWidget {
  final int length;
  final int index;

  const BuildIndicator({super.key, required this.length, required this.index});

  @override
  Widget build(BuildContext context) {
    return AnimatedSmoothIndicator(
      activeIndex: index,
      count: length,
      effect: ExpandingDotsEffect(dotColor: Colors.blue.shade800, dotWidth: 8,activeDotColor: Color.fromARGB(255, 63, 160, 217)),
    );
  }
}
