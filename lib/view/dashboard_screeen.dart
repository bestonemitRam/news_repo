import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shortnews/main.dart';
import 'package:shortnews/view/drower.dart';
import 'package:shortnews/view/uitl/apphelper.dart';
import 'package:shortnews/view/uitl/appimage.dart';
import 'package:shortnews/view/uitl/appstyle.dart';
import 'package:shortnews/view/uitl/translation_widget.dart';
import 'package:shortnews/view_model/dashboard_contoller.dart';
import 'package:shortnews/view_model/provider/ThemeProvider.dart';
import 'package:translator/translator.dart';
import 'package:url_launcher/url_launcher.dart';

class DashBoardScreenActivity extends StatefulWidget {
  const DashBoardScreenActivity({super.key});

  @override
  State<DashBoardScreenActivity> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreenActivity> {
  DarkThemeProvider foodcategoriesProvider = DarkThemeProvider();
  final _advancedDrawerController = AdvancedDrawerController();
  final MyController myController = Get.put(MyController());

  void showSimpleSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('This is a Snackbar'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DarkThemeProvider>(
        builder: (context, darkThemeProvider, child) {
      return AdvancedDrawer(
          backdrop: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.transparent, Colors.blueGrey.withOpacity(0.2)],
              ),
            ),
          ),
          controller: _advancedDrawerController,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 300),
          animateChildDecoration: true,
          rtlOpening: false,
          // openScale: 1.0,
          disabledGestures: false,
          childDecoration: const BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black12,
                blurRadius: 0.0,
              ),
            ],
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          drawer: MenuBarScreen(),
          child: Scaffold(
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            drawer: Container(),
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              leading: IconButton(
                  onPressed: _handleMenuButtonPressed,
                  icon: ValueListenableBuilder<AdvancedDrawerValue>(
                    valueListenable: _advancedDrawerController,
                    builder: (_, value, __) {
                      return AnimatedSwitcher(
                        duration: Duration(milliseconds: 250),
                        child: Icon(
                          value.visible ? Icons.clear : Icons.menu,
                          color: AppHelper.themelight
                              ? Colors.white
                              : Colors.black,
                          key: ValueKey<bool>(value.visible),
                        ),
                      );
                    },
                  )),
            ),
            body: Obx(() {
              if (myController.myData.isEmpty) {
                return Container(
                    color: Colors.white,
                    child: Center(child: CircularProgressIndicator()));
              } else
               {
                return InkWell(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 0, right: 0, bottom: 10),
                    child: Swiper(
                      layout: SwiperLayout.STACK,

                      customLayoutOption:
                          CustomLayoutOption(startIndex: -1, stateCount: 3)
                            ..addRotate([-45.0 / 180, 0.0, 45.0 / 180])
                            ..addTranslate([
                              Offset(-370.0, -40.0),
                              Offset(0.0, 0.0),
                              Offset(370.0, -40.0)
                            ]),
                      itemWidth: MediaQuery.of(context).size.width,
                      itemHeight: MediaQuery.of(context).size.height,
                      itemBuilder: (context, index) {
                        var item = myController.myData[index];
                        return InkWell(
                          onTap: () {},
                          child: Padding(
                            padding:
                                EdgeInsets.only(left: 1, right: 1, bottom: 0),
                            child: Card(
                              color: AppHelper.themelight
                                  ? Colors.white
                                  : Colors.black,
                              child: Stack(
                                children: [
                                  if (myController.internet.value)
                                    Container(
                                      width: double.infinity,
                                      height: 25.h,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(12.0),
                                          topRight: Radius.circular(12.0),
                                        ),
                                        image: DecorationImage(
                                          image: NetworkImage(item.img),
                                          fit: BoxFit.cover,
                                        ),
                                        color: Colors.transparent,
                                      ),
                                    ),
                                  Positioned(
                                    top: myController.internet.value
                                        ? 25.h
                                        : 1.h,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        padding: EdgeInsets.all(20.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item.title,
                                              style: AppHelper.themelight
                                                  ? AppStyle.heading_black
                                                  : AppStyle.heading_white,
                                            ),
                                            SizedBox(
                                              height: 1.h,
                                            ),
                                            Text(
                                              item.description,
                                              style: AppHelper.themelight
                                                  ? AppStyle.bodytext_black
                                                  : AppStyle.bodytext_white,
                                            ),
                                            // TranslationWidget(
                                            //   message: item.description,
                                            //   builder: (translatedMessage) =>
                                            //       Text(
                                            //     translatedMessage,
                                            //     style: TextStyle(
                                            //         color: Colors.black,
                                            //         fontSize: 15),
                                            //   ),
                                            // ),
                                            SizedBox(
                                              height: 14.h,
                                            ),
                                            Text(
                                              "ShorTnews",
                                              style: AppHelper.themelight
                                                  ? AppStyle.bodytext_black
                                                  : AppStyle.bodytext_white,
                                            )
                                          ],
                                        )),
                                  ),
                                  Positioned(
                                    right: 0,
                                    child: Container(
                                        height: 2.5.h,
                                        width: 20.w,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(7.0),
                                            topRight: Radius.circular(1.0),
                                            bottomRight: Radius.circular(7.0),
                                          ),
                                        ),
                                        padding: EdgeInsets.all(1),
                                        child: Text(
                                          "ShorTnews",
                                          style: TextStyle(color: Colors.black),
                                        )),
                                  ),
                                  Positioned(
                                    left: 1.w,
                                    top: 0.2.h,
                                    child: Container(
                                        width: 10.w,
                                        height: 5.h,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(50)),
                                        ),
                                        padding: EdgeInsets.all(1),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.asset(
                                            AppImages.welcomescreenillimage,
                                            fit: BoxFit.fill,
                                          ),
                                        )),
                                  ),
                                  Positioned(
                                    left: 0,
                                    right: 0,
                                    bottom: 3,
                                    child: InkWell(
                                      onTap: () {
                                        _launchUrl(Uri.parse(item.news_link));
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(12.0),
                                            bottomRight: Radius.circular(12.0),
                                          ),
                                          image: DecorationImage(
                                              image: NetworkImage(item.img),
                                              fit: BoxFit.cover,
                                              opacity: 0.21),
                                        ),
                                        padding: EdgeInsets.all(20.0),
                                        child: Row(
                                          children: [
                                            Container(
                                              //width: 0,
                                              child: Text(
                                                "${item.heading}",
                                                maxLines: 1,
                                                style: AppHelper.themelight
                                                    ? AppStyle.bodytext_black
                                                    : AppStyle.bodytext_white,
                                              ),
                                            ),
                                            Spacer(),
                                            Image.asset(
                                              "assets/images/Animation.gif",
                                              height: 20.0,
                                              width: 20.0,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: myController.myData.length,
                      scrollDirection: Axis.vertical,
                      //control: const SwiperControl(),
                    ),
                  ),
                );
              }
            }),

            // CustomScrollView(
            //   slivers: [
            //     SliverAppBar(
            //       title: Text('Sliding App Bar'),
            //       floating: true,
            //       snap: true,
            //       // You can adjust the height as needed
            //       expandedHeight: 100,
            //       flexibleSpace: FlexibleSpaceBar(
            //         background: Image.network(
            //           'https://via.placeholder.com/500',
            //           fit: BoxFit.cover,
            //         ),
            //       ),
            //     ),
            //     Swiper(
            //       itemBuilder: (BuildContext context, int index) {
            //         return Image.network(
            //           "https://via.placeholder.com/350x150",
            //           fit: BoxFit.fill,
            //         );
            //       },
            //       itemCount: 3,
            //       pagination: SwiperPagination(),
            //       control: SwiperControl(),
            //     )

            //     // SliverList(
            //     //   delegate: SliverChildBuilderDelegate(
            //     //     (BuildContext context, int index)
            //     //     {
            //     //       return

            //     //     },
            //     //     childCount: 50,
            //     //   ),
            //     // ),
            //   ],
            // ),
          ));
    });
    //  Scaffold(
    //   appBar: AppBar(
    //     title: Text("short News"),
    //   ),
    //   body: Container(
    //       child:
    // TranslationWidget(
    //     message: "how are you",
    //     builder: (translatedMessage) => Text(
    //       translatedMessage,
    //       style: TextStyle(color: Colors.black),
    //     ),
    //   )),
    // );
  }

  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }

  Future<void> _launchUrl(Uri _url) async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}
