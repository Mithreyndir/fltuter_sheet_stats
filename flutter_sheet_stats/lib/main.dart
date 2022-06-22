import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sheet_stats/features/quotes/repository/sheet_repository.dart';
import 'package:flutter_sheet_stats/features/quotes/ui/sheet_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => SheetRepository(),
      child: const MaterialApp(
        home: SheetScreen(),
      ),
    );
  }
}

