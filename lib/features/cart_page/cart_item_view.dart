import 'package:bello_task/core/constants/app_colors.dart';
import 'package:bello_task/core/models/cart_items_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CartItemCard extends StatelessWidget {
  final CartItem cartItem;
  final Function(int) onQuantityChanged;
  final VoidCallback onRemove;

  const CartItemCard({
    super.key,
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
                width: screenWidth * 1,
              ),
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
