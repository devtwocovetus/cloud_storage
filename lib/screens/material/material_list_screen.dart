import 'package:cold_storage_flutter/models/material/material_list_model.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/material/materiallist_view_model.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reusable_components/reusable_components.dart';
import '../../res/routes/routes_name.dart';

class MaterialListScreen extends StatefulWidget {
  const MaterialListScreen({super.key});

  @override
  State<MaterialListScreen> createState() => _MaterialListScreenState();
}

class _MaterialListScreenState extends State<MaterialListScreen> {
  final materialListViewModel = Get.put(MateriallistViewModel());
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
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => {
                        if (materialListViewModel.backOpration.value ==
                            'FromHome')
                          {Get.back()}
                        else
                          {Get.offAllNamed(RouteName.homeScreenView)}
                      },
                      child: Image.asset(
                        height: 15,
                        width: 10,
                        'assets/images/ic_sidemenu_icon.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    const CustomTextField(
                        textAlign: TextAlign.center,
                        text: 'Material',
                        fontSize: 18.0,
                        fontColor: Color(0xFF000000),
                        fontWeight: FontWeight.w500),
                    const Spacer(),
                    Image.asset(
                      height: 20,
                      width: 20,
                      'assets/images/ic_home_icon.png',
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Image.asset(
                      height: 20,
                      width: 20,
                      'assets/images/ic_notification_bell.png',
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Container(
                        width: 25.0,
                        height: 25.0,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.fitWidth,
                              image: AssetImage(
                                  'assets/images/ic_user_defualt.png')),
                        ))
                  ],
                ),
              ),
            ),
          )),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
            child: Row(
              children: [
                const CustomTextField(
                  text: 'Material',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontColor: Color(0xff000000),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {},
                  child: Image.asset(
                      width: 30, height: 30, 'assets/images/ic_add_new.png'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15,),
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
            child: Row(
              children: [
                SizedBox(
                  width: 195,
                  height: 37,
                  child: TextField(
                      textAlignVertical: TextAlignVertical.center,
                      style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 14.0)),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        prefixIcon:
                            Image.asset('assets/images/ic_search_field.png'),
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
                  height: 37,
                  decoration: const BoxDecoration(
                      color: Color(0xFFEFF8FF),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
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
                
              ],
            ),
          ),
          const SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: CustomTextField(
                      textAlign: TextAlign.left,
                      text: 'Category',
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      fontColor: Color(0xff000000),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 0, 65, 0),
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: CustomTextField(
                      textAlign: TextAlign.left,
                      text: 'Name',
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      fontColor: Color(0xff000000),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: CustomTextField(
                      textAlign: TextAlign.left,
                      text: 'Action',
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      fontColor: Color(0xff000000),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: materialListViewModel.materialList!.isNotEmpty
                ? ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: materialListViewModel.materialList!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return listItem(
                          materialListViewModel.materialList![index], index);
                    })
                : Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              Image.asset('assets/images/ic_blank_list.png'),
                              const SizedBox(
                                height: 10,
                              ),
                              const CustomTextField(
                                  textAlign: TextAlign.center,
                                  text: 'No Material Found',
                                  fontSize: 18.0,
                                  fontColor: Color(0xFF000000),
                                  fontWeight: FontWeight.w500),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 100,
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: MyCustomButton(
                            elevation: 50,
                            height: Utils.deviceHeight(context) * 0.06,
                            padding: Utils.deviceWidth(context) * 0.10,
                            borderRadius: BorderRadius.circular(10.0),
                            onPressed: () => {},
                            text: 'Add Material',
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      )),
    );
  }

  Widget listItem(MaterialItem material, int ind) {
    return GestureDetector(
      onTap: () => {Get.toNamed(RouteName.entityDashboard)},
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: ind % 2 == 0
                ? const Color(0xffEFF8FF)
                : const Color(0xffFFFFFF),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: CustomTextField(
                textAlign: TextAlign.left,
                text: material.categoryName.toString(),
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontColor: const Color(0xff074173),
              ),
            ),
            CustomTextField(
              textAlign: TextAlign.left,
              text: material.name.toString(),
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontColor: const Color(0xff074173),
            ),
            Row(
              children: [
                Image.asset(
                    height: 20,
                    width: 20,
                    'assets/images/ic_delete_dark_blue.png'),
                const SizedBox(
                  width: 10,
                ),
                const CustomTextField(
                  textAlign: TextAlign.center,
                  text: '|',
                  fontSize: 20,
                  fontWeight: FontWeight.w100,
                  fontColor: Color(0xff9CBFFF),
                ),
                const SizedBox(
                  width: 10,
                ),
                Image.asset(
                    height: 20,
                    width: 20,
                    'assets/images/ic_edit_dark_blue.png'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  toggleDone(bool bool) {}
}
