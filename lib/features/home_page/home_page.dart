import 'package:bello_task/core/constants/app_bar.dart';
import 'package:bello_task/features/home_page/product_card.dart';
import 'package:bello_task/features/view_models/product_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productsProvider);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.04,
                vertical: screenHeight * 0.01,
              ),
              child: CustomAppBar(
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),
            ),
            SizedBox(height: screenHeight * 0.01),

            // Search Bar
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.04,
                vertical: screenHeight * 0.0001,
              ),
              height: screenHeight * 0.05,
              width: screenWidth,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: GoogleFonts.ibmPlexSans(
                    color: Colors.grey[500],
                    fontSize: screenWidth * 0.04,
                  ),

                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey[500],
                    size: screenWidth * 0.05,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    // horizontal: screenWidth * 0.04,
                    vertical: screenHeight * 0.013,
                  ),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.005),
            Divider(thickness: 0.5),
            SizedBox(height: screenHeight * 0.005),

            // Technology Category
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.04,
                // vertical: screenHeight * 0.02,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.arrow_back_ios,
                    size: screenWidth * 0.04,
                    color: Colors.grey[600],
                  ),
                  SizedBox(width: screenWidth * 0.02),
                  Text(
                    'Technology',
                    style: GoogleFonts.ibmPlexSans(
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.007),

            // Category Subtitle
            ColoredBox(
              color: Colors.grey.shade50,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.04,
                  vertical: screenHeight * 0.01,
                ),
                child: SizedBox(
                  width: double.maxFinite,
                  child: Text(
                    'Smartphones, Laptops &\nAssecories',
                    style: GoogleFonts.ibmPlexMono(
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                      height: 1.3,
                    ),
                  ),
                ),
              ),
            ),

            // Products Grid
            ColoredBox(
              color: Colors.grey.shade50,
              child: SizedBox(
                height: screenHeight * 0.53,
                // height: 465,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: screenWidth * 0.04,
                    mainAxisSpacing: screenHeight * 0.02,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return ProductCard(product: product);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
