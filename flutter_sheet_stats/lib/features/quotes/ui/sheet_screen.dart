import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sheet_stats/features/quotes/bloc/sheet_bloc.dart';
import 'package:flutter_sheet_stats/features/quotes/bloc/sheet_event.dart';
import 'package:flutter_sheet_stats/features/quotes/bloc/sheet_state.dart';
import 'package:flutter_sheet_stats/features/quotes/repository/sheet_repository.dart';
import 'package:flutter_sheet_stats/features/quotes/ui/widgets/sheet_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SheetScreen extends StatelessWidget {
  const SheetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var oldModel;

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
                          style:
                              const TextStyle(fontSize: 16, color: Colors.red),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            context.read<SheetBloc>().add(LoadSheetEvent());
                          },
                          child: const Text('Refresh'),
                          style:
                              ElevatedButton.styleFrom(primary: Colors.black),
                        )
                      ],
                    ),
                  );
                } else if (state is SheetLoadedState) {
                  oldModel ??= state.model;
                  //print(state.model.toJson().toString());
                  return SheetWidget(
                    model: state.model,
                    oldModel: oldModel,
                    onPressed: () {
                      context.read<SheetBloc>().add(LoadSheetEvent());
                      oldModel = state.model;
                    },
                  );
                }
                return const CircularProgressIndicator();
              })),
        ),
      ),
    );
  }
}
