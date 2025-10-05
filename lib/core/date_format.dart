String two(int n) => n.toString().padLeft(2, '0');

/// Format as MM-DD-YYYY HH:SS (2-digit fields)
String formatAsMmDdYyyyHhSs(DateTime dt) {
  final mm = two(dt.month);
  final dd = two(dt.day);
  final yyyy = dt.year.toString();
  final hh = two(dt.hour);
  final ss = two(dt.second);
  return '$mm-$dd-$yyyy $hh:$ss';
}
