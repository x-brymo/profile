import 'package:flutter/material.dart';
import 'package:profile/core/utils/extension_Qe.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Column(
       children: [
         CustomAppBar(),
          Container(
            width: double.infinity,
            height: context.hQ ,
            color: Colors.white,
            child: ListView(
              children:[
                Container(
                  width: double.infinity,
                  height: context.hQ *0.2,
                  color: Colors.blue,
                ),
                Container(
                  width: double.infinity,
                  height: context.hQ *0.2,
                  color: Colors.green,
                ),
                Container(
                  width: double.infinity,
                  height: context.hQ *0.2,
                  color: Colors.red,
                ),
                Container(
                  width: double.infinity,
                  height: context.hQ *0.2,
                  color: Colors.yellow,
                ),
                Container(
                  width: double.infinity,
                  height: context.hQ *0.2,
                  color: Colors.purple,
                ),
                Container(
                  width: double.infinity,
                  height: context.hQ *0.2,
                  color: Colors.orange,
                ),
                Container(
                  width: double.infinity,
                  height: context.hQ *0.2,
                  color: Colors.pink,
                ),
                Container(
                  width: double.infinity,
                  height: context.hQ *0.2,
                  color: Colors.teal,
                ),
                Container(
                  width: double.infinity,
                  height: context.hQ *0.2,
                  color: Colors.brown,
                ),
                Container(
                  width: double.infinity,
                  height: context.hQ *0.2,
                  color: Colors.grey,
                ),
              ]
            ),
          ),
          Flexible(
            flex: 5,
            child: Container(
              width: double.infinity,
              height: context.hQ *0.08,
              color: Colors.deepOrangeAccent,
            ),
          ),

       ],
     ),
    );
  }
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