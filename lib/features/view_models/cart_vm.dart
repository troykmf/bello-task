import 'dart:convert';
import 'package:bello_task/core/models/cart_items_model.dart';
import 'package:bello_task/core/models/product_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]) {
    _loadCart();
  }

  Future<void> _loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartJson = prefs.getString('cart');
    if (cartJson != null) {
      final List<dynamic> cartList = json.decode(cartJson);
      state = cartList.map((item) => CartItem.fromJson(item)).toList();
    }
  }

  Future<void> _saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartJson = json.encode(state.map((item) => item.toJson()).toList());
    await prefs.setString('cart', cartJson);
  }

  void addToCart(Product product) {
    final existingIndex = state.indexWhere((item) => item.product.id == product.id);
    
    if (existingIndex >= 0) {
      state = [
        ...state.sublist(0, existingIndex),
        CartItem(product: product, quantity: state[existingIndex].quantity + 1),
        ...state.sublist(existingIndex + 1),
      ];
    } else {
      state = [...state, CartItem(product: product)];
    }
    _saveCart();
  }

  void removeFromCart(String productId) {
    state = state.where((item) => item.product.id != productId).toList();
    _saveCart();
  }

  void updateQuantity(String productId, int quantity) {
    if (quantity <= 0) {
      removeFromCart(productId);
      return;
    }

    final existingIndex = state.indexWhere((item) => item.product.id == productId);
    if (existingIndex >= 0) {
      state = [
        ...state.sublist(0, existingIndex),
        CartItem(product: state[existingIndex].product, quantity: quantity),
        ...state.sublist(existingIndex + 1),
      ];
      _saveCart();
    }
  }

  double get totalAmount {
    return state.fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  int get totalItems {
    return state.fold(0, (sum, item) => sum + item.quantity);
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>((ref) {
  return CartNotifier();
});