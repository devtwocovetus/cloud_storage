import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reusable_components/reusable_components.dart';
import 'package:textfield_tags/textfield_tags.dart';

import '../../../i10n/strings.g.dart';
import '../../../utils/utils.dart';
import '../../../view_models/services/app_services.dart';
import '../../colors/app_color.dart';

class TagsTextField extends StatefulWidget {
  TagsTextField({super.key,
    required this.stringTagController,
    required this.textFieldTagValues,
    required this.hintText1,
    required this.hintText2,
    required this.onAddButtonTap,
    required this.tagsList,
    required this.tagScrollController,
    required this.visibleTagField,
    this.validating
   });

  final Rx<StringTagController<String>> stringTagController;
  Rx<InputFieldValues<String>>? textFieldTagValues;
  final RxList<String> tagsList;
  final String hintText1;
  final String hintText2;
  final VoidCallback onAddButtonTap;
  ScrollController tagScrollController;
  RxBool visibleTagField;
  final String? Function(String?)? validating;
  // final TextEditingController textEditingController;


  @override
  State<TagsTextField> createState() => _TagsTextFieldState();
}

class _TagsTextFieldState extends State<TagsTextField> {

  // bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Obx(()=>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // if(widget.textFieldTagValues?.value != null)...{
          CustomTextFormField(
            width: App.appQuery.responsiveWidth(100),
            height: 25.h,
            borderRadius: BorderRadius.circular(10.0),
            hint: widget.tagsList.isNotEmpty ? '' : widget.hintText1,
            readOnly: true,
            controller: TextEditingController(),
            focusNode: FocusNode(),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: kAppError,
                width: 1,
              ),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            prefixConstraints: BoxConstraints(maxWidth: App.appQuery.responsiveWidth(80)),
            prefixIcon: widget.tagsList.isNotEmpty
              ? SingleChildScrollView(
              controller: widget.tagScrollController,
              scrollDirection: Axis.horizontal,
              child: Row(
                children: widget.tagsList.map((tag) {
                  return Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                      color: kAppGreyC,
                    ),
                    margin: const EdgeInsets.only(left: 10.0),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 4.0),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          child: Text(
                            tag,
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: kAppBlackC,
                                fontSize: 13.5.sp)),
                          ),
                          onTap: () {
                            //print("$tag selected");
                            // widget.textFieldTagValues!.value.onTagRemoved(tag);
                            // widget.tagsList.remove(tag);
                            // widget.tagsList.value = widget.textFieldTagValues!.value.tags;
                            widget.tagsList.remove(tag);

                          },
                        ),
                        const SizedBox(width: 4.0),
                        InkWell(
                          child: Icon(
                            CupertinoIcons.multiply,
                            size: 14.0.h,
                            color: kAppBlackB,
                          ),
                          onTap: () {
                            // WidgetsBinding.instance.addPostFrameCallback((_) {
                            //
                            // });
                            // widget.textFieldTagValues!.value.onTagRemoved(tag);
                            widget.tagsList.remove(tag);
                            // widget.tagsList.value = widget.textFieldTagValues!.value.tags;
                            print('MYMYMYMYMYMY');
                            print('complianceTagsList 3: ${widget.tagsList.value}');
                            print('complianceTagsList 4: ${widget.textFieldTagValues!.value.tags}');
                          },
                        )
                      ],
                    ),
                  );
                },).toList(),
              )
            ) : null,
            suffixIcon:  IconButton(
              onPressed: () {
                widget.visibleTagField.value = !widget.visibleTagField.value;
                // setState(() {
                // widget.visibleTagField = !isVisible;
                // });
                // widget.visibleTagField = true;
              },
              icon: Icon(Icons.add,color: kAppBlack,size: 24.h,)
            ),
            validating: widget.validating,
            textCapitalization: TextCapitalization.none,
            keyboardType: TextInputType.text,
            ),
            // },
          Visibility(
            visible: widget.visibleTagField.value,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 12.h,),
                TextFieldTags<String>(
                  textfieldTagsController: widget.stringTagController.value,
                  letterCase: LetterCase.normal,
                  textSeparators: const ['5676544533672536347634'],
                  // validator: (tag) {
                  //   if (tag == 'php') {
                  //     return 'No, please just no';
                  //   } else if (widget.stringTagController.value.getTags!.contains(tag)) {
                  //     return 'You\'ve already entered that';
                  //   }
                  //   return null;
                  // },
                  inputFieldBuilder: (context, textFieldTagValues) {
                    widget.textFieldTagValues?.value = textFieldTagValues;
                    widget.tagScrollController = textFieldTagValues.tagScrollController;
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 8,
                          child: CustomTextFormField(
                            controller: textFieldTagValues.textEditingController,
                            focusNode: textFieldTagValues.focusNode,
                            hint: widget.hintText2,
                            textCapitalization: TextCapitalization.words,
                            keyboardType: TextInputType.text,
                            height: 25.h,
                            borderRadius: const BorderRadius.horizontal(left: Radius.circular(10)),
                            onChanged: textFieldTagValues.onTagChanged,
                            onSubmit: textFieldTagValues.onTagSubmitted,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: MyCustomButton(
                            splashColor: kWhite_8,
                            fontSize: 13.0.sp,
                            fontWeight: FontWeight.w400,
                            // width: 87.0,
                            height: 47.0.h,
                            borderRadius: const BorderRadius.horizontal(right: Radius.circular(8)),
                            onPressed: widget.onAddButtonTap,
                            text: t.add,
                          ),
                        )
                      ],
                    );
                  },
                ),
              ],
            )
          ),
        ],
      ),
    );
  }
}
