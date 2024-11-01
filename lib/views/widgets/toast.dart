import 'package:flutter/material.dart';
import 'package:team_sphere_mobile/views/widgets/typography.dart';

class CustomToast {
  static void showToast(BuildContext context, String message, Color color,
      {Duration duration = const Duration(seconds: 1)}) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 50,
        left: MediaQuery.of(context).size.width * 0.1,
        width: MediaQuery.of(context).size.width * 0.8,
        child: Material(
          color: Colors.transparent,
          child: FadeInToast(
            message: message,
            duration: duration,
            color: color,
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(duration, () {
      overlayEntry.remove();
    });
  }
}

class FadeInToast extends StatefulWidget {
  final String message;
  final Duration duration;
  final Color color;

  const FadeInToast({
    super.key,
    required this.message,
    required this.duration,
    required this.color,
  });

  @override
  FadeInToastState createState() => FadeInToastState();
}

class FadeInToastState extends State<FadeInToast>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
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
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Body1.regular(
          widget.message,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
