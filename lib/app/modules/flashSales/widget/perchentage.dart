class GetPercentage {
  static double percent(
      {required int salePrice, required int regularPrice}) {
    final discount = regularPrice - salePrice ;
    return (discount / regularPrice) * 100;
  }
}
