import 'package:music_player/Theme/theme_provider.dart';
import 'package:music_player/Pages/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {

  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:  Text(
            "Settings",
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
          backgroundColor: Theme.of(context).colorScheme.secondary,
          centerTitle: true,
          leading: IconButton(
            icon:  Icon(Icons.arrow_back,
                color: Theme.of(context).colorScheme.primary), // Set color to white
            onPressed: () => Navigator.pop(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                )),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Theme.of(context).colorScheme.secondary,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Dark Mode"),
                CupertinoSwitch(
                  value: Provider.of<ThemeProvider>(context, listen: false)
                      .isDarkMode,
                  onChanged: (value) => Provider.of<ThemeProvider>(context, listen: false)
                      .toggleThemes(),)
              ],
            ),
          ),
        ));
  }
}
