
import 'package:bello_task/core/models/product_model.dart';
import 'package:bello_task/features/product_details/product_details_page.dart';
import 'package:bello_task/features/view_models/favorite_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteCard extends ConsumerWidget {
  final Product product;

  const FavoriteCard({required this.product, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(product: product),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image and Remove from Favorites
              Expanded(
                flex: 3,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(child: Image.asset(product.image)),
                    ),
                    Positioned(
                      top: screenHeight * 0.005,
                      right: screenWidth * 0.01,
                      child: GestureDetector(
                        onTap: () {
                          ref
                              .read(favoritesProvider.notifier)
                              .toggleFavorite(product.id);
                        },
                        child: Container(
                          padding: EdgeInsets.all(screenWidth * 0.015),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 2,
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.favorite,
                            color: Colors.red,
                            size: screenWidth * 0.045,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.01),

              // Product Title
              Text(
                product.title,
                style: TextStyle(
                  fontSize: screenWidth * 0.035,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: screenHeight * 0.005),

              // Product Price
              Text(
                '\$${product.price.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
