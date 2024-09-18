import 'dart:convert';
import 'dart:developer';
import 'package:cold_storage_flutter/res/colors/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:reusable_components/reusable_components.dart';
import '../../view_models/services/app_services.dart';

class AppGalleryView extends StatefulWidget {
   const AppGalleryView({super.key});

  @override
  State<AppGalleryView> createState() => _AppGalleryViewState();
}

class _AppGalleryViewState extends State<AppGalleryView> {

   RxList<String> imageDataList = <String>[].obs;
   RxList<String> imageUrlList = <String>[].obs;
   RxBool imagesWithUrl = true.obs;
   bool isLoading = false;

   @override
  void initState() {
    isLoading = true;
    EasyLoading.show(status: 'loading...');
    imagesWithUrl.value = Get.arguments['image_with_url'];
    if(imagesWithUrl.value){
      imageDataList.value = Get.arguments['images'];
    }else{
      imageUrlList.value = Get.arguments['images'];
    }
    log('<><><><>< 5 ${imageDataList}');
     isLoading = false;
    EasyLoading.dismiss();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dialogBackColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Row(
              //   children: [
              //     const Spacer(),
              //     IconButton(
              //       onPressed: () async {
              //         Get.back();
              //       },
              //       icon: Image.asset(
              //         height: 20,
              //         width: 20,
              //         'assets/images/ic_close_dialog.png',
              //         fit: BoxFit.cover,
              //       ),
              //     ),
              //   ],
              // ),
              // App.appSpacer.vHxs,
              _headerView,
              App.appSpacer.vHxs,
              _galleryImageView,
              App.appSpacer.vHxs,
            ],
          ),
        ),
      ),
    );
  }

  // bool isEditing = false;

  Widget get _headerView {
    return Padding(
      padding: App.appSpacer.edgeInsets.left.s,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const CustomTextField(
            textAlign: TextAlign.left,
            text: 'Gallery',
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
            fontColor: kAppBlack
          ),
          const Spacer(),
          IconButton(
            onPressed: () async {
              Get.back();
            },
            icon: Image.asset(
              height: 20,
              width: 20,
              'assets/images/ic_close_dialog.png',
              fit: BoxFit.cover,
            ),
          ),
          // CustomTextField(
          //   textAlign: TextAlign.left,
          //   text: isEditing ? 'Cancel' : 'Edit',
          //   fontSize: 16.0,
          //   fontWeight: FontWeight.w500,
          //   fontColor: kAppSecondary
          // ),
        ],
      ),
    );
  }

  Widget get _galleryImageView{
    return Obx(()=>
      Padding(
        padding: App.appSpacer.edgeInsets.x.s,
        child: !isLoading ? imageDataList.isNotEmpty ? GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: App.appSpacer.spacer_28,
            mainAxisSpacing: App.appSpacer.spacer_28,
            childAspectRatio: App.appQuery.width / (App.appQuery.width),
          ),
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: imageDataList.length,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                border: Border.all(width: 1,strokeAlign: BorderSide.strokeAlignCenter)
              ),
              child: Image.memory(
                base64Decode(imageDataList.value[index]),
                fit: BoxFit.fill,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset('assets/images/default/ic_no_image_found.png',fit: BoxFit.fill);
                },
                frameBuilder: ((context, child, frame, wasSynchronouslyLoaded) {
                  if (wasSynchronouslyLoaded) return child;
                  return AnimatedSwitcher(
                    switchInCurve: Curves.bounceIn,
                    duration: const Duration(milliseconds: 200),
                    child: frame != null
                        ? child
                        : const SizedBox(
                      height: 60,
                      width: 60,
                      child: CircularProgressIndicator(
                          strokeWidth: 3),
                    ),
                  );
                }),
              ),
            );
          },
        ) : Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // const Spacer(),
            Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Image.asset(
                      'assets/images/ic_blank_list.png'),
                  const SizedBox(
                    height: 10,
                  ),
                  const CustomTextField(
                      textAlign: TextAlign.center,
                      text: 'No Image Found',
                      fontSize: 18.0,
                      fontColor: Color(0xFF000000),
                      fontWeight: FontWeight.w500
                  ),
                ],
              ),
            ),
            // const Spacer(),
          ],
        ) : const SizedBox.shrink(),
      ),
    );
  }
}
