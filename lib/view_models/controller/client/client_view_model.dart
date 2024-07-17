import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ClientViewModel extends GetxController{

  final GlobalKey<SliderDrawerState> materialOutDrawerKey =
  GlobalKey<SliderDrawerState>();

  final RefreshController refreshController = RefreshController(initialRefresh: true);
  final TextEditingController searchController = TextEditingController();

  final RxInt count = 4.obs;
  RxBool isData = true.obs;



}