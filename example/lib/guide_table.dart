import 'dart:math';

import 'package:flutter/material.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';

import 'data/user.dart';

class GuideTablePage extends StatefulWidget {
  const GuideTablePage({
    Key? key,
    required this.user,
  }) : super(key: key);
  final User user;

  @override
  State<GuideTablePage> createState() => _GuideTablePageState();
}

class _GuideTablePageState extends State<GuideTablePage> {
  late ScrollController _verticalScrollController;
  late ScrollController _horizontalScrollController;

  @override
  void initState() {
    widget.user.initData(3000);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.large(
        onPressed: () {
          _verticalScrollController.jumpTo(0);
          _horizontalScrollController.jumpTo(300);
        },
      ),
      appBar: AppBar(title: const Text('Simple Table')),
      body: HorizontalDataTable(
        leftHandSideColumnWidth: 100,
        rightHandSideColumnWidth: 100 * 100,
        isFixedHeader: true,
        headerWidgets: _getTitleWidget(),
        leftSideItemBuilder: _generateFirstColumnRow,
        rightSideItemBuilder: _generateRightHandSideColumnRow,
        itemCount: 30000,
        onScrollControllerReady: (vertical, horizontal) {
          _verticalScrollController = vertical;
          _horizontalScrollController = horizontal;
        },
        rowSeparatorWidget: const Divider(
          color: Colors.black38,
          height: 1.0,
          thickness: 0.0,
        ),
        leftHandSideColBackgroundColor: const Color(0xFFFFFFFF),
        rightHandSideColBackgroundColor: const Color(0xFFFFFFFF),
        itemExtent: 55,
      ),
    );
  }

  List<Widget> _getTitleWidget() {
    return List.generate(50, (index) {
      return _getTitleItemWidget(index.toString(), 100);
    });
  }

  Widget _getTitleItemWidget(String label, double width) {
    return Container(
      width: width,
      height: 100,
      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  Widget _generateFirstColumnRow(BuildContext context, int index) {
    return Container(
      width: 100,
      height: 50,
      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
      child: Text(widget.user.userInfo[index].name),
    );
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    final random = Random();
    final programsCount = random.nextInt(100) + 1;

    return Row(
      children: [
        ...List.generate(programsCount, (i) {
          final randomWidth = random.nextInt(5) + 1;
          final parsedWidth = randomWidth * 25.0;
          return Container(
            width: parsedWidth,
            height: 50,
            decoration: const BoxDecoration(
              color: Colors.black,
            ),

            alignment: Alignment.centerLeft,
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Image.network(
                'https://picsum.photos/300',
                fit: BoxFit.cover,
              ),
            ),
            // child: Text(
            //   i.toString(),
            //   style: const TextStyle(color: Colors.white),
            // ),
          );
        })
      ],
    );
  }
}
