import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuicbuy/firebase_options.dart';
import 'package:kuicbuy/pages/account/account.dart';
import 'package:kuicbuy/pages/account/bloc/account_bloc.dart';
import 'package:kuicbuy/pages/home/bloc/product_list_bloc.dart';
import 'package:kuicbuy/pages/home/product_list.dart';

void main() async {
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "DM-Sans",
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrangeAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'KuicBuy'),
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
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: FlashyTabBar(
          animationCurve: Curves.linear,
          selectedIndex: _selectedIndex,
          iconSize: 30,
          showElevation: false, // use this to remove appBar's elevation
          onItemSelected: (index) => setState(() {
            _selectedIndex = index;
          }),
          items: [
            FlashyTabBarItem(
              icon: const Icon(Icons.home_rounded),
              title: const Text('Home'),
            ),
            FlashyTabBarItem(
              icon: const Icon(Icons.search),
              title: const Text('Search'),
            ),
            FlashyTabBarItem(
              icon: const Icon(Icons.person_rounded),
              title: const Text('Account'),
            ),
          ],
        ),
        body: Display(index: _selectedIndex));
  }
}

class Display extends StatelessWidget {
  const Display({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    switch (index) {
      case 0:
        return BlocProvider(
          create: (context) => ProductListBloc()..add(const GetProducts()),
          child: ProductList(),
        );
      case 1:
        return Center(child: Text("Not Yet Implemented Wag Assuming"));
      case 2:
        return BlocProvider(
          create: (context) => AccountBloc()
            ..add(GetAccount(userId: auth.currentUser?.uid ?? '')),
          child: const Account(),
        );
      default:
        return BlocProvider(
          create: (context) => ProductListBloc()..add(const GetProducts()),
          child: ProductList(),
        );
    }
  }
}
