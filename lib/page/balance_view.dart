import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BalanceScreenApp extends StatelessWidget {
  const BalanceScreenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const BalanceScreenStateful(),
    );
  }
}

class BalanceScreenStateful extends StatefulWidget {
  const BalanceScreenStateful({super.key});

  @override
  State<BalanceScreenStateful> createState() => _BalanceScreen();
}

class _BalanceScreen extends State<BalanceScreenStateful> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF14123A),
      appBar: AppBar(
          backgroundColor: const Color(0xFF14123A),
          elevation: 0,
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          title: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Row(
              children: [
                CryptoDropdownWidget(),
                const Spacer(),
                UserNameWidget(),
                const Spacer(),
                NotificationBellWidget(),
              ],
            ),
          )),
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
        /// Home page
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 200,
                    height: 200,
                    child: const Stack(
                      alignment: Alignment.center,
                      children: [
                        CircularProgressIndicator(
                          value: 0.75,
                          strokeWidth: 12,
                          valueColor: AlwaysStoppedAnimation(Colors.green),
                          backgroundColor: Colors.deepPurple,
                        ),
                        CircularProgressIndicator(
                          value: 0.5,
                          strokeWidth: 12,
                          valueColor: AlwaysStoppedAnimation(Colors.blue),
                          backgroundColor: Colors.transparent,
                        ),
                        CircularProgressIndicator(
                          value: 0.25,
                          strokeWidth: 12,
                          valueColor: AlwaysStoppedAnimation(Colors.purple),
                          backgroundColor: Colors.transparent,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '1M Satoshi',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 24),
                            ),
                            Text(
                              '\$168.88 USD',
                              style: TextStyle(color: Colors.white70),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.send, color: Colors.white),
                    label: const Text(
                      'Send',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF9327F0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Wallet Addresses',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                const SizedBox(height: 10),
                const WalletAddressTile(address: '1Lb...ZnX71'),
                const WalletAddressTile(address: 'mcQ...igMic'),
                const WalletAddressTile(address: 'bRc...42TWE'),
              ],
            ),
          ),
        ),

        /// Notifications page
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Card(
                child: ListTile(
                  leading: Icon(Icons.notifications_sharp),
                  title: Text('Notification 1'),
                  subtitle: Text('This is a notification'),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.notifications_sharp),
                  title: Text('Notification 2'),
                  subtitle: Text('This is a notification'),
                ),
              ),
            ],
          ),
        ),

        /// Messages page
        ListView.builder(
          reverse: true,
          itemCount: 2,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Align(
                alignment: Alignment.centerRight,
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    'Hello',
                  ),
                ),
              );
            }
            return Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  'Hi!',
                ),
              ),
            );
          },
        ),
      ][currentPageIndex],
    );
  }
}

class WalletAddressTile extends StatelessWidget {
  final String address;

  const WalletAddressTile({required this.address});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white24,
      child: ListTile(
        title: Text(
          address,
          style: const TextStyle(color: Colors.white),
        ),
        trailing: ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.send, color: Colors.white),
          label: const Text(
            'Send',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF9327F0),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          ),
        ),
      ),
    );
  }
}

class CryptoDropdownWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white24),
        color: const Color(0xFF1E1C47),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.orange,
            ),
            padding: const EdgeInsets.all(6),
            child: const FaIcon(
              FontAwesomeIcons.bitcoin,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 8),
          const Icon(
            Icons.arrow_drop_down,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}

class UserNameWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Seno Pamungkas',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        SizedBox(width: 5),
        Icon(
          Icons.arrow_drop_down,
          color: Colors.white,
        ),
      ],
    );
  }
}

class NotificationBellWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Icon(
          Icons.notifications,
          color: Colors.white,
          size: 28,
        ),
        Positioned(
          right: 0,
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            constraints: const BoxConstraints(
              minWidth: 12,
              minHeight: 12,
            ),
          ),
        )
      ],
    );
  }
}
