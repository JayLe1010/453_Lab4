import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mortgage_app/main.dart';
import 'package:mortgage_app/mortgage.dart';

void main() {
  test('Mortgage default values match the lab sample', () {
    final m = Mortgage();
    expect(m.formattedAmount, '\$100,000.00');
    expect(m.formattedMonthlyPayment(), '\$449.04');
    // The Java sample shows $161,654.66 due to float rounding; doubles give:
    expect(m.formattedTotalPayment(), '\$161,656.09');
  });

  testWidgets('Modify data and return with Done', (tester) async {
    await tester.pumpWidget(const MortgageApp());
    expect(find.text('\$449.04'), findsOneWidget);

    await tester.tap(find.text('MODIFY DATA'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('15'));
    await tester.enterText(find.byType(TextField), '200000');
    await tester.tap(find.text('2.25%'));
    await tester.pump();
    await tester.tap(find.text('DONE'));
    await tester.pumpAndSettle();

    expect(find.text('\$200,000.00'), findsOneWidget);
    expect(find.text('15'), findsOneWidget);
    expect(find.text('2.25%'), findsOneWidget);
  });

  testWidgets('Terms checkbox asks for confirmation', (tester) async {
    await tester.pumpWidget(const MortgageApp());
    await tester.tap(find.byType(Checkbox));
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsOneWidget);

    await tester.tap(find.text('ACCEPT'));
    await tester.pumpAndSettle();
    final box = tester.widget<Checkbox>(find.byType(Checkbox));
    expect(box.value, isTrue);
  });
}
