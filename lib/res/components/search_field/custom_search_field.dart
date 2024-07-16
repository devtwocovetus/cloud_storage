import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomSearchField extends StatelessWidget {
  const CustomSearchField({
    super.key,
    this.onSubmit,
    this.onChanged,
    required this.searchController
  });


  final void Function(String)? onSubmit;
  final void Function(String)? onChanged;
  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: App.appSpacer.edgeInsets.x.s,
      padding: App.appSpacer.edgeInsets.y.xs,
      child: TextField(
        controller: searchController,
        textInputAction: TextInputAction.search,
        inputFormatters: [
          FilteringTextInputFormatter.deny(RegExp(r"\s+"), replacementString: " "),
          // NoLeadingSpaceFormatter(),
          FilteringTextInputFormatter.deny(RegExp(r'^[!@#%&*$~^+]'),replacementString: ""),
        ],
        onSubmitted: onSubmit,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          hintText: 'Search Here',
          hintStyle: const TextStyle(fontSize: 12),
          contentPadding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 18.0),
          // suffixIcon: searchController.text.isNotEmpty
          //     ? IconButton(
          //   onPressed: () async {
          //     searchController.clear();
          //     FocusManager.instance.primaryFocus?.unfocus();
          //     // this.search = '';
          //     // if(search.length <= 0){
          //     //   refreshController.requestRefresh();
          //     // }else{
          //     //   refreshController.requestRefresh();
          //     // }
          //   },
          //   icon: const Icon(Icons.clear, color: Colors.lightBlue,),
          // ) : IconButton(
          //   onPressed: () {
          //     // refreshController.requestRefresh();
          //   },
          //   icon: const Icon(
          //     Icons.search,
          //     color: Colors.lightBlue,
          //   ),
          // ),
        ),
      ),
    );
  }
}
