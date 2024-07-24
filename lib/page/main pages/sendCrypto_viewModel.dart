import 'package:bittrack_frontend/dummy%20data/address.dummy.dart';
import 'package:bittrack_frontend/services/api_service.dart';
import 'package:bittrack_frontend/services/dialog_service.dart';
import 'package:bittrack_frontend/ui/gradient.button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SendCryptoScreenViewModel extends StatefulWidget {
  final String? initialAddress;

  SendCryptoScreenViewModel({this.initialAddress});

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

  @override
  void initState() {
    super.initState();
    if (widget.initialAddress != null) {
      _addressController = TextEditingController(text: widget.initialAddress);
      _apiService.fetchTrustScore().then((score) {
        setState(() {
          _trustScore = score;
        });
      });
    }
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
                        return address_dummy.where((String option) {
                          return option.contains(textEditingValue.text);
                        });
                      },
                      fieldViewBuilder: (BuildContext context,
                          TextEditingController textEditingController,
                          FocusNode focusNode,
                          VoidCallback onFieldSubmitted) {
                        textEditingController.text = _addressController.text;
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
