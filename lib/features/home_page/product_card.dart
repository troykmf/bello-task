import 'package:bello_task/core/models/product_model.dart';
import 'package:bello_task/features/product_details/product_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductCard extends ConsumerWidget {
  final Product product;

  const ProductCard({required this.product, super.key});

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
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              Expanded(
                flex: 5,
                child: Container(
                  height: 162,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Image.asset(product.image, fit: BoxFit.cover),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.01),

              // Product Title
              Text(
                product.title,
                style: GoogleFonts.ibmPlexSans(
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
                style: GoogleFonts.ibmPlexSans(
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
