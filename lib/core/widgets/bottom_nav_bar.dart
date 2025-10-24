import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:evolvify/core/utils/app_images.dart';
import 'package:evolvify/core/utils/constant.dart';
import 'package:evolvify/features/AI-Assessment/presentation/views/AI-Assessment_view.dart';
import 'package:evolvify/features/Premium/presentation/views/Premium_view.dart';
import 'package:evolvify/features/chatbot _ai/presentation/views/chatbot_page_with_cubit.dart';
import 'package:evolvify/features/community/presentation/views/community_page.dart';
import 'package:evolvify/features/home/presentation/views/home_view.dart';
import 'package:evolvify/features/profile/presentation/views/profile_view.dart';
import 'package:flutter/material.dart';

// class CustomBottomNavigationBar extends StatefulWidget {
//   @override
//   _CustomBottomNavigationBarState createState() =>
//       _CustomBottomNavigationBarState();
// }

// class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
//   int _currentIndex = 0;

//   final List<Widget> _pages = [
//     HomeView(),
//     ChatbotPage(),
//     CourseOverview(),
//     CommunityPage(),
//     FilterView(),
//   ];

// @override
// Widget build(BuildContext context) {
//   return Scaffold(body: CurvedNavWithImage());
//     body: _pages[_currentIndex],

//     // floatingActionButton: Container(
//     //   margin: EdgeInsets.only(bottom: 30),
//     //   padding: EdgeInsets.all(20), // padding حوالين الزر
//     //   decoration: BoxDecoration(
//     //     shape: BoxShape.circle,
//     //     color: Colors.white, // الخلفية حوالين الزر
//     //   ),
//     //   child: FloatingActionButton(
//     //     shape: CircleBorder(),
//     //     backgroundColor: Color(0xff98D1FF),
//     //     onPressed: () {},
//     //     child: SvgPicture.asset(Assets.imagesCamera),
//     //   ),
//     // ),

//     // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//     bottomNavigationBar: Container(
//       height: 80,
//       decoration: BoxDecoration(
//         color: AppColors.kPrimaryColor,
//         borderRadius: BorderRadius.only(),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             _buildBottomNavItem(Assets.imagesHome, 'Home', 0),
//             _buildBottomNavItem(Assets.imagesOpenAILogo, 'Chatbot', 1),
//             _buildBottomNavItem(Assets.imagesCamera, 'camera', 4),
//             _buildBottomNavItem(Assets.imagesCommunity, 'Community', 2),
//             _buildBottomNavItem(Assets.imagesPr, 'Profile', 3),
//           ],
//         ),
//       ),
//     ),
//   );
// }

// Widget _buildBottomNavItem(String imagePath, String label, int index) {
//   return GestureDetector(
//     onTap: () {
//       setState(() {
//         _currentIndex = index;
//       });
//     },
//     child: Column(
//       mainAxisSize: MainAxisSize.min,
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Image.asset(
//           imagePath,
//           width: 24,
//           height: 24,
//           color: _currentIndex == index ? Color(0xff98D1FF) : Colors.white,
//         ),
//         SizedBox(height: 6),
//         Text(
//           label,
//           style: TextStyle(
//             color: _currentIndex == index ? Color(0xff98D1FF) : Colors.white,
//             fontSize: getResponsiveFontSize(context, fontSize: 12),
//           ),
//         ),
//       ],
//     ),
//   );
//   }
// }

class CurvedNavWithImage extends StatefulWidget {
  @override
  _CurvedNavWithImageState createState() => _CurvedNavWithImageState();
}

class _CurvedNavWithImageState extends State<CurvedNavWithImage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomeView(),
    ChatbotPageWithCubit(),
    AiassessmentView(),
    CommunityPage(),

    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      body: _pages[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        height: 60,
        backgroundColor: Colors.transparent,
        color: AppColors.kPrimaryColor,
        buttonBackgroundColor: AppColors.kPrimaryColor,
        animationDuration: Duration(milliseconds: 300),
        items: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              Assets.imagesHome,
              width: 27,
              height: 27,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              Assets.imagesOpenAILogo,
              width: 27,
              height: 27,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              Assets.imagesCamera,
              width: 30,
              height: 30,
              color: Colors.white,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              Assets.imagesCommunity,
              width: 30,
              height: 30,
              fit: BoxFit.cover,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              Assets.imagesP,
              width: 20,
              height: 20,
              fit: BoxFit.cover,
            ),
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
