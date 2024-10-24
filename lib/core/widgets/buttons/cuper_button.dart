import 'package:flutter/cupertino.dart';

class CuperButton extends StatelessWidget {
  const CuperButton({
    super.key,
    this.onPressed,
    this.padding = 0,
    this.minSize = kMinInteractiveDimensionCupertino,
    required this.child,
  });

  final void Function()? onPressed;
  final double padding;
  final double minSize;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
      padding: EdgeInsets.all(padding),
      minSize: minSize,
      child: child,
    );
  }
}
