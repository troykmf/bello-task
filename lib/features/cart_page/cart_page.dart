import 'package:bello_task/core/constants/app_colors.dart';
import 'package:bello_task/core/models/cart_items_model.dart';
import 'package:bello_task/features/view_models/cart_vm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CartPage extends ConsumerWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);
    final cartNotifier = ref.read(cartProvider.notifier);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
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
            ),
            SizedBox(height: screenHeight * 0.005),
            Divider(thickness: 0.5),

            // Your Cart Header
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_back_ios,
                      size: screenWidth * 0.04,
                      color: Colors.grey[600],
                    ),
                    SizedBox(width: screenWidth * 0.02),
                    Text(
                      'Your Cart',
                      style: GoogleFonts.ibmPlexSans(
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: screenHeight * 0.01),

            // Cart Items or Empty State
            Expanded(
              child: cartItems.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.shopping_cart_outlined,
                            size: screenWidth * 0.2,
                            color: Colors.grey[400],
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          Text(
                            'Your cart is empty',
                            style: GoogleFonts.ibmPlexSans(
                              fontSize: screenWidth * 0.05,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Column(
                      children: [
                        // Cart Items List
                        Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.04,
                            ),
                            itemCount: cartItems.length,
                            itemBuilder: (context, index) {
                              final cartItem = cartItems[index];
                              return _CartItemCard(
                                cartItem: cartItem,
                                onQuantityChanged: (quantity) {
                                  cartNotifier.updateQuantity(
                                    cartItem.product.id,
                                    quantity,
                                  );
                                },

                                onRemove: () {
                                  cartNotifier.removeFromCart(
                                    cartItem.product.id,
                                  );
                                },
                              );
                            },
                          ),
                        ),

                        // Order Summary
                        Container(
                          padding: EdgeInsets.all(screenWidth * 0.04),
                          decoration: BoxDecoration(color: Colors.white),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Order Info',
                                style: GoogleFonts.ibmPlexSans(
                                  fontSize: screenWidth * 0.038,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.01),

                              // Subtotal
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Subtotal',
                                    style: GoogleFonts.ibmPlexSans(
                                      fontSize: screenWidth * 0.034,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '\$${cartNotifier.totalAmount.toStringAsFixed(2)}',
                                    style: GoogleFonts.ibmPlexSans(
                                      fontSize: screenWidth * 0.034,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: screenHeight * 0.01),

                              // Shipping
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Shipping',
                                    style: GoogleFonts.ibmPlexSans(
                                      fontSize: screenWidth * 0.034,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '\$10',
                                    style: GoogleFonts.ibmPlexSans(
                                      fontSize: screenWidth * 0.034,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),

                              // SizedBox(height: screenHeight * 0.02),
                              SizedBox(height: screenHeight * 0.01),

                              // Total
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Total',
                                    style: GoogleFonts.ibmPlexSans(
                                      fontSize: screenWidth * 0.034,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    '\$${(cartNotifier.totalAmount + 10).toStringAsFixed(2)}',
                                    style: GoogleFonts.ibmPlexSans(
                                      fontSize: screenWidth * 0.035,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: screenHeight * 0.02),

                              // Checkout Button
                              SizedBox(
                                width: double.infinity,
                                height: screenHeight * 0.05,
                                child: ElevatedButton(
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Checkout functionality not implemented',
                                        ),
                                        backgroundColor: Colors.blue,
                                        behavior: SnackBarBehavior.floating,
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    elevation: 0,
                                  ),
                                  child: Text(
                                    'Checkout (\$${(cartNotifier.totalAmount + 10).toStringAsFixed(2)})',
                                    style: GoogleFonts.ibmPlexSans(
                                      color: Colors.white,
                                      fontSize: screenWidth * 0.045,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CartItemCard extends StatelessWidget {
  final CartItem cartItem;
  final Function(int) onQuantityChanged;
  final VoidCallback onRemove;

  const _CartItemCard({
    required this.cartItem,
    required this.onQuantityChanged,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      margin: EdgeInsets.only(bottom: screenHeight * 0.02),
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.04,
        vertical: screenWidth * 0.03,
      ),
      decoration: BoxDecoration(
        color: AppColors.grey50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Product Image
          Container(
            width: screenWidth * 0.15,
            height: screenWidth * 0.15,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Image.asset(
                cartItem.product.image,
                width: screenWidth * 5,
              ),

              // Text(
              //   cartItem.product.image,
              //   style: GoogleFonts.ibmPlexSans(fontSize: screenWidth * 0.08),
              // ),
            ),
          ),
          SizedBox(width: screenWidth * 0.04),

          // Product Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cartItem.product.title,
                  style: GoogleFonts.ibmPlexSans(
                    fontSize: screenWidth * 0.032,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: screenHeight * 0.005),
                Text(
                  '\$${cartItem.product.price.toStringAsFixed(2)}',
                  style: GoogleFonts.ibmPlexSans(
                    fontSize: screenWidth * 0.045,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: screenHeight * 0.005),
                Text(
                  'In stock',
                  style: GoogleFonts.ibmPlexSans(
                    fontSize: screenWidth * 0.032,
                    color: Colors.green,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (cartItem.quantity > 1) {
                              onQuantityChanged(cartItem.quantity - 1);
                            }
                          },
                          child: Container(
                            width: screenWidth * 0.1,
                            height: screenWidth * 0.1,
                            decoration: BoxDecoration(
                              color: AppColors.gray200,
                              // border: Border.all(color: Colors.grey[300]!),
                              // borderRadius: BorderRadius.circular(4),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.remove,
                              size: screenWidth * 0.06,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.05),
                        Text(
                          '${cartItem.quantity}',
                          style: GoogleFonts.ibmPlexSans(
                            fontSize: screenWidth * 0.03,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.05),
                        GestureDetector(
                          onTap: () {
                            onQuantityChanged(cartItem.quantity + 1);
                          },
                          child: Container(
                            width: screenWidth * 0.1,
                            height: screenWidth * 0.1,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.add,
                              size: screenWidth * 0.06,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Remove Button
                    Container(
                      width: screenWidth * 0.1,
                      height: screenWidth * 0.1,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: GestureDetector(
                        onTap: onRemove,
                        child: Align(
                          alignment: Alignment.center,
                          child: Icon(
                            CupertinoIcons.delete,
                            size: screenWidth * 0.06,
                            color: Colors.grey[400],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
