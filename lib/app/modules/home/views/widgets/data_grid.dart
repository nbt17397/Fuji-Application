import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:getx_skeleton/app/modules/home/app_guide_view.dart';
import 'package:getx_skeleton/app/modules/home/product_view.dart';

import '../../../../../config/translations/strings_enum.dart';

// mock model
class DataGridModelMock {
  final String title;
  final String iconPath;
  final Color backgroundColor;
  final Color iconBackgroundColor;

  DataGridModelMock({
    required this.title,
    required this.iconPath,
    required this.backgroundColor,
    required this.iconBackgroundColor,
  });
}

class DataGrid extends StatelessWidget {
  DataGrid({super.key});

  final List<DataGridModelMock> data = [
    // DataGridModelMock(
    //   title: 'Lift Diagnostics',
    //   iconPath: 'assets/vectors/vocation.svg',
    //   backgroundColor: const Color(0xFFEFF5FB),
    //   iconBackgroundColor: const Color(0xFF83A0EC),
    // ),
    // DataGridModelMock(
    //   title: 'Scans Archire',
    //   iconPath: 'assets/vectors/tasks.svg',
    //   backgroundColor: const Color(0xFFEEF9FF),
    //   iconBackgroundColor: const Color(0xFF92D5F6),
    // ),
    // DataGridModelMock(
    //   title: 'Reminder',
    //   iconPath: 'assets/vectors/alarm.svg',
    //   backgroundColor: const Color(0xFFF4F0FC),
    //   iconBackgroundColor: const Color(0xFFAB99D9),
    // ),
    DataGridModelMock(
      title: Strings.catalogues.tr,
      iconPath: 'assets/vectors/absent.svg',
      backgroundColor: const Color(0xFFFEF0EF),
      iconBackgroundColor: const Color(0xFFF9928A),
    ),
    // DataGridModelMock(
    //   title: 'News',
    //   iconPath: 'assets/vectors/calendar.svg',
    //   backgroundColor: const Color.fromARGB(255, 218, 233, 211),
    //   iconBackgroundColor: const Color.fromARGB(255, 115, 179, 152),
    // ),
    DataGridModelMock(
      title: Strings.appGuide.tr,
      iconPath: 'assets/vectors/tasks.svg',
      backgroundColor: const Color.fromARGB(255, 243, 243, 246),
      iconBackgroundColor: const Color.fromARGB(255, 236, 205, 30),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return GridView.builder(
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: data.length,
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 11.w,
        mainAxisSpacing: 10.h,
        mainAxisExtent: 100.h,
      ),
      itemBuilder: (ctx, index) {
        var gridData = data[index];
        return GestureDetector(
          onTap: () {
            if (gridData.title == 'Catalogues' || gridData.title == 'カタログ') {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => ProductsListScreen(),
                ),
              );
            } else if (gridData.title == 'App Guide' ||
                gridData.title == 'アプリガイド') {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => AppGuideScreen(),
                ),
              );
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: gridData.backgroundColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 37.h,
                  width: 37.h,
                  decoration: BoxDecoration(
                    color: gridData.iconBackgroundColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: SvgPicture.asset(
                    gridData.iconPath,
                    height: 19.h,
                    color: Colors.white,
                    fit: BoxFit.none,
                  ),
                ),
                8.verticalSpace,
                Text(gridData.title, style: theme.textTheme.titleSmall),
              ],
            ),
          ),
        );
      },
    );
  }
}
