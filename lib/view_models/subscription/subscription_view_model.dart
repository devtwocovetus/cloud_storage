import 'package:get/get.dart';

class TakeSubscriptionViewModel extends GetxController{

  RxInt totalValue = 199.obs;
  RxInt selectedIndex = 0.obs;

  List<Map<String, dynamic>> subscriptionList = [
    {
      "title": "Single User Subscription",
      "description": "Account owner allow to create 1 user",
      "price": "199"
    },
    {
      "title": "2 User Subscription",
      "description": "Account owner allow to create 2 user",
      "price": "399"
    },
    {
      "title": "3 User Subscription",
      "description": "Account owner allow to create 3 user",
      "price": "599"
    },
    {
      "title": "4 User Subscription",
      "description": "Account owner allow to create 4 user",
      "price": "799"
    },
    {
      "title": "5 User Subscription",
      "description": "Account owner allow to create 5 user",
      "price": "999"
    },
  ];

  onSubscriptionTap({required int index}){
    Map<String, dynamic> subscription = subscriptionList[index];
    totalValue.value = int.parse(subscription['price']);
    selectedIndex.value = index;
  }

}