import 'package:flutter/material.dart';

/// A customizable dual slider widget that allows sliding between negative and positive values.
///
/// The slider extends from [-maxValue] to [maxValue], with 0 at the center.
class DualSlider extends StatefulWidget {
  /// Creates a dual slider.
  ///
  /// The [maxValue] must be at least 1.
  const DualSlider({
    super.key,
    this.maxValue = 100.0,
    this.initialValue = 0.0,
    this.trackColors,
    this.trackGradient,
    this.thumbColor = Colors.blue,
    this.thumbIcon = Icons.swap_horiz,
    this.thumbBorderColor = Colors.white,
    this.trackHeight = 36.0,
    this.trackBorderRadius,
    this.thumbSize,
    this.divisions,
    this.showTickMarks = false,
    this.activeTickMarkColor,
    this.inactiveTickMarkColor,
    this.onChanged,
    this.onChangeStart,
    this.onChangeEnd,
  }) : assert(maxValue >= 1.0, 'maxValue must be at least 1.0');

  /// The maximum value for both directions. The slider will range from -maxValue to +maxValue.
  ///
  /// Defaults to 100.0. Must be at least 1.0.
  final double maxValue;

  /// The initial value of the slider.
  ///
  /// Defaults to 0.0 (center position).
  final double initialValue;

  /// Colors for the track gradient. If provided, creates a gradient from left to right.
  ///
  /// If both [trackColors] and [trackGradient] are null, defaults to [Colors.blue, Colors.green].
  /// If [trackColors] has only one color, the track will be solid color.
  final List<Color>? trackColors;

  /// Custom gradient for the track. If provided, this overrides [trackColors].
  final Gradient? trackGradient;

  /// The color of the thumb (handle).
  ///
  /// Defaults to [Colors.blue].
  final Color thumbColor;

  /// The icon to display on the thumb.
  ///
  /// Defaults to [Icons.swap_horiz].
  final IconData thumbIcon;

  /// The color of the thumb border.
  ///
  /// Defaults to [Colors.white].
  final Color thumbBorderColor;

  /// The height of the slider track.
  ///
  /// Defaults to 36.0.
  final double trackHeight;

  /// The border radius of the track.
  ///
  /// If null, defaults to a fully rounded shape (trackHeight / 2).
  /// 
  /// Examples:
  /// - `BorderRadius.circular(10)` - All corners with 10px radius
  /// - `BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))` - Top corners rounded
  /// - `BorderRadius.zero` - Sharp rectangular corners
  /// 
  /// Defaults to null (fully rounded).
  final BorderRadius? trackBorderRadius;

  /// The diameter (size) of the thumb circle.
  ///
  /// If null, it will be automatically calculated based on trackHeight
  /// to maintain good proportions (trackHeight * 1.2).
  /// 
  /// If provided, the value will be clamped between:
  /// - Minimum: trackHeight * 0.8 (to prevent invisible thumbs)
  /// - Maximum: trackHeight * 2.4 (to prevent oversized thumbs)
  /// 
  /// Note: This is the diameter (full width), not the radius.
  /// 
  /// Defaults to null (auto-calculated).
  final double? thumbSize;

  /// The number of discrete divisions on the slider track.
  ///
  /// If null, defaults to `maxValue * 2`, creating divisions for integer values.
  /// For example, with maxValue=100, you get 200 divisions (steps of 1.0).
  /// 
  /// Set to a smaller number for larger steps:
  /// - divisions = 10 with maxValue=100 → steps of 20 (values: -100, -80, -60, ..., 0, ..., 100)
  /// - divisions = 4 with maxValue=10 → steps of 5 (values: -10, -5, 0, 5, 10)
  /// 
  /// For completely smooth (continuous) movement without snapping,
  /// set a very high value like `maxValue * 100`.
  final int? divisions;

  /// Whether to show tick marks on the track at each division point.
  ///
  /// If true, small circular marks will be drawn at each division point.
  /// Only visible when [divisions] is set.
  /// 
  /// The size is automatically calculated by Flutter for optimal appearance.
  ///
  /// Defaults to false.
  final bool showTickMarks;

