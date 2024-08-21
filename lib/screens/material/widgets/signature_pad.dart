import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:cold_storage_flutter/view_models/controller/material_in/material_in_view_model.dart';
import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:reusable_components/reusable_components.dart';
import 'package:signature/signature.dart';

class SignaturePad extends StatefulWidget {
  const SignaturePad({super.key});

  @override
  State<SignaturePad> createState() => _SignaturePadState();
}

class _SignaturePadState extends State<SignaturePad> {
   DateTime selectedDate = DateTime.now();
  // initialize the signature controller
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 1,
    penColor: Colors.red,
    exportBackgroundColor: Colors.transparent,
    exportPenColor: Colors.black,
    onDrawStart: () => log('onDrawStart called!'),
    onDrawEnd: () => log('onDrawEnd called!'),
  );

  @override
  void initState() {
    super.initState();
    _controller
      ..addListener(() => log('Value changed'))
      ..onDrawEnd = () => setState(
            () {
              // setState for build to update value of "empty label" in gui
            },
          );
  }

  @override
  void dispose() {
    // IMPORTANT to dispose of the controller
    _controller.dispose();
    super.dispose();
  }

  Future<File?> exportImage(BuildContext context) async {
    File? file;
    if (_controller.isEmpty) {
     
    }else {
final Uint8List? data =
        await _controller.toPngBytes();
final tempDir = await getTemporaryDirectory();
 file = await File('${tempDir.path}/${selectedDate.millisecondsSinceEpoch}.png').create();
file.writeAsBytesSync(data!);
    }

return file;
    

    // await push(
    //   context,
    //   Scaffold(
    //     appBar: AppBar(
    //       title: const Text('PNG Image'),
    //     ),
    //     body: Center(
    //       child: Container(
    //         color: Colors.grey[300],
    //         child: Image.memory(data),
    //       ),
    //     ),
    //   ),
    // );
  }

  Future<void> exportSVG(BuildContext context) async {
    if (_controller.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          key: Key('snackbarSVG'),
          content: Text('No content'),
        ),
      );
      return;
    }

    final SvgPicture data = _controller.toSVG()!;

    if (!mounted) return;

    // await push(
    //   context,
    //   Scaffold(
    //     appBar: AppBar(
    //       title: const Text('SVG Image'),
    //     ),
    //     body: Center(
    //       child: Container(
    //         color: Colors.grey[300],
    //         child: data,
    //       ),
    //     ),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: SafeArea(
            child: Container(
              height: 60,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 20, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CustomTextField(
                        textAlign: TextAlign.center,
                        text: 'Signature',
                        fontSize: 18.0,
                        fontColor: Color(0xFF000000),
                        fontWeight: FontWeight.w500),
                    const Spacer(),
                    GestureDetector(
                      onTap: () async {
                        Get.back();
                      },
                      child: Image.asset(
                        height: 20,
                        width: 20,
                        'assets/images/ic_close_dialog.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const SizedBox(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Signature(
              key: const Key('signature'),
              controller: _controller,
              height: 400,
              backgroundColor: Colors.white!,
            ),
          ),

          Padding(
              padding: App.appSpacer.edgeInsets.y.sm,
              child: MyCustomButton(
              width: App.appQuery.responsiveWidth(70) /*312.0*/,
              height: 45,
              borderRadius: BorderRadius.circular(10.0),
              onPressed: () async
              {
                File? files = await exportImage(context);
                final  controller = Get.put(MaterialInViewModel());
                controller.imageBase64Convert(files);
                Get.back();
              },
                    text: 'Submit',
                  ),
          )
          
        ],
      ),
     
    );
  }
}
