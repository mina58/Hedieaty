import 'package:flutter/material.dart';

class AsyncListView extends StatelessWidget {
  const AsyncListView({
    super.key,
    required this.future,
    required this.builder,
    this.errorMessage = "An error occurred while loading the list",
    this.noDataMessage = "No data was found",
  });

  final Future<List<dynamic>> future;
  final Widget Function(dynamic item) builder;
  final String errorMessage;
  final String noDataMessage;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text(errorMessage),
              );
            } else if (snapshot.hasData) {
              return ListView(
                children: snapshot.data!.map((item) => builder(item)).toList(),
              );
            } else {
              return Center(
                child: Text(noDataMessage),
              );
            }
          } else {
            return Center(
              child: Text(errorMessage),
            );
          }
        });
  }
}
