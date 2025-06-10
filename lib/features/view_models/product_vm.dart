import 'package:bello_task/core/constants/product_list.dart';
import 'package:bello_task/core/models/product_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productsProvider = Provider<List<Product>>((ref) {
  return sampleProducts;
});

final currentPageProvider = StateProvider<int>((ref) => 0);