import 'package:flutter/material.dart';
import 'package:stripe_example/screens/payment_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Stripe',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        hintColor: Colors.grey.shade400, colorScheme: const ColorScheme.light(
          primary: Color(0xff625AFA),
        ).copyWith(background: Colors.white),
      ),
      home: const PaymentScreen(),
    );
  }
}
