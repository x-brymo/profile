import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}
class _SplashViewState extends ConsumerState<SplashView> with SingleTickerProviderStateMixin {
  final Duration _duration = const Duration(seconds: 7);
  late AnimationController _controller;
  late Animation<double> _animation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(vsync: this, duration: _duration)..repeat(
      reverse: true,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    Timer(_duration, () {
      Navigator.pushReplacementNamed(context, '/intro');
    });
  }
  @override
  dispose(){
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
            Center(
        child: LoadingAnimationWidget.fourRotatingDots(
          color: Theme.of(context).colorScheme.primary,
          // leftDotColor: const Color(0xFF1A1A3F),
          // rightDotColor: const Color(0xFFEA3799),
          size: 50,
        ),),
            SizedBox(height: 20),
            Text('Loading...'),
      //      Center(
      //   child: AnimatedBuilder(
      //     animation: _animation,
      //     builder: (context, child) {
      //       return Transform.scale(
      //         scale: _animation.value,
      //         child: SvgPicture.asset(
      //           'assets/svg/x.svg',
      //           height: 200,
      //           width: 200,
      //         ),
      //       );
      //     },
      //   ),
      // ),
          ],
        ),
      ),
    );
  }
}