  /// The color of tick marks on the active side (left of the thumb).
  ///
  /// If null, defaults to white with 50% opacity.
  /// Only used when [showTickMarks] is true.
  /// 
  /// For dual sliders, this typically represents the negative/left side.
  final Color? activeTickMarkColor;

  /// The color of tick marks on the inactive side (right of the thumb).
  ///
  /// If null, uses [activeTickMarkColor] or defaults to white with 50% opacity.
  /// Only used when [showTickMarks] is true.
  /// 
  /// For dual sliders, this typically represents the positive/right side.
  /// Set this to a different color than [activeTickMarkColor] to visually
  /// distinguish between negative and positive sides.
  final Color? inactiveTickMarkColor;

  /// Called when the user is selecting a new value by dragging.
  ///
  /// The slider passes the new value to the callback but does not actually
  /// change state until the parent widget rebuilds the slider with the new value.
  final ValueChanged<double>? onChanged;

  /// Called when the user starts selecting a new value by dragging.
  final ValueChanged<double>? onChangeStart;

  /// Called when the user is done selecting a new value by dragging.
  final ValueChanged<double>? onChangeEnd;

  @override
  State<DualSlider> createState() => _DualSliderState();
}

class _DualSliderState extends State<DualSlider> {
  late double _sliderValue;

  @override
  void initState() {
    super.initState();
    _sliderValue = widget.initialValue.clamp(-widget.maxValue, widget.maxValue);
  }

  @override
  void didUpdateWidget(DualSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.maxValue != widget.maxValue) {
      _sliderValue = _sliderValue.clamp(-widget.maxValue, widget.maxValue);
    }
  }

  int get displayValue => _sliderValue.round();
  bool get isLeft => _sliderValue < 0;
  bool get isRight => _sliderValue > 0;
  bool get isCenter => _sliderValue == 0;

  void _setSliderValue(double value) {
    setState(() {
      _sliderValue = value.clamp(-widget.maxValue, widget.maxValue);
    });
    widget.onChanged?.call(_sliderValue);
  }

  void _handleChangeStart(double value) {
    widget.onChangeStart?.call(value);
  }

  void _handleChangeEnd(double value) {
    widget.onChangeEnd?.call(value);
  }

  @override
  Widget build(BuildContext context) {
    // Calculate thumb size based on track height if not provided
    // User provides diameter (size), we convert to radius internally
    final double autoThumbSize = widget.trackHeight * 1.2; // Default: 120% of track height
    final double minThumbSize = widget.trackHeight * 0.8; // Minimum: 80% of track height
    final double maxThumbSize = widget.trackHeight * 2.4; // Maximum: 240% of track height
    
    final double effectiveThumbSize = widget.thumbSize != null
        ? widget.thumbSize!.clamp(minThumbSize, maxThumbSize)
        : autoThumbSize;
    
    // Convert diameter to radius for internal use
    final double effectiveThumbRadius = effectiveThumbSize / 2;
    
    // Calculate tick mark colors
    final Color defaultTickMarkColor = Colors.white.withValues(alpha: 0.5);
    final Color effectiveActiveTickMarkColor = 
        widget.activeTickMarkColor ?? defaultTickMarkColor;
    final Color effectiveInactiveTickMarkColor = 
        widget.inactiveTickMarkColor ?? widget.activeTickMarkColor ?? defaultTickMarkColor;
    
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: Colors.transparent, // Gradient in custom track shape
        inactiveTrackColor:
            Colors.transparent, // Gradient in custom track shape
        trackHeight: widget.trackHeight,
        thumbColor: widget.thumbColor,
        thumbShape: CustomSliderThumbShape(
          enabledThumbRadius: effectiveThumbRadius,
          icon: widget.thumbIcon,
          borderColor: widget.thumbBorderColor,
        ),
        overlayColor: Colors.transparent,
        trackShape: CustomSliderTrackShape(
          gradient: widget.trackGradient,
          colors: widget.trackColors,
          borderRadius: widget.trackBorderRadius,
        ),
        // Tick marks configuration - use default shape for automatic sizing
        activeTickMarkColor: widget.showTickMarks ? effectiveActiveTickMarkColor : Colors.transparent,
        inactiveTickMarkColor: widget.showTickMarks ? effectiveInactiveTickMarkColor : Colors.transparent,
      ),
      child: Slider(
        padding: EdgeInsets.zero,
        value: _sliderValue,
        min: -widget.maxValue,
        max: widget.maxValue,
        divisions: widget.divisions ?? (widget.maxValue * 2).round(),
        onChanged: (value) {
          _setSliderValue(value);
        },
        onChangeStart: _handleChangeStart,
        onChangeEnd: _handleChangeEnd,
      ),
    );
  }
}

