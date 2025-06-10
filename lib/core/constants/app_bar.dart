import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });

  final double screenWidth;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Column(
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
              colorFilter: ColorFilter.mode(Colors.grey[600]!, BlendMode.srcIn),
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
    );
  }
}
