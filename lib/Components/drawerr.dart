import 'package:flutter/material.dart';
import 'package:music_player/Pages/settings_page.dart';

class Darwerr extends StatefulWidget {
  const Darwerr({super.key});

  @override
  State<Darwerr> createState() => _DarwerrState();
}

class _DarwerrState extends State<Darwerr> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.65,
      backgroundColor: Theme.of(context).colorScheme.background,
      child:  Column(
        children: [
          // Logo
          DrawerHeader(child: Center(child: Icon(Icons.music_note,color: Theme.of(context).colorScheme.primary,size: 60,),)),

          // Home Tile
          Padding(
            padding: const EdgeInsets.only(left: 25,top: 25),
            child: ListTile(
              leading: const Icon(Icons.home),
              title: const Text("H O M E"),
              onTap: () => Navigator.pop(context),
            ),
          ),



        //   Settings Tile

          Padding(
            padding: const EdgeInsets.only(left: 25,top: 25),
            child:  ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("S E T T I N  S"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage(),));
              },
            ),
          ),


        ],
      ),
    );
  }
}
