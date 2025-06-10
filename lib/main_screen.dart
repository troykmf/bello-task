
import 'package:bello_task/features/cart_page/cart_page.dart';
import 'package:bello_task/features/favorite_page/favorite_page.dart';
import 'package:bello_task/features/home_page/home_page.dart';
import 'package:bello_task/features/profile/profile_page.dart';
import 'package:bello_task/features/view_models/cart_vm.dart';
import 'package:bello_task/features/view_models/product_vm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPage = ref.watch(currentPageProvider);
    final cartItems = ref.watch(cartProvider);
    final screenWidth = MediaQuery.of(context).size.width;

    final List<Widget> pages = [
      const HomePage(),
      const CartPage(),
      const FavoritesPage(),
      const ProfilePage(),
    ];

    return Scaffold(
      body: IndexedStack(index: currentPage, children: pages),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: currentPage,
          onTap: (index) {
            if (index == 1) {
              // Navigate to CartPage without bottom navigation bar
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartPage()),
              );
            } else {
              ref.read(currentPageProvider.notifier).state = index;
            }
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey[600],
          selectedLabelStyle: GoogleFonts.ibmPlexSans(
            fontSize: screenWidth * 0.03,
            fontWeight: FontWeight.w600,
          ),

          unselectedLabelStyle: GoogleFonts.ibmPlexSans(
            fontSize: screenWidth * 0.03,
            fontWeight: FontWeight.w500,
          ),

          items: [
            BottomNavigationBarItem(
              icon: Container(
                padding: EdgeInsets.all(screenWidth * 0.02),
                decoration: BoxDecoration(
                  color: currentPage == 0
                      ? Colors.transparent
                      : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  'assets/svgs/icons_home.svg',
                  color: currentPage == 0 ? Colors.blue : Colors.grey[600],
                ),

                // Icon(
                //   Icons.home,
                //   color: currentPage == 0 ? Colors.white : Colors.grey[600],
                //   size: screenWidth * 0.06,
                // ),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.all(screenWidth * 0.02),
                    decoration: BoxDecoration(
                      color: currentPage == 1
                          ? Colors.transparent
                          : Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.shopping_cart_outlined,
                      color: currentPage == 1 ? Colors.blue : Colors.grey[600],
                      size: screenWidth * 0.06,
                    ),
                  ),
                  if (cartItems.isNotEmpty)
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        padding: EdgeInsets.all(screenWidth * 0.01),
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                        constraints: BoxConstraints(
                          minWidth: screenWidth * 0.04,
                          minHeight: screenWidth * 0.04,
                        ),
                        child: Text(
                          '${cartItems.fold(0, (sum, item) => sum + item.quantity)}',
                          style: GoogleFonts.ibmPlexSans(
                            color: Colors.white,
                            fontSize: screenWidth * 0.025,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: EdgeInsets.all(screenWidth * 0.02),
                decoration: BoxDecoration(
                  color: currentPage == 2
                      ? Colors.transparent
                      : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  CupertinoIcons.heart,
                  // Icons.favorite_outline,
                  color: currentPage == 2 ? Colors.blue : Colors.grey[600],
                  size: screenWidth * 0.06,
                ),
              ),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: EdgeInsets.all(screenWidth * 0.02),
                decoration: BoxDecoration(
                  color: currentPage == 3
                      ? Colors.transparent
                      : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  'assets/svgs/icons_user-circle.svg',
                  color: currentPage == 3 ? Colors.blue : Colors.grey[600],
                ),
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
