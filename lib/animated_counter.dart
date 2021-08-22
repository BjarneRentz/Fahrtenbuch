import 'package:flutter/material.dart';

class AnimatedCounter extends StatefulWidget {
  AnimatedCounter(this.value, {Key? key}) : super(key: key) {
    print('Animated Counter' + value.toString());
  }

  final double value;

  @override
  _AnimatedCounterState createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<AnimatedCounter> with TickerProviderStateMixin{
  late final AnimationController _animationController;
  late final Animation<double> _animation;

  @override
  Widget build(BuildContext context) {
    return Text(
      _animation.value.toStringAsFixed(1),
      style: Theme.of(context).textTheme.headline2,
    );
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    _animation = Tween<double>(begin: 0, end: widget.value).animate(_animationController)
    ..addListener(() { 
      setState(() {
        
      });
    });

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
