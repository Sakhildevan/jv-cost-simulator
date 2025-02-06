import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:johnsonville_cost_simulator/themes/app_colors.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'tool_tip_arrow_painter.dart';

// A tooltip with text, action buttons, and an arrow pointing to the target.
class AnimatedTooltip extends StatefulWidget {
  final Widget content;
  final GlobalKey? targetGlobalKey;
  final Duration? delay;

  final Widget? child;

  const AnimatedTooltip({
    required this.content,
    super.key,
    this.targetGlobalKey,
    this.delay,
    this.child,
  }) : assert(child != null || targetGlobalKey != null);

  @override
  State<StatefulWidget> createState() => AnimatedTooltipState();
}

class AnimatedTooltipState extends State<AnimatedTooltip>
    with SingleTickerProviderStateMixin {
  late double? _tooltipTop;
  late double? _tooltipBottom;
  late Alignment _tooltipAlignment;
  late Alignment _transitionAlignment;
  late Alignment _arrowAlignment;
  bool _isInverted = false;
  Timer? _delayTimer;

  final Size _arrowSize = const Size(16.0, 16.0);
  final int _tooltipMinimumHeight = 140;

  final OverlayPortalController _overlayController = OverlayPortalController();
  late final AnimationController _animationController = AnimationController(
    duration: const Duration(milliseconds: 200),
    vsync: this,
  );
  late final Animation<double> _scaleAnimation = CurvedAnimation(
    parent: _animationController,
    curve: Curves.easeOutBack,
  );

  Future<void> _toggle() async {
    _delayTimer?.cancel();
    _animationController.stop();
    if (_overlayController.isShowing) {
      _animationController.reverse().then((_) {
        _overlayController.hide();
      });
    } else {
      _updatePosition();
      _overlayController.show();
      _animationController.forward();
    }
  }

  void _updatePosition() {
    final Size contextSize = MediaQuery.of(context).size;
    final BuildContext? targetContext = widget.targetGlobalKey != null
        ? widget.targetGlobalKey!.currentContext
        : context;
    final RenderBox targetRenderBox =
        // ignore: cast_nullable_to_non_nullable
        targetContext?.findRenderObject() as RenderBox;
    final Offset targetOffset = targetRenderBox.localToGlobal(Offset.zero);
    final Size targetSize = targetRenderBox.size;
    // Try to position the tooltip above the target,
    // otherwise try to position it below or in the center of the target.
    final bool tooltipFitsAboveTarget =
        targetOffset.dy - _tooltipMinimumHeight >= 0;
    final bool tooltipFitsBelowTarget =
        targetOffset.dy + targetSize.height + _tooltipMinimumHeight <=
            contextSize.height;
    _tooltipTop = tooltipFitsAboveTarget
        ? null
        : tooltipFitsBelowTarget
            ? targetOffset.dy + targetSize.height
            : null;
    _tooltipBottom = tooltipFitsAboveTarget
        ? contextSize.height - targetOffset.dy
        : tooltipFitsBelowTarget
            ? null
            : targetOffset.dy + targetSize.height / 2;
    // If the tooltip is below the target, invert the arrow.
    _isInverted = _tooltipTop != null;
    // Align the tooltip horizontally relative to the target.
    _tooltipAlignment = Alignment(
      (targetOffset.dx) / (contextSize.width - targetSize.width) * 2 - 1.0,
      _isInverted ? 1.0 : -1.0,
    );
    // Make the tooltip appear from the target.
    _transitionAlignment = Alignment(
      (targetOffset.dx + targetSize.width / 2) / contextSize.width * 2 - 1.0,
      _isInverted ? -1.0 : 1.0,
    );
    // Center the arrow horizontally on the target.
    _arrowAlignment = Alignment(
      (targetOffset.dx + targetSize.width / 2) /
              (contextSize.width - _arrowSize.width) *
              2 -
          1.0,
      _isInverted ? 1.0 : -1.0,
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // If the tooltip is delayed, start a timer to show it.
      if (widget.delay != null) {
        _delayTimer = Timer(widget.delay!, _toggle);
      }
    });
  }

  @override
  void dispose() {
    _delayTimer?.cancel();
    //commented for future
    // _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OverlayPortal.targetsRootOverlay(
      controller: _overlayController,
      child: widget.child != null
          ? ResponsiveBuilder(
              builder: (
                BuildContext context,
                SizingInformation sizingInformation,
              ) {
                if (sizingInformation.deviceScreenType ==
                    DeviceScreenType.desktop) {
                  return MouseRegion(
                    onEnter: (PointerEnterEvent event) async {
                      _toggle();
                    },
                    onExit: (PointerExitEvent event) async {
                      if (_overlayController.isShowing) {
                        _animationController.reverse().then((_) {
                          _overlayController.hide();
                        });
                      }
                    },
                    child: widget.child,
                  );
                } else {
                  return TapRegion(
                    child: widget.child,
                    onTapInside: (
                      PointerDownEvent event,
                    ) async {
                      _toggle();
                    },
                    onTapOutside: (
                      PointerDownEvent event,
                    ) async {
                      if (_overlayController.isShowing) {
                        _animationController.reverse().then((_) {
                          _overlayController.hide();
                        });
                      }
                    },
                  );
                }
              },
            )
          : null,
      overlayChildBuilder: (BuildContext context) {
        return Positioned(
          top: _tooltipTop,
          bottom: _tooltipBottom,
          // Provide a transition alignment
          // to make the tooltip appear from the target.
          child: ScaleTransition(
            alignment: _transitionAlignment,
            scale: _scaleAnimation,
            // TapRegion allows the tooltip
            //to be dismissed by tapping outside of it.
            child: ResponsiveBuilder(
              builder: (
                BuildContext context,
                SizingInformation sizingInformation,
              ) {
                if (sizingInformation.deviceScreenType ==
                    DeviceScreenType.desktop) {
                  return onHoverToolTipMethod(context);
                } else {
                  return onTapToolTipMethod(context);
                }
              },
            ),
          ),
        );
      },
    );
  }

