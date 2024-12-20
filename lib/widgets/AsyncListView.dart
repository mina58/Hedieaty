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
    return FutureBuilder<List<dynamic>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else if (snapshot.hasData) {
            final items = snapshot.data!;
            if (items.isEmpty) {
              return Center(
                child: Text(noDataMessage),
              );
            }
            return AnimatedListView(
              items: items,
              builder: builder,
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
      },
    );
  }
}

class AnimatedListView extends StatefulWidget {
  const AnimatedListView({
    super.key,
    required this.items,
    required this.builder,
  });

  final List<dynamic> items;
  final Widget Function(dynamic item) builder;

  @override
  _AnimatedListViewState createState() => _AnimatedListViewState();
}

class _AnimatedListViewState extends State<AnimatedListView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.items.length,
      itemBuilder: (context, index) {
        final animation = Tween<Offset>(
          begin: const Offset(0, 1), // Start from the bottom
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.easeOut,
          ),
        );

        return SlideTransition(
          position: animation,
          child: widget.builder(widget.items[index]),
        );
      },
    );
  }
}
