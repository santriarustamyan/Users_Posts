import 'package:flutter/material.dart';

class TableWidget extends StatelessWidget {
  final Color color1;
  final Color color2;
  final Color colorborder;
  final String? text1;
  final String? text2;
  late final double sizeWidth;
  TableWidget({
    required this.text1,
    required this.text2,
    this.sizeWidth = 90,
    this.colorborder = Colors.blue,
    this.color1 = Colors.white,
    this.color2 = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(0),
      child: SingleChildScrollView(
        child: Table(
          columnWidths: {
            0: FixedColumnWidth(sizeWidth),
            1: FlexColumnWidth(),
          },
          children: [
            TableRow(children: [
              Expanded(
                child: Container(
                  color: color1,
                  alignment: Alignment.center,
                  child: Text(("$text1")),
                ),
              ),
              Expanded(
                child: Container(
                  color: color2,
                  alignment: Alignment.center,
                  child: Text(("$text2")),
                ),
              ),
            ])
          ],
          border: TableBorder.all(width: 1, color: colorborder),
        ),
      ),
    );
  }
}
