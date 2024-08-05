import 'package:cold_storage_flutter/models/entity/entity_list_model.dart';
import 'package:cold_storage_flutter/res/components/divider/basic_divider.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/entity/entitylist_view_model.dart';
import 'package:cold_storage_flutter/view_models/controller/home/home_view_model.dart';
import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reusable_components/reusable_components.dart';

import '../../res/components/image_view/network_image_view.dart';
import '../../res/components/image_view/svg_asset_image.dart';
import '../../res/routes/routes_name.dart';

class EntityListScreen extends StatefulWidget {
  const EntityListScreen({super.key});

  @override
  State<EntityListScreen> createState() => _EntityListScreenState();
}

class _EntityListScreenState extends State<EntityListScreen> {
  final entityListViewModel = Get.put(EntitylistViewModel());
  final emailController = TextEditingController();
  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: SafeArea(
            child: Container(
              height: 60,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        Get.back();
                      },
                      icon: Image.asset(
                        height: 15,
                        width: 10,
                        'assets/images/ic_back_btn.png',
                        fit: BoxFit.cover,
                      )
                    ),
                    const CustomTextField(
                        textAlign: TextAlign.center,
                        text: 'Entity Details',
                        fontSize: 18.0,
                        fontColor: Color(0xFF000000),
                        fontWeight: FontWeight.w500),
                    const Spacer(),
                    Padding(
                      padding: App.appSpacer.edgeInsets.top.none,
                      child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            Get.until((route) => Get.currentRoute == RouteName.homeScreenView);
                          },
                          icon: const SVGAssetImage(
                            height: 20,
                            width: 20,
                            url: 'assets/images/default/ic_home.svg',
                            fit: BoxFit.cover,
                          )),
                    ),
                    Padding(
                      padding: App.appSpacer.edgeInsets.top.none,
                      child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                          },
                          icon: Image.asset(
                            height: 20,
                            width: 20,
                            'assets/images/ic_notification_bell.png',
                            fit: BoxFit.cover,
                          )),
                    ),
                    Padding(
                      padding: App.appSpacer.edgeInsets.top.none,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          // _sliderDrawerKey.currentState!.toggle();
                        },
                        icon: AppCachedImage(
                            roundShape: true,
                            height: 25,
                            width: 25,
                            fit: BoxFit.cover,
                            url: entityListViewModel.logoUrl.value
                        )
                      ),
                    ),
                    App.appSpacer.vWxxs
                  ],
                ),
              ),
            ),
          )),
      body: SafeArea(
        child: Obx(() => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 4,
                        child: TextField(
                            textAlignVertical: TextAlignVertical.center,
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.0)),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              prefixIcon: Image.asset(
                                  'assets/images/ic_search_field.png'),
                              hintText: "Search Here. . .",
                              filled: true,
                              fillColor: const Color(0xffEFF8FF),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                            )),
                      ),
                      Expanded(
                        flex: 4,
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                          decoration: const BoxDecoration(
                              color: Color(0xFFEFF8FF),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: DropdownButton(
                              isExpanded: true,
                              underline: const SizedBox(),
                              hint: const CustomTextField(
                                text: 'Sort By',
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                fontColor: Color(0xff828282),
                              ),
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: items.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              // After selecting the desired option,it will
                              // change button value to selected value
                              onChanged: (String? newValue) {},
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            Get.toNamed(RouteName.entityOnboarding, arguments: [
                              {"EOB": 'OLD'}
                            ])!
                                .then((value) {});
                          },
                          child: Image.asset(
                              width: 30,
                              height: 30,
                              'assets/images/ic_add_new.png'),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10,20,10,10),
                    child: Material(
                      borderRadius: const BorderRadius.all(Radius.circular(11)),
                      elevation: 20,
                      child: Container(
                        decoration: BoxDecoration(
                            color: const Color(0xFFFFFFFF),
                            border: Border.all(
                              color: const Color(0xFFE6E6E6),
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(11))),
                        child: entityListViewModel.entityList!.isNotEmpty
                            ? ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount:
                                    entityListViewModel.entityList!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return listItem(
                                      entityListViewModel.entityList![index]);
                                })
                            : Container(
                                width: 1800,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                        'assets/images/ic_blank_list.png'),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const CustomTextField(
                                        textAlign: TextAlign.center,
                                        text: 'No Entity Found',
                                        fontSize: 18.0,
                                        fontColor: Color(0xFF000000),
                                        fontWeight: FontWeight.w500),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    MyCustomButton(
                                      elevation: 20,
                                      height:
                                          Utils.deviceHeight(context) * 0.06,
                                      padding:
                                          Utils.deviceWidth(context) * 0.10,
                                      borderRadius: BorderRadius.circular(10.0),
                                      onPressed: () => {
                                        Get.toNamed(RouteName.entityOnboarding,
                                                arguments: [
                                              {"EOB": 'OLD'}
                                            ])!
                                            .then((value) {})
                                      },
                                      text: 'Create Entity',
                                    ),
                                  ],
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  

  Widget listItem(Entity entity) {
    return GestureDetector(
      onTap: () =>  {
        Get.toNamed(RouteName.entityDashboard,arguments: [
                    {"entityName": entity.name,"entityId":entity.id.toString(), "entityType":entity.entityType.toString()}
                  ])
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1, color: Color(0xFFE4E4EF)),
              ),
            ),
            padding: const EdgeInsets.fromLTRB(0,0,0,10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    width: 60.0,
                    height: 60.0,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.fitWidth,
                          image:
                              AssetImage('assets/images/ic_user_defualt.png')),
                    )),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextField(
                            textAlign: TextAlign.left,
                            line: 2,
                            text: Utils.textCapitalizationString(entity.name.toString()),
                            fontSize: 14.0,
                            fontColor: const Color(0xFF000000),
                            fontWeight: FontWeight.w400),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Image.asset('assets/images/ic_user_name.png'),
                            const SizedBox(
                              width: 3,
                            ),
                            CustomTextField(
                                textAlign: TextAlign.left,
                                text: Utils.textCapitalizationString(entity.managerName.toString()),//manager name
                                fontSize: 13.0,
                                fontColor: const Color(0xFF3C3C43),
                                fontWeight: FontWeight.w400)
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            // Get.back();
                          },
                          padding: EdgeInsets.zero,
                          icon: Image.asset(
                            height: 20,
                            width: 20,
                            'assets/images/ic_delete.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            // Get.back();
                          },
                          padding: EdgeInsets.zero,
                          icon: Image.asset(
                            height: 20,
                            width: 20,
                            'assets/images/ic_edit.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        // Image.asset(
                        //     height: 25, width: 25, 'assets/images/ic_edit.png'),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    entity.entityType == 1
                        ? Container(
                            width: 95,
                            height: 28,
                            decoration: const BoxDecoration(
                                border:  Border(
                                  left: BorderSide(
                                      color: Color(0xFF1F9254), width: 1),
                                  top: BorderSide(
                                      color: Color(0xFF1F9254), width: 1),
                                  bottom: BorderSide(
                                      color: Color(0xFF1F9254), width: 1),
                                  right: BorderSide(
                                      color: Color(0xFF1F9254), width: 1),
                                ),
                                color: Color(0xFFEBF9F1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(11))),
                            child: const Align(
                              alignment: Alignment.center,
                              child: CustomTextField(
                                  textAlign: TextAlign.center,
                                  text: 'Cold Storage',
                                  fontSize: 12.0,
                                  fontColor: Color(0xFF1F9254),
                                  fontWeight: FontWeight.w400),
                            ),
                          )
                        : Container(
                            width: 95,
                            height: 28,
                            decoration: const BoxDecoration(
                               border: Border(
                                  left: BorderSide(
                                      color: Color(0xFF1F3f92), width: 1),
                                  top: BorderSide(
                                      color: Color(0xFF1F3f92), width: 1),
                                  bottom: BorderSide(
                                      color: Color(0xFF1F3f92), width: 1),
                                  right: BorderSide(
                                      color: Color(0xFF1F3f92), width: 1),
                                ),
                                color: Color(0xFFD7E9FF),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(11))),
                            child: const Align(
                              alignment: Alignment.center,
                              child: CustomTextField(
                                  textAlign: TextAlign.center,
                                  text: 'Farmhouse',
                                  fontSize: 12.0,
                                  fontColor: Color(0xFF1F3f92),
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                  ],
                )
              ],
            )),
      ),
    );
  }

  toggleDone(bool bool) {}
}
