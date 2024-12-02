import 'dart:convert';

class AppFileHelper {

  final int _maxImages = 5;
  final int _maxSizeMB = 10;

  Future<String> validateImagesBySize(List<String> imageList) async {

    if (imageList.isNotEmpty) {
      // List<String> pickedFiles = imageList.map((img) => img['imgBase'].toString()).toList();

      int totalSize = _getFileSizeFromBase64(imageList);

      print('Total upload size ${(totalSize / (1024 * 1024))} cannot exceed $_maxSizeMB MB.');
      print('Total upload size ${(totalSize / (1024 * 1024)).round()} cannot exceed $_maxSizeMB MB.');

      if (imageList.length > _maxImages) {
        return 'You can upload a maximum of $_maxImages images.';
      } else if (totalSize > _maxSizeMB * 1024 * 1024) {
        return 'Total upload size cannot exceed $_maxSizeMB MB.';
      }
    }
    return '';
  }

  int _getFileSizeFromBase64(List<String> base64Strings) {
    int totalSize = 0;
    for (var base64 in base64Strings) {
      String newBase64 = base64.startsWith('data:image/png;base64,') ? base64.substring('data:image/png;base64,'.length) : base64;
      List<int> bytes = base64Decode(newBase64);
      totalSize += bytes.length;
    }
    return totalSize;
  }
}