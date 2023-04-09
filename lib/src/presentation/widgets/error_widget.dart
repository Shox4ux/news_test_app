import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget(
      {super.key, required this.message, required this.fun});
  final String message;
  final Function()? fun;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.error, size: 128.h, color: Colors.red),
        Center(child: Text(message)),
        IconButton(
          onPressed: fun,
          icon: Icon(Icons.refresh),
        )
      ],
    );
  }
}
