import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:profile/domain/controllers/home/Bottomnavigationbar_controller.dart';

class Bottomnavigationbars extends ConsumerWidget {
  const Bottomnavigationbars({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(bottomNavBar);
    final gradienColors = ref.watch(gradienColor);
    return ClipRRect(
      borderRadius: BorderRadius.circular(35),
      child: AnimatedContainer(
              duration: Duration(seconds: 19), // Animation duration
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradienColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),),
        child: BottomNavigationBar(
         backgroundColor: Colors.transparent, // Make it transparent
          elevation: 0, // Remove shadow
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          currentIndex: selected,
          onTap: (i)=> ref.read(bottomNavBar.notifier).state = i,
          items: _items,
          //type: BottomNavigationBarType.fixed,
         
        ),
        
      ),
    );
  }
// Suggested code may be subject to a license. Learn more: ~LicenseLog:2099043145.
  List<BottomNavigationBarItem> get _items => [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
    BottomNavigationBarItem(icon: Icon(Icons.person), label : '0')];
}