extension StringExtension on String {
  String toCapitalize() {
    return length > 1 ? "${this[0].toUpperCase()}${substring(1).toLowerCase()}" : toUpperCase();
  }
}