import 'dart:math';

import 'package:intl/intl.dart';

extension UniqueIdGenerator on DateTime {
  int generateUniqueId() {
    int randomPart =
        Random().nextInt(10000); // Generates a random number between 0 and 9999
    String uniqueIdString = '${this.millisecondsSinceEpoch}$randomPart';
    return int.parse(uniqueIdString);
  }
}

extension DateFormatter on String {
  String toFormattedDate() {
    try {
      DateTime dateTime = DateTime.parse(this); // Parse the string to DateTime
      return DateFormat('EEE, MMM d, yyyy').format(dateTime); // Format the date
    } catch (e) {
      return ''; // Return an error message if the string can't be parsed
    }
  }
}
