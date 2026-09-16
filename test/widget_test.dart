import 'package:e_commerce_flutter/app/modules/product/views/product_view.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('product screen can be created', () {
    expect(const ProductView(), isA<ProductView>());
  });
}
