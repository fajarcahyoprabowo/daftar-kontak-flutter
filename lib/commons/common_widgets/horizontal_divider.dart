import 'package:assestment_telkom_fajar/commons/pallets.dart';
import 'package:flutter/material.dart';

class HorizontalDivider extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  final Color? color;
  final double height;

  const HorizontalDivider({
    Key? key,
    this.padding = EdgeInsets.zero,

    /// default color is scorpion
    this.color,
    this.height = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Container(
        height: height,
        width: double.infinity,
        color: color ?? Pallets.scorpion,
      ),
    );
  }
}
