

import 'package:cold_storage_flutter/res/colors/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class InterNetExceptionWidget extends StatefulWidget {
  final VoidCallback onPress ;
  const InterNetExceptionWidget({super.key , required this.onPress});

  @override
  State<InterNetExceptionWidget> createState() => _InterNetExceptionWidgetState();
}

class _InterNetExceptionWidgetState extends State<InterNetExceptionWidget> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height ;
    return  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          SizedBox(height: height * .15 ,),
          const Icon(Icons.cloud_off , color: AppColor.redColor,size: 50,),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Center(child: Text('internet_exception'.tr , textAlign: TextAlign.center,)),
          ),
          SizedBox(height: height * .15 ,),
          InkWell(
            onTap: widget.onPress,
            child: Container(
              height: 44,
              width: 160,
              decoration: BoxDecoration(
                color: AppColor.primaryColor ,
                borderRadius: BorderRadius.circular(50)
              ),
              child: Center(child: Text('Retry' , style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),)),
            ),
          )
        ],
      ),
    );
  }
}
