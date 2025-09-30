import 'package:flutter/material.dart';
import 'package:flutter_internals/demo_buttons.dart';

class UIUpdatesDemo extends StatelessWidget {
  const UIUpdatesDemo({super.key});

  @override
  Widget build(BuildContext context) {
    print('UIUpdatesDemo BUILD called');
    return const Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Text(
              'Every Flutter developer should have a basic understanding of Flutter\'s internals!',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Do you understand how Flutter updates UIs?',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),
            // We are placing the Portion of Code which is Statefull in a Second Widget
            // Make Stateful Code as small as possible
            // So when state changes, Flutter does not have to recheck all widgets which are constant
            // E.g. Padddings, Texts, Sized Boxes above.
            DemoButtons(),
          ],
        ),
      ),
    );
  }
}
