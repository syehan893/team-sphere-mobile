import 'package:flutter/material.dart';

class AnimatedListView extends StatefulWidget {
  final List<Widget> children;

  const AnimatedListView({super.key, required this.children});

  @override
  AnimatedListViewState createState() => AnimatedListViewState();
}

class AnimatedListViewState extends State<AnimatedListView> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_listKey.currentState != null) {
        for (var i = 0; i < widget.children.length; i++) {
          _listKey.currentState?.insertItem(
            i,
            duration: Duration(milliseconds: 100 + i * 50),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      key: _listKey,
      initialItemCount: widget.children.length,
      itemBuilder: (context, index, animation) {
        if (index >= widget.children.length) {
          return const SizedBox.shrink();
        }

        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.0, 0.5),
            end: Offset.zero,
          ).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.easeOut,
            ),
          ),
          child: FadeTransition(
            opacity: animation,
            child: widget.children[index],
          ),
        );
      },
    );
  }
}
