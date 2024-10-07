import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:cold_storage_flutter/view_models/entity_transfer/entity_list_for_transfer_view_model.dart';
import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reusable_components/reusable_components.dart';
import 'package:cold_storage_flutter/i10n/strings.g.dart' as i18n;


class EntityToEntityThankyouMaterialIn extends StatefulWidget {
  const EntityToEntityThankyouMaterialIn({super.key});

  @override
  State<EntityToEntityThankyouMaterialIn> createState() => _ThankyouMaterialInState();
}

class _ThankyouMaterialInState extends State<EntityToEntityThankyouMaterialIn> {
  
 String comeFrom = '';
  dynamic argumentData = Get.arguments;
    late i18n.Translations translation;

    @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    translation = i18n.Translations.of(context);
  }


  @override
  void initState() {
    if (argumentData != null) {
      comeFrom = argumentData[0]['from'];
    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton:  MyCustomButton(
                       width: App.appQuery.responsiveWidth(70),
                        height: 48.0,
                        borderRadius: BorderRadius.circular(10.0),
                        onPressed: () {
                          if(comeFrom == 'Normal'){
 EntityListForTransferViewModel v = Get.put(EntityListForTransferViewModel());
                           v.getEntityList();
                           Get.until((route) => Get.currentRoute == RouteName.entityListForTransferScreen);
                          }else {
                            Get.offAllNamed(RouteName.homeScreenView,
                                arguments: []);
                          }
                          
                        },
                        text: translation.transfer,
                      ),
      backgroundColor: const Color(0xFFFFFFFF),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SizedBox(
          height: size.height,
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/ic_thank_you.png',
                      width: 150.0,
                      height: 96.0,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 35.0),
                     CustomTextField(
                        text: translation.thank_you,
                        fontSize: 22.0,
                        fontColor: Color(0xFF000000),
                        fontWeight: FontWeight.w600),
                    const SizedBox(height: 8.0),
                     CustomTextField(
                        text: translation.material_transfer_success,
                        fontSize: 22.0,
                        fontColor: Color(0xFF000000),
                        fontWeight: FontWeight.w600),
                    const SizedBox(height: 215.0),

                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
