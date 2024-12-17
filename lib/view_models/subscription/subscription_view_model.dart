import 'package:get/get.dart';

class TakeSubscriptionViewModel extends GetxController{

  RxInt totalValue = 299.obs;
  RxInt selectedIndex = 0.obs;

  List<Map<String, dynamic>> subscriptionList = [
    {
      "title": "Single User Subscription",
      "description": "Account owner allow to create 1 user",
      "price": "199"
    },
    {
      "title": "Up to 5 user subscription",
      "description": "Account owner allow to create up to 5 users",
      "price": "995"
    },
    {
      "title": "Up to 10 user subscription",
      "description": "Account owner allow to create up tp 10 users",
      "price": "1990"
    },
    {
      "title": "Up to 15 user subscription",
      "description": "Account owner allow to create up tp 15 users",
      "price": "2985"
    },
  ];

  onSubscriptionTap({required int index}){
    Map<String, dynamic> subscription = subscriptionList[index];
    totalValue.value = int.parse(subscription['price']);
    selectedIndex.value = index;
  }

}