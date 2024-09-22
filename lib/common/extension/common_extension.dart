import 'dart:math';

extension UniqueIdGenerator on DateTime {
  int generateUniqueId() {
    int randomPart = Random().nextInt(10000); // Generates a random number between 0 and 9999
    String uniqueIdString = '${this.millisecondsSinceEpoch}$randomPart';
    return int.parse(uniqueIdString);
  }
}