// dialog_service.dart

import 'package:bittrack_frontend/ui/gradient.button.dart';
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
            child: SingleChildScrollView(
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
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildAddressRow('Address :', address),
                  const SizedBox(height: 16),
                  _buildTrustRow('Trust :', trustScore),
                  const SizedBox(height: 16),
                  _buildRow('Network :', network,
                      icon: _getNetworkIcon(network)),
                  const SizedBox(height: 16),
                  _buildRow('Amount :', '$amount Satoshi'),
                  const SizedBox(height: 16),
                  Text(
                    trustScore >= 50
                        ? 'This Address is Trusted'
                        : 'This Address has low Trust score, do you really wish to proceed?',
                    style: TextStyle(
                        color: trustScore >= 50 ? Colors.green : Colors.red,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: Column(
                      children: [
                        trustScore >= 50
                            ? _buildSendButton(context)
                            : _buildProceedButton(context),
                        const SizedBox(height: 8),
                        trustScore >= 50
                            ? _buildCancelButton(context, true)
                            : _buildCancelButton(context, false)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAddressRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildRow(String label, String value, {Widget? icon}) {
    return Row(
      children: [
        Text(
          '$label ',
          style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
        ),
        if (icon != null) ...[
          icon,
          const SizedBox(width: 8),
        ],
        Expanded(
          child: Text(
            value,
            style: const TextStyle(color: Colors.white),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildTrustRow(String label, int trustScore) {
    return Row(
      children: [
        Text(
          '$label ',
          style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
        ),
        Text(
          '$trustScore',
          style: TextStyle(
            color: trustScore >= 50 ? Colors.green : Colors.red,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 4),
        Icon(
          trustScore >= 50 ? Icons.check_circle : Icons.cancel,
          color: trustScore >= 50 ? Colors.green : Colors.red,
        ),
      ],
    );
  }

  Widget _buildSendButton(BuildContext context) {
    return GradientButton(
      onPressed: () {
        Navigator.of(context).pop();
        showSuccessDialog(context);
      },
      text: "Send",
    );
  }

  Widget _buildProceedButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).pop();
        showSuccessDialog(context);
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        backgroundColor: Colors.red,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: const Text(
        'Yes, I understand the risk\nand would like to proceed',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildCancelButton(BuildContext context, bool highlight) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).pop();
        // Handle cancel action
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        backgroundColor: highlight ? Colors.red : Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: const Text('Cancel', style: TextStyle(color: Colors.white)),
    );
  }

  void showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.of(context).pop();
          showDialog(
            context: context,
            barrierDismissible: false,
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
                    children: [
                      const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 64,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Funds has been sent',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 24),
                      GradientButton(
                        text: 'Close',
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        });

        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          backgroundColor: const Color(0xFF1E1C47),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text(
                  'Processing...',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _getNetworkIcon(String network) {
    switch (network) {
      case 'BTC':
        return FaIcon(FontAwesomeIcons.bitcoin, color: Colors.orange, size: 16);
      case 'ETH':
        return FaIcon(FontAwesomeIcons.ethereum, color: Colors.blue, size: 16);
      default:
        return FaIcon(FontAwesomeIcons.coins, color: Colors.yellow, size: 16);
    }
  }
}