// Custom Slider Thumb Shape - displays an icon on the thumb
class CustomSliderThumbShape extends SliderComponentShape {
  final double enabledThumbRadius;
  final IconData icon;
  final Color borderColor;

  const CustomSliderThumbShape({
    required this.enabledThumbRadius,
    required this.icon,
    required this.borderColor,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(enabledThumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    // Thumb circle
    final paint = Paint()
      ..color = sliderTheme.thumbColor!
      ..style = PaintingStyle.fill;

    // Thumb border
    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    canvas.drawCircle(center, enabledThumbRadius, paint);
    canvas.drawCircle(center, enabledThumbRadius, borderPaint);

    // Draw icon on thumb
    final iconPainter = TextPainter(
      text: TextSpan(
        text: String.fromCharCode(icon.codePoint),
        style: TextStyle(
          fontFamily: icon.fontFamily,
          fontSize:
              enabledThumbRadius * 1.125, // Icon size relative to thumb size
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: textDirection,
    );
    iconPainter.layout();

    final iconCenter = Offset(
      center.dx - iconPainter.width / 2,
      center.dy - iconPainter.height / 2,
    );

    iconPainter.paint(canvas, iconCenter);
  }
}

// Custom Track Shape - supports gradient and solid colors
class CustomSliderTrackShape extends RoundedRectSliderTrackShape {
  final Gradient? gradient;
  final List<Color>? colors;
  final BorderRadius? borderRadius;

  const CustomSliderTrackShape({
    this.gradient,
    this.colors,
    this.borderRadius,
  });

  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight ?? 4.0;
    final double trackLeft = offset.dx;
    final double trackTop = offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required TextDirection textDirection,
    required Offset thumbCenter,
    Offset? secondaryOffset,
    bool isDiscrete = false,
    bool isEnabled = true,
    double additionalActiveTrackHeight = 2,
  }) {
    final trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );

    final Canvas canvas = context.canvas;
    final trackHeight = sliderTheme.trackHeight ?? 4.0;
    
    // Calculate vertical center position for the track
    final double trackTop = offset.dy + (parentBox.size.height - trackHeight) / 2;

    // Use custom border radius or default to fully rounded
    final effectiveBorderRadius = borderRadius ?? 
        BorderRadius.circular(trackHeight / 2);

    final trackRect2 = Rect.fromLTWH(
      trackRect.left,
      trackTop,
      trackRect.width,
      trackHeight,
    );

    final trackRRect = RRect.fromRectAndCorners(
      trackRect2,
      topLeft: effectiveBorderRadius.topLeft,
      topRight: effectiveBorderRadius.topRight,
      bottomLeft: effectiveBorderRadius.bottomLeft,
      bottomRight: effectiveBorderRadius.bottomRight,
    );

    final Paint paint;

    // Determine which paint to use based on provided parameters
    final shaderRect = Rect.fromLTWH(
      trackRect.left,
      trackTop,
      trackRect.width,
      trackHeight,
    );
    
    if (gradient != null) {
      // Use custom gradient if provided
      paint = Paint()
        ..shader = gradient!.createShader(shaderRect)
        ..style = PaintingStyle.fill;
    } else if (colors != null && colors!.isNotEmpty) {
      // Use colors list
      if (colors!.length == 1) {
        // Single color - solid fill
        paint = Paint()
          ..color = colors![0]
          ..style = PaintingStyle.fill;
      } else {
        // Multiple colors - create gradient
        paint = Paint()
          ..shader = LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: colors!,
          ).createShader(shaderRect)
          ..style = PaintingStyle.fill;
      }
    } else {
      // Default gradient (blue to green)
      paint = Paint()
        ..shader = const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Colors.blue, Colors.green],
        ).createShader(shaderRect)
        ..style = PaintingStyle.fill;
    }

    canvas.drawRRect(trackRRect, paint);
  }
}
