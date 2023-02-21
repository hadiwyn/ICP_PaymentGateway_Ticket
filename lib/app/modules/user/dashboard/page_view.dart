import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class pageView extends StatelessWidget {
  const pageView({super.key});

  @override
  Widget build(BuildContext context) {
    return PageView(
      scrollDirection: Axis.horizontal,
      children: [
        ClipRRect(
          // borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            'assets/image/klayar.jpeg',
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        ),
        ClipRRect(
          // borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            'assets/image/pangasan.jpeg',
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        ),
        ClipRRect(
          // borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            'assets/image/srau.jpeg',
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
