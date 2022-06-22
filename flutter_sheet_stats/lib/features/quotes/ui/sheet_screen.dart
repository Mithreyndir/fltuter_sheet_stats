import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sheet_stats/features/quotes/bloc/sheet_bloc.dart';
import 'package:flutter_sheet_stats/features/quotes/bloc/sheet_event.dart';
import 'package:flutter_sheet_stats/features/quotes/bloc/sheet_state.dart';
import 'package:flutter_sheet_stats/features/quotes/repository/sheet_repository.dart';
import 'package:flutter_sheet_stats/features/quotes/ui/widgets/sheet_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:json_diff/json_diff.dart';

class SheetScreen extends StatelessWidget {
  const SheetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var test;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Sheet data'),
        centerTitle: true,
      ),
      body: BlocProvider<SheetBloc>(
        create: (context) =>
            SheetBloc(RepositoryProvider.of<SheetRepository>(context))
              ..add(
                LoadSheetEvent(),
              ),
        child: Center(
          child: Padding(
              padding: const EdgeInsets.all(20),
              child:
                  BlocBuilder<SheetBloc, QuoteState>(builder: (context, state) {
                if (state is SheetErrorState) {
                  return Center(
                    child: Column(
                      children: [
                        Text(
                          state.message,
                          style: const TextStyle(fontSize: 16, color: Colors.red),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            context.read<SheetBloc>().add(LoadSheetEvent());
                          },
                          child: const Text('Refresh'),
                          style: ElevatedButton.styleFrom(primary: Colors.black),
                        )
                      ],
                    ),
                  );
                } else if (state is SheetLoadedState) {
                  test ??= state.model;
                  return SheetWidget(
                    model: state.model,
                    oldModel: test,
                    onPressed: () {
                      context.read<SheetBloc>().add(LoadSheetEvent());
                      test = state.model;
                    },
                  );
                }
                return const CircularProgressIndicator();
              })),
        ),
      ),
    );
  }

  setRows(var json) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('rows', jsonEncode(json));
  }

  getRows() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('rows') != null) {
      Map test = jsonDecode(prefs.getString('rows')!);
      print(test.toString());
    }
    return {};
  }

}


