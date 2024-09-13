import 'dart:convert';
import 'dart:developer';
import 'package:cold_storage_flutter/res/colors/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:reusable_components/reusable_components.dart';
import '../../../view_models/services/app_services.dart';

class MaterialInGallery extends StatefulWidget {
   const MaterialInGallery({super.key});

  @override
  State<MaterialInGallery> createState() => _MaterialInGalleryState();
}

class _MaterialInGalleryState extends State<MaterialInGallery> {

   RxList<String> imageDataList = <String>[].obs;
   bool isLoading = false;

   @override
  void initState() {
    isLoading = true;
    EasyLoading.show(status: 'loading...');
    imageDataList.value = Get.arguments['images'];
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
              Row(
                children: [
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
                ],
              ),
              App.appSpacer.vHxs,
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

  bool isEditing = false;

  Widget get _headerView {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.s,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const CustomTextField(
            textAlign: TextAlign.left,
            text: 'Gallery',
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
            fontColor: kAppBlack
          ),
          CustomTextField(
            textAlign: TextAlign.left,
            text: isEditing ? 'Cancel' : 'Edit',
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
            fontColor: kAppSecondary
          ),
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
        ) :Center(
          child: Text('No Image Found'),
        ) : const SizedBox.shrink(),
      ),
    );
  }
}
