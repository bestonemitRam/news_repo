import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shortnews/view/dashboard_screeen.dart';
import 'package:shortnews/view/notifications/notification_list.dart';
import 'package:shortnews/view/page_routes/routes.dart';
import 'package:shortnews/view_model/dashboard_contoller.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<NotificationScreen> {
  final MyController myController = Get.put(MyController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: InkWell(
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onTap: () {
                Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.rightToLeft,
                  duration: Duration(milliseconds: 700),
                  child: DashBoardScreenActivity(),
                ),
              );
            },
          ),
          title: Center(
            child: Text(
              "Top Notifications",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        body: Obx(() {
          if (myController.myData.isEmpty) {
            return Container(
                color: Colors.white,
                child: Center(child: CircularProgressIndicator()));
          } else {
            return ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                primary: false,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: myController.myData.length,
                itemBuilder: (ctx, index) {
                  var item = myController.myData[index];

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListUi(item),
                  );
                });
          }
        }));
  }
}
