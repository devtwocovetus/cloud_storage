import 'package:get/get.dart';

class TakeSubscriptionViewModel extends GetxController{

  RxInt totalValue = 299.obs;
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