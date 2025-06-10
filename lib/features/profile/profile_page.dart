import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Profile Page", style: GoogleFonts.ibmPlexSans(fontSize: 23)),
    );
  }
}
