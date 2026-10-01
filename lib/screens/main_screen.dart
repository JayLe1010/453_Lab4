import 'package:flutter/material.dart';

import '../mortgage.dart';
import 'modify_screen.dart';

/// Left screen: shows the mortgage data and the computed payments.
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Mortgage _mortgage = Mortgage();
  bool _termsAccepted = false;

  /// Modify button: go to the right screen, passing the current data,
  /// and wait for the updated data when the user presses Done.
  Future<void> _modifyData() async {
    final updated = await Navigator.push<Mortgage>(
      context,
      MaterialPageRoute(
        builder: (context) => ModifyScreen(mortgage: Mortgage.copy(_mortgage)),
      ),
    );
    if (updated != null) {
      setState(() => _mortgage = updated);
    }
  }

  /// Terms and Conditions checkbox: confirm with an AlertDialog.
  Future<void> _onTermsChanged(bool? checked) async {
    if (checked != true) {
      setState(() => _termsAccepted = false);
      return;
    }
    final accepted = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Terms and Conditions'),
        content: const SingleChildScrollView(
          child: Text(
            'The payments shown are estimates only and do not include taxes, '
            'insurance, or other fees. Actual loan terms are subject to '
            'lender approval.\n\nDo you accept the terms and conditions?',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('DECLINE'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('ACCEPT'),
          ),
        ],
      ),
    );
    setState(() => _termsAccepted = accepted ?? false);
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SizedBox(
            width: 150,
            child: Text(label, style: const TextStyle(fontSize: 16)),
          ),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 16))),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MortgageV0'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _row('Amount', _mortgage.formattedAmount),
          _row('Years', '${_mortgage.years}'),
          _row('Interest Rate', _mortgage.formattedRate),
          const Divider(color: Colors.red, thickness: 2),
          _row('Monthly Payment', _mortgage.formattedMonthlyPayment()),
          _row('Total Payment', _mortgage.formattedTotalPayment()),
          CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            controlAffinity: ListTileControlAffinity.leading,
            title: const Text('Terms and Conditions'),
            value: _termsAccepted,
            onChanged: _onTermsChanged,
          ),
          const SizedBox(height: 16),
          Center(
            child: ElevatedButton(
              onPressed: _modifyData,
              child: const Text('MODIFY DATA'),
            ),
          ),
        ],
      ),
    );
  }
}
