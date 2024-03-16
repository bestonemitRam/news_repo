// import 'package:animated_switch/animated_switch.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:page_transition/page_transition.dart';
// import 'package:provider/provider.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';
// import 'package:shortnews/view/dashboard_screeen.dart';
// import 'package:shortnews/view/uitl/appColors.dart';
// import 'package:shortnews/view/uitl/apphelper.dart';
// import 'package:shortnews/view/uitl/appstyle.dart';
// import 'package:shortnews/view_model/dashboard_contoller.dart';
// import 'package:shortnews/view_model/provider/ThemeProvider.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shortnews/view/dashboard_screeen.dart';
import 'package:shortnews/view/notifications/notifications_screen.dart';
import 'package:shortnews/view/uitl/appColors.dart';
import 'package:shortnews/view/uitl/apphelper.dart';
import 'package:shortnews/view/uitl/appstyle.dart';
import 'package:shortnews/view_model/dashboard_contoller.dart';
import 'package:shortnews/view_model/provider/ThemeProvider.dart';

class MenuBarScreen extends StatelessWidget {
  const MenuBarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DarkThemeProvider>(
      builder: (context, darkThemeProvider, child) {
        return Obx(
          () {
            // Make sure you have an observable variable to trigger updates
            // For example, you can use a variable from your controller
            final myController = Get.find<MyController>();

            return SafeArea(
                child: Container(
              child: ListTileTheme(
                textColor: Colors.white,
                iconColor: Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: 12.0.h,
                        margin: const EdgeInsets.only(
                          top: 24.0,
                          bottom: 16.0,
                        ),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: myController.list.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () 
                                {
                                  myController.fetchParticularData("Trending");
                                  Navigator.pop(context);
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      duration: Duration(milliseconds: 700),
                                      child: DashBoardScreenActivity(),
                                    ),
                                  );
                                },
                                child: Card(
                                  //color: Colors.transparent.withOpacity(0.8),
                                  child: Container(
                                    //  width: 25.0.w,
                                    //height: 60,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      // color: AppHelper.themelight
                                      //     ? Colors.white
                                      //     : Colors.black
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Icon(
                                            myController.list[index]['icon'],
                                            size: 10.w,
                                            color: AppHelper.themelight
                                                ? AppColors.primarycolorYellow
                                                : AppColors.blackColor,
                                          ),
                                          Center(
                                              child: Text(
                                            textAlign: TextAlign.center,
                                            myController.list[index]['type']
                                                .toString(),
                                            style: AppHelper.themelight
                                                ? AppStyle.bodytext_white
                                                : AppStyle.bodytext_black,
                                          )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        )),
                    ListTile(
                      onTap: () {
                        Navigator.pop(context);
                        myController.fetchData();
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            duration: Duration(milliseconds: 700),
                            child: DashBoardScreenActivity(),
                          ),
                        );
                      },
                      leading: Icon(
                        Icons.home,
                        size: 2.5.h,
                        color: AppHelper.themelight
                            ? AppColors.whiteColor
                            : AppColors.blackColor,
                      ),
                      title: Text(
                        'Home',
                        style: AppHelper.themelight
                            ? AppStyle.bodytext_white
                            : AppStyle.bodytext_black,
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            duration: Duration(milliseconds: 700),
                            child: NotificationScreen(),
                          ),
                        );
                      },
                      leading: Icon(
                        Icons.account_circle_rounded,
                        size: 2.5.h,
                        color: AppHelper.themelight
                            ? AppColors.whiteColor
                            : AppColors.blackColor,
                      ),
                      title: Text(
                        'Notification',
                        style: AppHelper.themelight
                            ? AppStyle.bodytext_white
                            : AppStyle.bodytext_black,
                      ),
                      trailing: Switch(
                        value: myController.notification.value,
                        activeColor: AppHelper.themelight
                            ? AppColors.primarycolorYellow
                            : AppColors.blackColor,
                        onChanged: (bool value) {
                          myController.notification.value = value;
                        },
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.contrast,
                        size: 2.5.h,
                        color: AppHelper.themelight
                            ? AppColors.whiteColor
                            : AppColors.blackColor,
                      ),
                      title: Text(
                        'App Theme ',
                        style: AppHelper.themelight
                            ? AppStyle.bodytext_white
                            : AppStyle.bodytext_black,
                      ),
                      trailing: Switch(
                        value: myController.light.value,
                        activeColor: AppHelper.themelight
                            ? AppColors.primarycolorYellow
                            : AppColors.blackColor,
                        onChanged: (bool value) {
                          myController.light.value = value;

                          AppHelper.themelight = !AppHelper.themelight;
                          darkThemeProvider.darkThemessd(true);
                        },
                      ),
                    ),
                    ListTile(
                      onTap: () {},
                      leading: Icon(
                        Icons.settings,
                        size: 2.5.h,
                        color: AppHelper.themelight
                            ? AppColors.whiteColor
                            : AppColors.blackColor,
                      ),
                      title: Text(
                        'Settings',
                        style: AppHelper.themelight
                            ? AppStyle.bodytext_white
                            : AppStyle.bodytext_black,
                      ),
                    ),
                    Spacer(),
                    DefaultTextStyle(
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white54,
                      ),
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 16.0,
                        ),
                        child: Text('Terms of Service | Privacy Policy'),
                      ),
                    ),
                  ],
                ),
              ),
            ));
          },
        );
      },
    );
  }
}
