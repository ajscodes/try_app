import 'package:flutter/material.dart';

import '../../utils/color_constants.dart';
import '../../utils/string_constants.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.secondaryColor,
      appBar: AppBar(
        backgroundColor: ColorConstants.primaryAppBar,
        title: Text(
          ReportConstants.reportScreenAppBarTitle,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Text(
                ReportConstants.reportScreenBody,
                style: TextStyle(fontSize: 25),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
