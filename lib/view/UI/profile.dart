import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/controllers/home/image_controller.dart';

class PortfolioScreen extends ConsumerWidget {
  const PortfolioScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String url =
        "https://media2.giphy.com/media/v1.Y2lkPTc5MGI3NjExajNncHJmZmp0OXA2dzRrNThia2l0eGlmdDc4dGwzMDVubmlzc2ZmYiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/RyoSZlTlU5OvBu088O/giphy.gif";
    String imageUrl =
        "https://images.hdqwalls.com/download/square-glitch-chaos-banner-abstract-4k-im-3840x2160.jpg";
    final imageIndex = ref.watch(
      changeImageByTime,
    ); 
    final imageUrls =
        ref
            .read(changeImageByTime.notifier)
            .currentImageUrl;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Section
            Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: imageUrls,
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 50,
                  left: 20,
                  child: Text(
                    'HafezCode.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Positioned(
                  top: 50,
                  right: 20,
                  child: Icon(Icons.menu, color: Colors.white),
                ),
                Positioned(
                  bottom: 40,
                  left: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello I am',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      Text(
                        'Mahmoud Hafez Eltarqi',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'UX Designer & Developer',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          disabledBackgroundColor: Colors.black,
                        ),
                        child: Text(
                          'Hire Me',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Stats Section
            Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      StatsItem(title: 'Projects', value: '42'),
                      StatsItem(title: 'Clients', value: '712'),
                      StatsItem(title: 'Messages', value: '92'),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Specialized In',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      SkillCard(icon: Icons.lightbulb, title: 'Concepting',color: Colors.amberAccent,),
                      SkillCard(icon: Icons.design_services, title: 'UI & UX',color: Colors.blueAccent,),
                      SkillCard(icon: Icons.brush, title: 'Visual Design',color: Colors.brown,),
                      SkillCard(icon: Icons.touch_app, title: 'Interaction',color: Colors.deepOrange,),
                      SkillCard(icon: Icons.analytics, title: 'Analysis',color: Colors.deepPurpleAccent,),
                      SkillCard(
                        icon: Icons.supervisor_account,
                        title: 'Client Relations',
                        color: Colors.deepOrange,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StatsItem extends StatelessWidget {
  final String title;
  final String value;

  const StatsItem({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        Text(title, style: TextStyle(fontSize: 14)),
      ],
    );
  }
}

class SkillCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;

  const SkillCard({
    super.key,
    required this.icon,
    required this.title,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 0.5),
        borderRadius: BorderRadius.circular(10),
        color: Colors.transparent,
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30, color: color),
            SizedBox(height: 5),
            Text(title, style: TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
