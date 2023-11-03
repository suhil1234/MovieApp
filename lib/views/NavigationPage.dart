import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/ForthPage.dart';
import 'package:flutter_application_1/views/SearchPage.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import '../controllers/ReviewsController.dart';
import '../views/MainPage.dart';
import 'HomePage.dart';
import '../controllers/NavigationController.dart';
import '../controllers/GenresController.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  NavigationController controller = Get.put(NavigationController());
  GenresController favoriteController = Get.put(GenresController());
     final MovieReviewsController movieReviewsController =
  Get.put(MovieReviewsController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        child: Scaffold(
         appBar: AppBar(
          title: Center(child: Text('Movies')),
          backgroundColor: Colors.transparent,
         ),
          body: SafeArea(
              child: IndexedStack(
            index: controller.tabIndex.value,
            children: [
              MainPage(),
              HomePage(),
              SearchResultsPage(),
                        ],
          )),
          bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
         
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.purple[300]!,
              hoverColor: Colors.purple[100]!,
              gap: 8,
              activeColor: Color.fromRGBO(156, 39, 176, 1),
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.purple[100]!,
              color: Colors.purple[300],
              tabs: const [
                GButton(
                  icon: LineIcons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: LineIcons.star,
                  text: 'Top-Rated',
                ),
                GButton(
                  icon: LineIcons.search,
                  text: 'Search',
                ),
              ],
              selectedIndex: controller.tabIndex.value,
              onTabChange: controller.changeTabIndex,
            ),
          ),
        ),
      ),
        ),
      );
    });
  }
}
