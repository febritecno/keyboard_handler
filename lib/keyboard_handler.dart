library keyboard_handler;

import 'package:flutter/cupertino.dart';

class KeyboardHandler extends StatelessWidget {
  // turn Scaffold() props -> resizeToAvoidBottomInset: true (optional)
  // use props -> setDefaultSize -> auto mode (set triggerSize,mainSize null)
  // use props -> triggerSize,mainSize -> if custom mode needed!

  // triggerSize -> if event Keyboard was opened
  // mainSize -> if event Keyboard was hidden (idle screen)
  // setDefaultSize -> automatic mode set triggerSize and mainSize same value

  final double? triggerSize, mainSize, setDefaultSize;
  final Widget? child;
  final BuildContext getContext;

  const KeyboardHandler({
    Key? key,
    required this.child,
    required this.getContext,
    this.triggerSize,
    this.mainSize,
    this.setDefaultSize: 30,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // check keyboard status
    bool _isKeyboardOpen = MediaQuery.of(getContext).viewInsets.bottom != 0;

    // calculate & predict keyboardHeight (responsive!)
    double _keyboardHeight(double screenSize) {
      // get keyboard height
      double _keyboardHeight = MediaQuery.of(getContext).viewInsets.bottom;
      var calcSize = screenSize - _keyboardHeight;
      return calcSize;
    }

    // set height mode percent
    double _percentHeight(double height) {
      return ((MediaQuery.of(getContext).size.height) * height) / 100;
    }

    // get screenHeight
    double _screenHeight() {
      return (MediaQuery.of(getContext).size.height);
    }

    return SizedBox(
        height: _isKeyboardOpen
            ? _keyboardHeight(triggerSize ??
                _screenHeight() - _percentHeight(setDefaultSize!))
            : mainSize ?? _screenHeight() - _percentHeight(setDefaultSize!),
        child: child);
  }
}