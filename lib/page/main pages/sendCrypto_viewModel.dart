import 'package:bittrack_frontend/services/api_service.dart';
import 'package:bittrack_frontend/services/dialog_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SendCryptoScreenViewModel extends StatefulWidget {
  @override
  _SendCryptoScreen createState() => _SendCryptoScreen();
}

class _SendCryptoScreen extends State<SendCryptoScreenViewModel> {
  final _apiService = ApiService();
  final _dialogService = DialogService();

  TextEditingController _addressController = TextEditingController();
  TextEditingController _amountController = TextEditingController();
  String _selectedNetwork = 'BTC';
  int _trustScore = 0;

  final List<String> addressSuggestions = [
    '1A1zP1eP5QGefi2DMPTfTL5SLmv7DivfNa',
    '3J98t1WpEZ73CNmQviecrnyiWrnqRhWNLy',
    'bc1qar0srrr7xfkvy5l643lydnw9re59gtzzwfuk8h',
  ];

  // @override
  // void initState() {
  //   super.initState();
  //   // Fetch the trust score when the screen is initialized
  //   _apiService.fetchTrustScore().then((score) {
  //     setState(() {
  //       _trustScore = score;
  //     });
  //   });
  // }

  void _showConfirmDialog(BuildContext context, String address, int trustScore,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF14123A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF14123A),
        elevation: 0,
        title: const Text('Send Crypto',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFF26225C),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Address',
                      style: TextStyle(
                          color: Colors.white70, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    Autocomplete<String>(
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        if (textEditingValue.text.isEmpty) {
                          return const Iterable<String>.empty();
                        }
                        return addressSuggestions.where((String option) {
                          return option.contains(textEditingValue.text);
                        });
                      },
                      fieldViewBuilder: (BuildContext context,
                          TextEditingController textEditingController,
                          FocusNode focusNode,
                          VoidCallback onFieldSubmitted) {
                        return TextField(
                          controller: textEditingController,
                          focusNode: focusNode,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFF19173D),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.all(12.0),
                            hintText: 'Enter address',
                            hintStyle: const TextStyle(color: Colors.grey),
                          ),
                          style: const TextStyle(color: Colors.white),
                        );
                      },
                      onSelected: (String selection) {
                        setState(() {
                          _addressController.text = selection;
                          _trustScore =
                              0; // Reset trust score to show loading indicator
                        });
                        _apiService.fetchTrustScore().then((score) {
                          setState(() {
                            _trustScore = score;
                          });
                        });
                      },
                      optionsViewBuilder: (BuildContext context,
                          AutocompleteOnSelected<String> onSelected,
                          Iterable<String> options) {
                        return Align(
                          alignment: Alignment.topLeft,
                          child: Material(
                            color: const Color(0xFF19173D),
                            child: Container(
                              width: MediaQuery.of(context).size.width - 48,
                              child: ListView.builder(
                                padding: const EdgeInsets.all(8.0),
                                itemCount: options.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final String option =
                                      options.elementAt(index);
                                  return GestureDetector(
                                    onTap: () {
                                      onSelected(option);
                                    },
                                    child: ListTile(
                                      title: Text(option,
                                          style: const TextStyle(
                                              color: Colors.white)),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          'Trust Score: ',
                          style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.bold),
                        ),
                        if (_trustScore == 0)
                          const Center(
                            child: SizedBox(
                              height: 25.0,
                              width: 25.0,
                              child: CircularProgressIndicator(
                                strokeWidth: 3,
                              ),
                            ),
                          )
                        else
                          Row(
                            children: [
                              Text(
                                '$_trustScore',
                                style: TextStyle(
                                    color: _trustScore >= 50
                                        ? Colors.green
                                        : Colors.red,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(width: 4),
                              Icon(
                                _trustScore >= 50
                                    ? Icons.check_circle
                                    : Icons.cancel,
                                color: _trustScore >= 50
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            ],
                          ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      'Network',
                      style: TextStyle(
                          color: Colors.white70, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 4.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFF19173D),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: _selectedNetwork,
                          dropdownColor: const Color(0xFF19173D),
                          icon: const Icon(Icons.arrow_drop_down,
                              color: Colors.white),
                          items:
                              <String>['BTC', 'ETH', 'LTC'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Row(
                                children: [
                                  FaIcon(
                                    value == 'BTC'
                                        ? FontAwesomeIcons.bitcoin
                                        : value == 'ETH'
                                            ? FontAwesomeIcons.ethereum
                                            : FontAwesomeIcons.coins,
                                    color: Colors.orange,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    value,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedNetwork = newValue!;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      'Amount',
                      style: TextStyle(
                          color: Colors.white70, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF19173D),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _amountController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: const Color(0xFF19173D),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.all(12.0),
                                hintText: '1000',
                                hintStyle: const TextStyle(color: Colors.grey),
                              ),
                              style: const TextStyle(color: Colors.white),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(right: 12.0),
                            child: Text(
                              'Satoshi',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Center(
                      child: GradientButton(
                        text: 'Send',
                        onPressed: () {
                          _dialogService.showConfirmDialog(
                            context,
                            _addressController.text,
                            _trustScore,
                            _selectedNetwork,
                            _amountController.text,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const GradientButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF00C6FB), Color(0xFF005BEA)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
