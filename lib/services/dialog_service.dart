// dialog_service.dart

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DialogService {
  void showConfirmDialog(BuildContext context, String address, int trustScore,
      String network, String amount) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          backgroundColor: const Color(0xFF1E1C47),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    'Confirm Order',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Address :',
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 4),
                Text(
                  address,
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Trust :',
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      '$trustScore',
                      style: TextStyle(
                        color: trustScore >= 50 ? Colors.green : Colors.red,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 4.0),
                    Icon(
                      trustScore >= 50 ? Icons.check_circle : Icons.cancel,
                      color: trustScore >= 50 ? Colors.green : Colors.red,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'Network :',
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    FaIcon(
                      network == 'BTC'
                          ? FontAwesomeIcons.bitcoin
                          : network == 'ETH'
                              ? FontAwesomeIcons.ethereum
                              : FontAwesomeIcons.coins,
                      color: Colors.orange,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      network,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'Amount :',
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 4),
                Text(
                  amount,
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 16),
                Text(
                  trustScore >= 50
                      ? 'This Address is Trusted'
                      : 'This Address is Not Trusted',
                  style: TextStyle(
                      color: trustScore >= 50 ? Colors.green : Colors.red),
                ),
                const SizedBox(height: 24),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      // Handle send action
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
                      backgroundColor: const Color(0xFF1D74F5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text('Send'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
