// Copyright 2020 zuvola. All rights reserved.

// ignore_for_file: prefer_final_fields

/// Flutter widget that swaps children with each other with slide animation.
library flutter_slide_swap;

import 'package:flutter/material.dart';

/// Controller for [SlideSwap].
class SlideController extends ChangeNotifier {
  List<Widget>? _children;
  AnimationController? _animationController;

  /// The order of the children
  get order => _order;
  List<int> _order;

  /// Creates an object that manages the state required by [SlideSwap].
  /// The [length] must [SlideSwap.children]'s length.
  SlideController({@required int? length})
      : _order = List<int>.generate(length!, (int index) => index);

  /// Swaps the order of the children using the two indexes.
  Future<void> swapOrder(int a, int b) async {
    if (_animationController == null) return;
    if (a == b) return;
    int tmp = _order[a];
    _order[a] = _order[b];
    _order[b] = tmp;
    notifyListeners();
    try {
      _animationController!.reset();
      await _animationController!.forward().orCancel;
    } on TickerCanceled {
      debugPrint("ERROR : Swap Order -> Ticker Canceled");
    }
  }

  /// Use two keys to swap the order of the children.
  Future<void> swapWithKey(Key k1, Key k2) async {
    if (_children == null) return;
    var idx1 = _children!.indexWhere((item) => item.key == k1);
    var idx2 = _children!.indexWhere((item) => item.key == k2);
    var a = _order.indexWhere((item) => item == idx1);
    var b = _order.indexWhere((item) => item == idx2);
    await swapOrder(a, b);
  }

  /// Swap the widget linked to key for index location
  Future<void> swapOrderWithKey(Key key, int index) async {
    if (_children == null) return;
    var idx = _children!.indexWhere((item) => item.key == key);
    var a = _order.indexWhere((item) => item == idx);
    await swapOrder(a, index);
  }
}

/// SlideSwap
///
/// {@tool sample}
///
/// This example shows a simple [SlideSwap].
///
/// ```dart
/// var _controller = SlideController(length: 4);
/// SlideSwap(
///   controller: _controller,
///   children: <Widget>[
///     RaisedButton(
///       key: keyA,
///       onPressed: () {
///         _controller.swapOrder(0, 1);
///       },
///       child: Text('A'),
///     ),
///     RaisedButton(
///       key: keyB,
///       onPressed: () {
///         _controller.swapWithKey(keyA, keyB);
///       },
///       child: Text('B'),
///     ),
///   ],
/// )
/// ```
/// {@end-tool}
///
class SlideSwap extends StatefulWidget {
  /// Creates a SlideSwap widget.
  ///
  /// The [children] argument must not be null.
  const SlideSwap({
    Key? key,
    @required this.children,
    @required this.controller,
  }) : super(key: key);

  /// The widgets below this widget in the tree.
  final List<Widget>? children;

  /// Controller for this widget.
  final SlideController? controller;

  @override
  SlideSwapState createState() => SlideSwapState();
}

/// State for a [SlideSwap].
///
/// Can change the display order of children.
class SlideSwapState extends State<SlideSwap>
    with SingleTickerProviderStateMixin {
  _SlideSwapFlowDelegate? _delegate;
  AnimationController? _animationController;
  CurvedAnimation? _animation;
  SlideController? _controller;

  void _didChangeControllerValue() async {
    setState(() {});
  }

  void _initController() {
    _controller = widget.controller;
    _controller!._children = widget.children!;
    _controller!._animationController = _animationController!;
    _controller!.addListener(_didChangeControllerValue);
  }

  @override
  void initState() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation =
        CurvedAnimation(parent: _animationController!, curve: Curves.easeInOut);
    _delegate = _SlideSwapFlowDelegate(slideAnimation: _animation!);
    _initController();
    super.initState();
  }

  @override
  void didUpdateWidget(SlideSwap oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller!.removeListener(_didChangeControllerValue);
      _initController();
    }
  }

  @override
  void dispose() {
    _animationController!.dispose();
    _controller!.removeListener(_didChangeControllerValue);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _delegate!.order = _controller!.order;
    return Flow(
      delegate: _delegate!,
      children: widget.children!,
    );
  }
}

/// Delegate for a [Flow].
class _SlideSwapFlowDelegate extends FlowDelegate {
  final Animation<double>? slideAnimation;

  List<int>? _order;
  List<int>? _oldOrder;

  get order => _order;

  set order(value) {
    if (_order != null) {
      _oldOrder = List.from(_order!);
    } else {
      _oldOrder = List.from(value);
    }
    _order = List.from(value);
  }

  _SlideSwapFlowDelegate({this.slideAnimation})
      : super(repaint: slideAnimation);

  @override
  void paintChildren(FlowPaintingContext context) {
    double y = 0.0, y1 = 0.0, y2 = 0.0;
    var pos1 = List.filled(context.childCount, 0.0);
    var pos2 = List.filled(context.childCount, 0.0);
    for (var i = 0; i < context.childCount; i++) {
      var idx1 = _oldOrder![i];
      var idx2 = _order![i];
      pos1[idx1] = y1;
      pos2[idx2] = y2;
      y1 += context.getChildSize(idx1)!.height;
      y2 += context.getChildSize(idx2)!.height;
    }
    for (var i = 0; i < context.childCount; i++) {
      var dy = pos2[i] - pos1[i];
      y = pos1[i] + dy * slideAnimation!.value;
      context.paintChild(
        i,
        transform: Matrix4.translationValues(0, y, 0),
      );
    }
  }

  @override
  bool shouldRepaint(_SlideSwapFlowDelegate oldDelegate) {
    return true;
  }

  @override
  BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
    return constraints.copyWith(minHeight: 0);
  }
}