//!------(on Hover tool tip managing method)
// when the device is mobile and tablet
  MouseRegion onHoverToolTipMethod(BuildContext context) {
    return MouseRegion(
      onEnter: (PointerEnterEvent event) async {
        _toggle();
      },
      onExit: (PointerExitEvent event) async {
        if (_overlayController.isShowing) {
          _animationController.reverse().then((_) {
            _overlayController.hide();
          });
        }
      },
      child: toolTipBody(context),
    );
  }

//!------(on Hover tool tip managing method)
// when the device is mobile and tablet
  TapRegion onTapToolTipMethod(BuildContext context) {
    return TapRegion(
      onTapInside: (PointerDownEvent event) async {
        _toggle();
      },
      onTapOutside: (PointerDownEvent event) async {
        if (_overlayController.isShowing) {
          _animationController.reverse().then((_) {
            _overlayController.hide();
          });
        }
      },
      child: toolTipBody(context),
    );
  }

//!---------(tool tip body)
  SizedBox toolTipBody(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (_isInverted)
            //!-----(tool tip arrow)
            Align(
              alignment: _arrowAlignment,
              child: TooltipArrow(
                size: _arrowSize,
                isInverted: true,
                color: AppColors.white,
                // color: theme.canvasColor,
              ),
            ),
          //!-----(tool tip content)
          Align(
            alignment: _tooltipAlignment,
            child: IntrinsicWidth(
              child: Material(
                elevation: 4.0,
                color: AppColors.white,
                borderRadius: BorderRadius.circular(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      //!content
                      widget.content,
                    ],
                  ),
                ),
              ),
            ),
          ),
          //!-----(tool tip arrow)
          if (!_isInverted)
            Align(
              alignment: _arrowAlignment,
              child: TooltipArrow(
                size: _arrowSize,
                isInverted: false,
                color: Colors.white,
              ),
            ),
        ],
      ),
    );
  }
}
