import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shortnews/main.dart';
import 'package:shortnews/model/dashboard_model.dart';
import 'package:shortnews/view/uitl/apphelper.dart';
import 'package:shortnews/view_model/data_service.dart';

class MyController extends GetxController {
  final DataService _dataService = DataService();
  var myData = <DashBoardModel>[].obs;
  var internet = false.obs;
  var light = true.obs;
    var notification = true.obs;
  List<Map<String, dynamic>> list = [
    {"icon": Icons.ac_unit_sharp, "type": "My Feed"},
    {"icon": Icons.account_balance_outlined, "type": "All News"},
    {"icon": Icons.stroller_outlined, "type": "Top Stories"},
    {"icon": Icons.star_sharp, "type": "Trending"},
    {"icon": Icons.star_sharp, "type": "Book Mark"},
    {"icon": Icons.star_sharp, "type": "Technology"},
    {"icon": Icons.star_sharp, "type": "Entertainment"},
    {"icon": Icons.trending_up_sharp, "type": "Sports"},
  ];

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  void fetchData() async {
   
    try {
      myData.value = await _dataService.fetchData();
    } catch (e) {
      
    }
  }

  void fetchParticularData(String newsType) async {
    try {
      myData.value = await _dataService.fetchDataType(newsType);
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  getData() async {
    bool result = await InternetConnectionChecker().hasConnection;
    internet.value = result;
    if (result == true) {
      fetchData();
      loadModelsFromPrefs();
    } else {
      loadModelsFromPrefs();
    }
  }

//-------------------------load data from local--------------------------//
  loadModelsFromPrefs() async {
    final jsonString = sharedPref.getString('dashboardModels');
    if (jsonString != null) {
      final jsonList = jsonDecode(jsonString) as List<dynamic>;
      myData.value =
          jsonList.map((json) => DashBoardModel.fromJson(json)).toList();
    }
  }
}
