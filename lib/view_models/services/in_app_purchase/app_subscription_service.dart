import 'dart:async';
import 'dart:io';

import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class AppSubscriptionService extends GetxController{

  final InAppPurchase _iap = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;

@override
  void onInit() {
    final Stream<List<PurchaseDetails>> purchaseUpdated = _iap.purchaseStream;

    _subscription = purchaseUpdated.listen((List<PurchaseDetails> purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    },onDone: () {
      _subscription.cancel();
    },onError: (Object error) {

    });
    super.onInit();
  }

  Future<void> _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) async {
    for(final PurchaseDetails purchaseDetails in purchaseDetailsList){
      if(purchaseDetails.status == PurchaseStatus.pending){

      }else{
        if(purchaseDetails.status == PurchaseStatus.error){

        }else if(purchaseDetails.status == PurchaseStatus.purchased || 
        purchaseDetails.status == PurchaseStatus.restored){
          
          final bool valid = await _varifyPurchase(purchaseDetails);
          if(valid){
            unawaited(deliverProduct(purchaseDetails));
          }else{
            _handleInvalidPurchase(purchaseDetails);
            return;
          }
        }

        if(Platform.isAndroid){
          // if(){

          // }
        }
        if(purchaseDetails.pendingCompletePurchase){
          await _iap.completePurchase(purchaseDetails);
        }

      }
    }
  }

  Future<bool> _varifyPurchase(PurchaseDetails purchaseDetails) async {

    ///Varify Purchase before delivering the product
    return Future<bool>.value(true);
  }

  Future<void> deliverProduct(PurchaseDetails purchaseDetails) async {
    // if(purchaseDetails.productID == _){

    // }
  }

  void _handleInvalidPurchase(PurchaseDetails purchaseDetails){
    ///handle invalid purchase here if _verifyPurchase failed
  }

}