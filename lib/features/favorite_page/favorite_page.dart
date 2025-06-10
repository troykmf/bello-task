import 'package:bello_task/core/models/product_model.dart';
import 'package:bello_task/features/product_details/product_details_page.dart';
import 'package:bello_task/features/view_models/favorite_vm.dart';
import 'package:bello_task/features/view_models/product_vm.dart'
    show productsProvider;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

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
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 56,
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.01,
                          vertical: screenHeight * 0.005,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.lightBlue.shade200,
                          // borderRadius: BorderRadius.circular(6),
                        ),
                        child: Center(
                          child: Text(
                            'Full Logo',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: screenWidth * 0.02,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      // const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'DELIVERY ADDRESS',
                            style: TextStyle(
                              fontSize: screenWidth * 0.025,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 0),
                      // const Spacer(),
                      SvgPicture.asset(
                        'assets/svgs/notifi.svg',
                        color: Colors.grey[600],
                      ),
                      // Icon(
                      //   Icons.notifications_outlined,
                      //   size: screenWidth * 0.06,
                      //   color: Colors.grey[600],
                      // ),
                    ],
                  ),
                  Text(
                    'Umuezike Road, Oyo State',
                    style: TextStyle(
                      fontSize: screenWidth * 0.032,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ],
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
                          return _FavoriteCard(product: product);
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

class _FavoriteCard extends ConsumerWidget {
  final Product product;

  const _FavoriteCard({required this.product});

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
