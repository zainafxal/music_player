import 'package:flutter/material.dart';
import 'package:music_player/Theme/theme_provider.dart';
import 'package:provider/provider.dart';

class NeuBox extends StatelessWidget {
  final Widget? child;
  const NeuBox({super.key, required this.child});

  @override
  Widget build(BuildContext context) {

    // bool for dark mode check
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return Container(

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9),
        color: Theme.of(context).colorScheme.background,
        boxShadow: [

        //   Dark shadow on the button right
          BoxShadow(
            color: isDarkMode? Colors.black : Colors.grey.shade500,
            blurRadius: 15,
            offset:  const Offset(4,4),
          ),

        //   Light Shadow on the top lef

          BoxShadow(
            color: isDarkMode? Colors.grey.shade800 :Colors.white,
            blurRadius: 15,
            offset:  const Offset(-4,-4),
          ),


        ]
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: child,
      ),
    );
  }
}
