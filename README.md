# Lab 4 – Mortgage Calculator (Flutter)

A two-screen mortgage calculator.

- **Main screen** shows Amount, Years, Interest Rate, Monthly Payment and Total
  Payment, plus a **Terms and Conditions** checkbox. Checking it opens an
  `AlertDialog` that asks the user to accept the terms.
- **MODIFY DATA** opens the second screen and passes it the current data.
- **Modify screen** has radio buttons for the number of years (10 / 15 / 30), a
  text field for the amount, and a `ListView` of interest rates from 2% to 15%
  in 0.25% steps.
- **DONE** returns the updated data to the main screen, which recalculates the
  payments.

## Files

- `lib/mortgage.dart` – the `Mortgage` model class (Dart port of the lab's Mortgage class)
- `lib/main.dart` – app entry point
- `lib/screens/main_screen.dart` – main screen (left)
- `lib/screens/modify_screen.dart` – modify screen (right)
- `test/widget_test.dart` – unit and widget tests

## Run

```sh
flutter pub get
flutter run
flutter test
```
