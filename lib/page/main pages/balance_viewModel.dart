import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BalanceScreenViewModel extends StatelessWidget {
  const BalanceScreenViewModel({super.key});

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
      body: SingleChildScrollView(
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '1M Satoshi',
                            style: TextStyle(color: Colors.white, fontSize: 24),
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
                  icon: const Text(
                    'Send',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  label: const Icon(Icons.send, color: Colors.white),
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
    );
  }
}

class WalletAddressTile extends StatelessWidget {
  final String address;

  const WalletAddressTile({required this.address});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFF19173D),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListTile(
        title: Text(
          address,
          style: const TextStyle(color: Colors.white),
        ),
        trailing: ElevatedButton.icon(
          onPressed: () {},
          icon: const Text(
            'Send',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          label: const Icon(Icons.send, color: Colors.white),
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
            decoration: BoxDecoration(
              color: const Color(0xFF26225C),
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: const EdgeInsets.all(6),
            child: const FaIcon(
              FontAwesomeIcons.bitcoin,
              color: Colors.orange,
              size: 16,
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
