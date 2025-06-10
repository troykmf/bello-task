import 'package:bello_task/core/constants/app_bar.dart';
import 'package:bello_task/features/favorite_page/favorite_view.dart';
import 'package:bello_task/features/view_models/favorite_vm.dart';
import 'package:bello_task/features/view_models/product_vm.dart'
    show productsProvider;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesPage extends ConsumerWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteIds = ref.watch(favoritesProvider);
    final products = ref.watch(productsProvider);
    final favoriteProducts = products
        .where((product) => favoriteIds.contains(product.id))
        .toList();

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.04,
            vertical: screenHeight * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              CustomAppBar(
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),
              SizedBox(height: screenHeight * 0.005),
              Divider(thickness: 0.5),
              SizedBox(height: screenHeight * 0.01),

              // Favorites Title
              Text(
                'Favorites',
                style: TextStyle(
                  fontSize: screenWidth * 0.06,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: screenHeight * 0.03),

              // Favorites Content
              Expanded(
                child: favoriteProducts.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.favorite_border,
                              size: screenWidth * 0.2,
                              color: Colors.grey[400],
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            Text(
                              'No favorites yet',
                              style: TextStyle(
                                fontSize: screenWidth * 0.05,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            Text(
                              'Add items to your favorites by tapping the heart icon',
                              style: TextStyle(
                                fontSize: screenWidth * 0.035,
                                color: Colors.grey[500],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )
                    : GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: screenWidth * 0.04,
                          mainAxisSpacing: screenHeight * 0.02,
                          childAspectRatio: 0.8,
                        ),
                        itemCount: favoriteProducts.length,
                        itemBuilder: (context, index) {
                          final product = favoriteProducts[index];
                          return FavoriteCard(product: product);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
