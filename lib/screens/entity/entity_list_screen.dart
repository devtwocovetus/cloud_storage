import 'package:cold_storage_flutter/models/entity/entity_list_model.dart';
import 'package:cold_storage_flutter/res/components/divider/basic_divider.dart';
import 'package:cold_storage_flutter/view_models/controller/entity/entitylist_view_model.dart';
import 'package:cold_storage_flutter/view_models/controller/home/home_view_model.dart';
import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reusable_components/reusable_components.dart';

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
          preferredSize: const Size.fromHeight(60),
          child: SafeArea(
            child: Container(
              height: 60,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      height: 15,
                      width: 15,
                      'assets/images/ic_sidemenu_icon.png',
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    const CustomTextField(
                        textAlign: TextAlign.center,
                        text: 'Entity Details',
                        fontSize: 18.0,
                        fontColor: Color(0xFF000000),
                        fontWeight: FontWeight.w500),
                    const Spacer(),
                    Image.asset(
                      height: 25,
                      width: 25,
                      'assets/images/ic_notification_bell.png',
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Container(
                        width: 40.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.fitWidth,
                              image:
                                  entityListViewModel.logoUrl.value.isNotEmpty
                                      ? NetworkImage(
                                          entityListViewModel.logoUrl.value)
                                      : const AssetImage(
                                          'assets/images/ic_user_defualt.png')),
                        ))
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
                    children: [
                      SizedBox(
                        width: 195,
                        child: TextField(
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.0)),
                            decoration: InputDecoration(
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
                      const Spacer(),
                      Container(
                        width: 133,
                        height: 50,
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
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap:() {
                          Get.toNamed(RouteName.entityOnboarding)!.then((value) {});
                        },
                        child: Image.asset(
                            width: 30,
                            height: 30,
                            'assets/images/ic_add_new.png'),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
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
                        child:  entityListViewModel.entityList!.isNotEmpty
                              ? ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount:
                                      entityListViewModel.entityList!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
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
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1, color: Color(0xFFE4E4EF)),
            ),
          ),
          padding: const EdgeInsets.all(10),
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
                        image: AssetImage('assets/images/ic_user_defualt.png')),
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
                          text: entity.name.toString(),
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
                              text: entity.ownerName.toString(),
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
                      Image.asset(
                          height: 25, width: 25, 'assets/images/ic_delete.png'),
                      const SizedBox(
                        width: 20,
                      ),
                      Image.asset(
                          height: 25, width: 25, 'assets/images/ic_edit.png'),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  entity.entityType == 1
                      ? Container(
                          width: 95,
                          height: 28,
                          decoration: const BoxDecoration(
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
                              color: Color(0xFFD7E9FF),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(11))),
                          child: const Align(
                            alignment: Alignment.center,
                            child: CustomTextField(
                                textAlign: TextAlign.center,
                                text: 'Farmhouse',
                                fontSize: 12.0,
                                fontColor: Color(0xFF1F9254),
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                ],
              )
            ],
          )),
    );
  }

  toggleDone(bool bool) {}
}
