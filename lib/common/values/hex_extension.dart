extension HexColorStringExtension on String {
  // Method to convert hex string to an integer
   hexToInt() {
    String hex = this.replaceFirst('#', '');
    hex = hex.length == 6 ? 'ff' + hex : hex;
    return int.parse(hex, radix: 16);
  }
}
