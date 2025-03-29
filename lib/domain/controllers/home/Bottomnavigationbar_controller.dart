import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final bottomNavBar = StateProvider<int>((ref)=> 0);
final gradienColor = Provider<List<Color>>((ref){
 final index = ref.watch(bottomNavBar);
  return [
     [Colors.blue, Colors.purple], // Home
    [Colors.red, Colors.orange],  // Search
    [Colors.green, Colors.teal],  // Profile
  ][index];
});