import 'package:get/get.dart';

class TakeSubscriptionViewModel extends GetxController{
  RxInt totalValue = 199.obs;
  RxInt totalAddOnsValue = 0.obs;
  RxInt selectedIndex = 0.obs;
  RxInt selectedAddOnsIndex = (-1).obs;

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

  List<Map<String, dynamic>> subscriptionAddOnsList = [
    {
      "title": "Add 10 extra users subscription",
      // "description": "Account owner allow to create 1 user",
      "price": "199"
    },
    {
      "title": "Add 20 extra users subscription",
      // "description": "Account owner allow to create up to 5 users",
      "price": "995"
    },
    {
      "title": "Add 50 extra users subscription",
      // "description": "Account owner allow to create up tp 10 users",
      "price": "1990"
    },
  ];

  onSubscriptionTap({required int index}){
    Map<String, dynamic> subscription = subscriptionList[index];
    if(selectedAddOnsIndex.value>=0){
      totalValue.value = int.parse(subscription['price']) + totalAddOnsValue.value;
      selectedIndex.value = index;
    }else{
      totalValue.value = int.parse(subscription['price']);
      selectedIndex.value = index;
    }
  }

  onSubscriptionAddOnsTap({required int index}){
    if(selectedAddOnsIndex.value == index){
      totalValue.value = totalValue.value - totalAddOnsValue.value;
      totalAddOnsValue.value = 0;
      selectedAddOnsIndex.value = -1;
    }
    else{
      if(totalAddOnsValue.value>0){
        totalValue.value = totalValue.value - totalAddOnsValue.value;
      }
      Map<String, dynamic> subscriptionAddOn = subscriptionAddOnsList[index];
      totalAddOnsValue.value = int.parse(subscriptionAddOn['price']);
      totalValue.value = totalValue.value + totalAddOnsValue.value;
      selectedAddOnsIndex.value = index;
    }
  }

}