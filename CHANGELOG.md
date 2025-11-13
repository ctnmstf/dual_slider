# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.0.1+1] - 2025-11-13

### Fixed
- Shortened package description to meet pub.dev recommendations (60-180 characters)
- Applied Dart formatter to all files for consistency

## [0.0.1] - 2025-11-11

### 🎉 Initial Release

First public release of dual_slider package!

### ✨ Features

#### Core Functionality
- **Dual-direction slider** widget with customizable range (-maxValue to +maxValue)
- **Flexible value range** with configurable maxValue (minimum 1.0)
- **Initial value** support for setting starting position
- **Smooth animations** using Flutter's native Slider widget

#### Customization
- **Track colors**:
  - Single color support for solid tracks
  - Multi-color gradient support (2+ colors)
  - Custom gradient support for advanced designs
  - Default blue-green gradient
  
- **Thumb customization**:
  - Customizable thumb color
  - Icon support (any Material Icon)
  - Border color customization
  - Auto-sized thumb based on track height
  - Manual thumb size with smart limits (80% - 240% of track height)

- **Track styling**:
  - Adjustable track height
  - Custom border radius support
  - Per-corner radius customization (BorderRadius.only)
  - Fully rounded, slightly rounded, or sharp corners
  - Full-width track (no padding)

#### Advanced Features
- **Divisions** for discrete value snapping
- **Tick marks** with show/hide option
- **Dual-color tick marks**:
  - activeTickMarkColor for left/negative side
  - inactiveTickMarkColor for right/positive side
  - Auto-sized tick marks by Flutter

#### Callbacks
- `onChanged` - Called during value changes
- `onChangeStart` - Called when dragging starts
- `onChangeEnd` - Called when dragging ends

### 📱 Platform Support

- ✅ Android
- ✅ iOS
- ✅ Web
- ✅ macOS
- ✅ Windows
- ✅ Linux

### 📦 Package Info

- Minimum Dart SDK: ^3.9.2
- Minimum Flutter: >=1.17.0
- Pure Dart implementation (no native code)
- Zero external dependencies (only flutter SDK)

### 📚 Documentation

- Comprehensive README with examples
- 5 usage examples in demo app
- Full API documentation
- Design tips and use cases
- Screenshots and visual guide

### 🧪 Testing

- Widget tests included
- Basic rendering tests
- Custom color tests
- Tick marks tests

---

## Upcoming Features

See [TODO.md](TODO.md) for planned features in future releases:
- Center indicator for zero point
- Haptic feedback on divisions
- Value labels/tooltips
- Enhanced accessibility support

[0.0.1]: https://github.com/ctnmstf/dual_slider/releases/tag/v0.0.1
