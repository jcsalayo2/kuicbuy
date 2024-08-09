import 'package:algolia_helper_flutter/algolia_helper_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuicbuy/bloc/main_bloc.dart';
import 'package:kuicbuy/core/boot/environment.dart';
import 'package:kuicbuy/firebase_options.dart';
import 'package:kuicbuy/pages/account/account.dart';
import 'package:kuicbuy/pages/account/bloc/account_bloc.dart';
import 'package:kuicbuy/pages/home/bloc/product_list_bloc.dart';
import 'package:kuicbuy/pages/home/product_grid.dart';
import 'package:kuicbuy/pages/saved/saved.dart';
import 'package:kuicbuy/pages/search/bloc/search_bloc.dart';
import 'package:kuicbuy/pages/search/search.dart';
import 'package:kuicbuy/services/account_services.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:badges/badges.dart' as badges;

void main() async {
  await Environment.initialize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "DM-Sans",
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) =>
            MainBloc()..add(GetSaved(uid: auth.currentUser?.uid ?? "")),
        child: const MyHomePage(title: 'KuicBuy'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<ScrollController> _scrollControllers = [
    ScrollController(),
    ScrollController(),
    ScrollController(),
    ScrollController(),
  ];

  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        return Scaffold(
            backgroundColor: Colors.white,
            body: PersistentTabView(
              context,
              controller: state.controller,
              screens: [
                BlocProvider(
                  create: (context) =>
                      ProductListBloc()..add(const GetProducts()),
                  child: const ProductGrid(),
                ),
                BlocProvider(
                  create: (context) => SearchBloc(),
                  child: const Search(),
                ),
                const Saved(),
                BlocProvider(
                  create: (context) => AccountBloc()
                    ..add(GetAccount(userId: auth.currentUser?.uid ?? '')),
                  child: const Account(),
                ),
              ],
              items: _navBarsItems(saved: state.saved),
              resizeToAvoidBottomInset:
                  true, // This needs to be true if you want to move up the screen on a non-scrollable screen when keyboard appears. Default is true.
              hideNavigationBarWhenKeyboardAppears: true,
              popBehaviorOnSelectedNavBarItemPress: PopBehavior.all,
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              // backgroundColor: Colors.grey.shade900,
              isVisible: state.isVisible,
              animationSettings: const NavBarAnimationSettings(
                navBarItemAnimation: ItemAnimationSettings(
                  // Navigation Bar's items animation properties.
                  duration: Duration(milliseconds: 400),
                  curve: Curves.ease,
                ),
                screenTransitionAnimation: ScreenTransitionAnimationSettings(
                  // Screen transition animation on change of selected tab.
                  animateTabTransition: true,
                  duration: Duration(milliseconds: 400),
                  screenTransitionAnimationType:
                      ScreenTransitionAnimationType.slide,
                ),
              ),
              confineToSafeArea: true,
              navBarHeight: kBottomNavigationBarHeight,
              navBarStyle: NavBarStyle
                  .style1, // Choose the nav bar style with this property
            ));
      },
    );
  }

  List<PersistentBottomNavBarItem> _navBarsItems(
      {required List<String> saved}) {
    return [
      persistentBottomNavBarItem(
          icon: const Icon(Icons.home),
          title: "Home",
          controller: _scrollControllers[0]),
      persistentBottomNavBarItem(
          icon: const Icon(Icons.search),
          title: "Search",
          controller: _scrollControllers[1]),
      persistentBottomNavBarItem(
          icon: badges.Badge(
            position: badges.BadgePosition.topEnd(top: -10, end: -4),
            badgeStyle: const badges.BadgeStyle(
              badgeColor: Colors.blue,
            ),
            badgeContent: Text(
              saved.length.toString(),
              style: const TextStyle(color: Colors.white),
            ),
            child: const Icon(Icons.bookmark_border),
          ),
          title: "Saved",
          controller: _scrollControllers[2]),
      persistentBottomNavBarItem(
          icon: const Icon(Icons.person_rounded),
          title: "Account",
          controller: _scrollControllers[3])
    ];
  }

  PersistentBottomNavBarItem persistentBottomNavBarItem(
      {required Widget icon,
      required String title,
      required ScrollController controller}) {
    return PersistentBottomNavBarItem(
      icon: icon,
      title: title,
      activeColorPrimary: CupertinoColors.activeBlue,
      inactiveColorPrimary: CupertinoColors.systemGrey,
      scrollController: controller,
    );
  }
}
