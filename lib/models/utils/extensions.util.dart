extension ConvertToDouble on String {
  double toDouble() => this != null
      ? double.parse(this.replaceAll('.', '').replaceAll(',', '.'))
      : 0.0;
}
