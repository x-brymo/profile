import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:profile/core/utils/extension_Qe.dart';
import 'package:profile/domain/controllers/home/Bottomnavigationbar_controller.dart';
import 'package:profile/view/widgets/body_home.dart';

import 'bottomNavigationBar.dart';

class LayoutView extends ConsumerWidget {
   LayoutView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final selected = ref.watch(bottomNavBar);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Colors.transparent,
        elevation: 0,                                   
        //iconTheme: IconThemeData(color: Theme.of(context).colorScheme.secondary),       
        actions: [
          IconButton(
            onPressed: (){},
            icon: Icon(Icons.notifications),
           // color: Theme.of(context).colorScheme.secondary,
          ),
        ],
        leading: IconButton(
          onPressed: (){},
          icon: Icon(Icons.menu),
         // color: Theme.of(context).colorScheme.secondary,
        ),

      ),
     body: _pages[selected],
     // bodyHome(texts: texts, textTheme: textTheme, colorScheme: colorScheme, image: image),
     bottomNavigationBar: Bottomnavigationbars(),
     extendBody: true,
    );
  }
  final List<Widget>  _pages = [
      BodyHome(),
      Center(child: Text('🔍 Search', style: TextStyle(fontSize: 24))),
      Center(child: Text('👤 Profile', style: TextStyle(fontSize: 24))),
    ];
}




class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
     width: double.infinity,
     height: context.hQ *0.122,
     decoration: BoxDecoration(
       color: Colors.transparent,
       borderRadius: BorderRadius.only(
         bottomLeft: Radius.circular(20),
         bottomRight: Radius.circular(20),
       ),
     ),
     child: Row(
       mainAxisAlignment: MainAxisAlignment.spaceBetween,
       children: [
         IconButton(
           onPressed: (){},
           icon: Icon(Icons.menu),
           color: Theme.of(context).colorScheme.secondary,
         ),
         Text('Home', style: Theme.of(context).textTheme.headlineSmall,),
         IconButton(
           onPressed: (){},
           icon: Icon(Icons.notifications),
           color: Theme.of(context).colorScheme.secondary,
         ),
       ],
     ),
    );
  }
}