import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:profile/core/constant/image_network.dart';
import 'package:profile/domain/controllers/home/image_controller.dart';
import 'package:url_launcher/url_launcher.dart';
class IntroView extends ConsumerWidget {
  const IntroView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imagePro = ref.watch(changeImageByTime);
    final imageUrl = ref.read(changeImageByTime.notifier).currentImageUrl;
    double sizeIcon = 25;
     double size = 40;
    return Scaffold(
     //backgroundColor: Colors.black,
     
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: ImageNetwork.image,
                   
                    colorBlendMode: BlendMode.colorBurn,
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 40,
                  left: 20,
                  child: Text('HafezCode.', style: TextStyle( 
                    color: Color(0xffffffff),
                    fontSize: 24, fontWeight: FontWeight.bold)),
                ),
                Positioned(
                  top: 40,
                  right: 20,
                  child: Icon(Icons.menu,
                   color: Color(0xffffffff),
                   ),
                ),
                Positioned(
                  bottom: 60,
                  left: 20,
                  right: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Hello I am', style: TextStyle( fontSize: 18, color: Color(0xffffffff),)),
                      Text('Mahmoud Hafez Eltarqi', style: TextStyle( color: Color(0xffffffff), fontSize: 26, fontWeight: FontWeight.bold)),
                      Text('Front-end & Developer Flutter', style: TextStyle(  color: Color(0xffffffff),fontSize: 16)),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/home');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          disabledBackgroundColor: Colors.black,
                          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                        ),
                        child: Text('Hire Me',style: TextStyle(color: Colors.black),),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          
                          ButtonSocial(
                            icon: FontAwesomeIcons.x,
                            iconColor: Colors.black,
                            color: Colors.white,
                            size: size,
                            sizeIcon: sizeIcon,
                            url: "https://hafezcode.vercel.app",
                          ),
                          ButtonSocial(
                            icon: FontAwesomeIcons.facebook,
                            iconColor: Colors.white,
                            color: Colors.blueAccent,
                            size: size,
                            sizeIcon: sizeIcon,
                            url: "https://hafezcode.vercel.app",
                          ),
                          ButtonSocial(
                            icon: FontAwesomeIcons.instagram,
                            iconColor: Colors.deepOrange,
                            color: Colors.white,
                            size: size,
                            sizeIcon: sizeIcon,
                            url: "https://hafezcode.vercel.app",
                          ),
                          ButtonSocial(
                            icon: FontAwesomeIcons.linkedinIn,
                            iconColor: Colors.lightBlue,
                            color: Colors.white,
                            size: size,
                            sizeIcon: sizeIcon,
                            url: "https://hafezcode.vercel.app",
                          ),
                          ButtonSocial(
                            icon: FontAwesomeIcons.telegram,
                            iconColor: Colors.lightBlue,
                            color: Colors.white,
                            size: size,
                            sizeIcon: sizeIcon,
                            url: "https://hafezcode.vercel.app",
                          ),
                          ButtonSocial(
                            icon: FontAwesomeIcons.mailForward,
                            iconColor: Colors.white,
                            color: Colors.black,
                            size: size,
                            sizeIcon: sizeIcon,
                            url: "https://hafezcode.vercel.app",
                          ),
                         
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ButtonSocial extends StatelessWidget {
  final IconData icon;
  final String url;
  final Color? color;
  final double? size;
  final double? sizeIcon;
  final Color? iconColor;

  const ButtonSocial({super.key, required this.icon, required this.url, this.color, this.size, this.sizeIcon, this.iconColor});

 
  void _launchURL(String url) async {
  Uri uri = Uri.parse(url); // Ensure proper formatting
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    throw 'Could not launch $url';
  }
}
  @override
  Widget build(BuildContext context) {
    return Container(
      height: size ??40,
      width:size?? 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ]
      ),
      child:GestureDetector(
        onTap: (){
          _launchURL(url);
        },
        child: Icon(icon, color: iconColor,size: sizeIcon),
      )
    );
  }
}