extension doubleExtension on double{
  String get asCurrency => '\$$this';
}


extension StringExtension on String{
  bool isValidEmail(){
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(this);
  }
}