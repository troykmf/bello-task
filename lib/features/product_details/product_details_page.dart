import 'package:bello_task/core/constants/app_colors.dart';
import 'package:bello_task/core/models/product_model.dart';
import 'package:bello_task/features/view_models/cart_vm.dart';
import 'package:bello_task/features/view_models/favorite_vm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductDetailPage extends ConsumerWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final favorites = ref.watch(favoritesProvider);
    final isFavorite = favorites.contains(product.id);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.04,
                // vertical: screenHeight * 0.02,
              ),
              child: Column(
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
                        colorFilter: ColorFilter.mode(
                          Colors.grey[600]!,
                          BlendMode.srcIn,
                        ),
                      ),
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
            ),
            SizedBox(height: screenHeight * 0.005),
            Divider(thickness: 0.5),

            // Go back button
            Container(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Row(
                      children: [
                        Icon(
                          Icons.arrow_back_ios,
                          size: screenWidth * 0.03,
                          color: Colors.black,
                        ),
                        SizedBox(width: screenWidth * 0.02),
                        Text(
                          'Go back',
                          style: GoogleFonts.ibmPlexSans(
                            fontSize: screenWidth * 0.045,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: screenHeight * 0.03),

            // Product Content
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Image and Favorite
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Product Image
                        Container(
                          width: screenWidth * 0.92,
                          // width: screenWidth * 0.5,
                          height: screenHeight * 0.3,
                          decoration: BoxDecoration(
                            color: AppColors.grey50,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Stack(
                            children: [
                              Center(child: Image.asset(product.image)),
                              if (!product.inStock)
                                Positioned(
                                  bottom: screenHeight * 0.02,
                                  right: screenWidth * 0.02,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: screenWidth * 0.02,
                                      vertical: screenHeight * 0.005,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      'Out of Stock',
                                      style: GoogleFonts.ibmPlexSans(
                                        color: Colors.white,
                                        fontSize: screenWidth * 0.025,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),

                              Positioned(
                                right: screenWidth * 0.015,
                                top: screenHeight * 0.015,
                                child: GestureDetector(
                                  onTap: () {
                                    ref
                                        .read(favoritesProvider.notifier)
                                        .toggleFavorite(product.id);
                                  },
                                  child: Container(
                                    width: 44,
                                    height: 44,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    padding: EdgeInsets.all(screenWidth * 0.02),
                                    child: Icon(
                                      isFavorite
                                          ? CupertinoIcons.heart_fill
                                          : CupertinoIcons.heart,
                                      color: isFavorite
                                          ? Colors.red
                                          : Colors.black,
                                      size: screenWidth * 0.07,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // const Spacer(),

                        // Favorite Icon
                      ],
                    ),

                    SizedBox(height: screenHeight * 0.01),

                    // Product Title
                    Text(
                      product.title,
                      style: GoogleFonts.ibmPlexSans(
                        fontSize: screenWidth * 0.04,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.01),

                    // Product Price
                    Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: GoogleFonts.ibmPlexSans(
                        fontSize: screenWidth * 0.09,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.03),

                    // About this item
                    Text(
                      'About this item',
                      style: GoogleFonts.ibmPlexSans(
                        fontSize: screenWidth * 0.035,
                        // fontWeight: FontWeight.w600,
                        color: Colors.grey,
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.01),

                    // Product Description
                    Expanded(
                      child: SingleChildScrollView(
                        child: Text(
                          product.description,
                          style: GoogleFonts.ibmPlexSans(
                            fontSize: screenWidth * 0.035,
                            color: Colors.grey,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.02),

                    // Add to Cart Button
                    SizedBox(
                      width: double.infinity,
                      height: screenHeight * 0.05,
                      child: ElevatedButton(
                        onPressed: () {
                          if (!product.inStock) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  '${product.title} is out of stock',
                                ),
                                backgroundColor: Colors.red,
                                behavior: SnackBarBehavior.floating,
                                duration: Duration(seconds: 2),
                              ),
                            );
                            return;
                          }

                          ref.read(cartProvider.notifier).addToCart(product);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    CupertinoIcons.check_mark_circled,
                                    color: Colors.green,
                                  ),
                                  SizedBox(width: screenWidth * 0.035),
                                  Text(
                                    'Item has been added to cart',
                                    style: GoogleFonts.ibmPlexSans(
                                      fontSize: screenWidth * 0.034,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              backgroundColor: Colors.white,
                              behavior: SnackBarBehavior.floating,
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff60B5FF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Add to cart',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenWidth * 0.045,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.02),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
