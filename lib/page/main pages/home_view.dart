import 'package:bittrack_frontend/page/main%20pages/balance_viewModel.dart';
import 'package:bittrack_frontend/page/main%20pages/sendCrypto_viewModel.dart';
import 'package:flutter/material.dart';

class HomeScreenApp extends StatelessWidget {
  const HomeScreenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          labelTextStyle: MaterialStateProperty.resolveWith<TextStyle>(
            (Set<MaterialState> states) =>
                states.contains(MaterialState.selected)
                    ? const TextStyle(color: Colors.white)
                    : const TextStyle(color: Colors.white),
          ),
        ),
        child: NavigationBar(
            onDestinationSelected: (int index) {
              setState(() {
                currentPageIndex = index;
              });
            },
            backgroundColor: const Color(0xFF14123A),
            indicatorColor: Colors.purple,
            selectedIndex: currentPageIndex,
            destinations: const <Widget>[
              NavigationDestination(
                icon: Icon(Icons.home, color: Colors.white),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(Icons.send, color: Colors.white),
                label: 'Send',
              ),
              NavigationDestination(
                icon: Badge(
                  child:
                      Icon(Icons.account_balance_wallet, color: Colors.white),
                ),
                label: 'Wallet',
              ),
            ]),
      ),
      body: <Widget>[
        /// Balance Page
        const BalanceScreenViewModel(),

        /// Send Crypto page
        SendCryptoScreenViewModel(),

        /// Wallet Page
        SendCryptoScreenViewModel(),
      ][currentPageIndex],
    );
  }
}
