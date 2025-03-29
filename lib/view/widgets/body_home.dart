
import 'package:flutter/material.dart';

class BodyHome extends StatelessWidget {
  const BodyHome({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> texts = [
      "My Name Mahmoud Hafez",
      "I am a Flutter Developer",
      "I Love to code",
      "I Love to learn",
      "I Love to share",
      "I Love to help",
    ];
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    final mq = MediaQuery.of(context);
    final wQ = mq.size.width;
    final hQ = mq.size.height;
    final image =
        "https://images.hdqwalls.com/download/square-glitch-chaos-banner-abstract-4k-im-3840x2160.jpg";
    return Column(
      children: [
        SizedBox(
          height: hQ * 0.52,
          width: wQ,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder:
                (context, index) => Container(
                  color: Colors.amberAccent,
                  child: Text(texts[index]),
                
                ),
                itemCount: texts.length,
          ),
        ),
        SizedBox(height: hQ * 0.02),
      ],
    );
  }
}
