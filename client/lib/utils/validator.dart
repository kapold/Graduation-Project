class Validator {
  static String formatBelarusPhoneNumber(String phoneNumber) {
    final digitsOnly = phoneNumber.replaceAll(RegExp(r'[^0-9]'), '');

    const countryCode = '+375';
    final areaCode = '(${digitsOnly.substring(3, 5)})';
    final firstPart = digitsOnly.substring(5, 8);
    final secondPart = digitsOnly.substring(8, 10);
    final thirdPart = digitsOnly.substring(10);

    final formattedPhoneNumber =
        '$countryCode $areaCode $firstPart-$secondPart-$thirdPart';

    return formattedPhoneNumber;
  }

  static bool isPhoneNumberValid(String phoneNumber) {
    final RegExp regex = RegExp(r'^\+375 \(\d{2}\) \d{3}-\d{2}-\d{2}$');
    return regex.hasMatch(phoneNumber);
  }
}