# Contributing to Dual Slider

Thank you for your interest in contributing to dual_slider! We welcome contributions from everyone. 🎉

## 📋 Table of Contents

- [Code of Conduct](#code-of-conduct)
- [How Can I Contribute?](#how-can-i-contribute)
- [Development Setup](#development-setup)
- [Pull Request Process](#pull-request-process)
- [Coding Guidelines](#coding-guidelines)
- [Commit Messages](#commit-messages)
- [Testing](#testing)
- [Documentation](#documentation)

## 📜 Code of Conduct

This project and everyone participating in it is governed by respect and professionalism. Please be kind and constructive in your interactions.

## 🤝 How Can I Contribute?

### Reporting Bugs

Before creating bug reports, please check existing issues. When creating a bug report, include:

- **Clear title** and description
- **Steps to reproduce** the issue
- **Expected behavior** vs actual behavior
- **Screenshots** if applicable
- **Environment details** (Flutter version, platform, device)
- **Code sample** demonstrating the issue

### Suggesting Enhancements

Enhancement suggestions are tracked as GitHub issues. When creating an enhancement suggestion, include:

- **Clear title** and detailed description
- **Use cases** - why is this enhancement useful?
- **Possible implementation** ideas (optional)
- **Examples** from other packages (optional)

### Pull Requests

We actively welcome your pull requests! Here's what we're looking for:

- **Bug fixes**
- **Feature implementations** (check [TODO.md](TODO.md) for planned features)
- **Documentation improvements**
- **Test coverage improvements**
- **Performance optimizations**
- **Code quality improvements**

## 🛠️ Development Setup

### Prerequisites

- Flutter SDK: `>=1.17.0`
- Dart SDK: `^3.9.2`
- Git

### Setup Steps

1. **Fork the repository** on GitHub

2. **Clone your fork**:
```bash
git clone https://github.com/YOUR_USERNAME/dual_slider.git
cd dual_slider
```

3. **Add upstream remote**:
```bash
git remote add upstream https://github.com/ctnmstf/dual_slider.git
```

4. **Install dependencies**:
```bash
flutter pub get
cd example && flutter pub get
```

5. **Verify installation**:
```bash
flutter test
flutter analyze
```

### Running the Example

```bash
cd example
flutter run -d chrome  # or any other device
```

## 🔄 Pull Request Process

### 1. Create a Branch

```bash
git checkout -b feature/my-new-feature
# or
git checkout -b fix/bug-description
```

Branch naming convention:
- `feature/` - New features
- `fix/` - Bug fixes
- `docs/` - Documentation changes
- `test/` - Test improvements
- `refactor/` - Code refactoring

### 2. Make Your Changes

- Write clean, readable code
- Follow [Coding Guidelines](#coding-guidelines)
- Add tests for new features
- Update documentation as needed

### 3. Test Your Changes

```bash
# Run tests
flutter test

# Check for linter errors
flutter analyze

# Format code
dart format .

# Run example app on multiple platforms
cd example
flutter run -d chrome
flutter run -d macos
flutter run -d android
```

### 4. Commit Your Changes

Follow [Commit Messages](#commit-messages) guidelines:

```bash
git add .
git commit -m "feat: add center indicator feature"
```

### 5. Sync with Upstream

```bash
git fetch upstream
git rebase upstream/main
```

### 6. Push to Your Fork

```bash
git push origin feature/my-new-feature
```

### 7. Create Pull Request

- Go to your fork on GitHub
- Click "New Pull Request"
- Provide clear title and description
- Reference related issues (e.g., "Fixes #123")
- Wait for review

### 8. Code Review

- Address review comments promptly
- Push additional commits to your branch
- Once approved, your PR will be merged!

## 📝 Coding Guidelines

### Dart Style

- Follow [Effective Dart](https://dart.dev/guides/language/effective-dart) guidelines
- Use `dart format` to format code
- Pass `flutter analyze` with no errors

### Code Quality

```dart
// ✅ Good: Clear, documented, typed
/// Returns the effective thumb radius based on track height.
/// 
/// If [thumbSize] is null, calculates as trackHeight * 1.2.
/// Otherwise clamps between min (80%) and max (240%) of track height.
double calculateThumbRadius(double trackHeight, double? thumbSize) {
  if (thumbSize == null) {
    return trackHeight * 1.2;
  }
  return thumbSize.clamp(trackHeight * 0.8, trackHeight * 2.4);
}

// ❌ Bad: Unclear, no docs, no types
var calc(a, b) {
  return b == null ? a * 1.2 : b.clamp(a * 0.8, a * 2.4);
}
```

### Widget Guidelines

- Keep widgets focused and composable
- Use `const` constructors when possible
- Provide sensible defaults
- Add comprehensive documentation
- Include usage examples in doc comments

### File Organization

```
lib/
├── dual_slider.dart          # Main export file
└── src/                       # Internal implementation (if needed)
    ├── slider.dart
    ├── thumb_shape.dart
    └── track_shape.dart
```

## 💬 Commit Messages

We follow [Conventional Commits](https://www.conventionalcommits.org/):

### Format

```
<type>(<scope>): <subject>

<body>

<footer>
```

### Types

- `feat:` - New feature
- `fix:` - Bug fix
- `docs:` - Documentation changes
- `style:` - Code style changes (formatting, etc.)
- `refactor:` - Code refactoring
- `test:` - Adding or updating tests
- `chore:` - Maintenance tasks

### Examples

```bash
feat: add haptic feedback support

Add enableHapticFeedback parameter that triggers vibration
when slider crosses division points.

Closes #42

---

fix: thumb not centering on tall tracks

Calculate vertical center position correctly for all track heights.

Fixes #38

---

docs: update README with new examples

Add examples for haptic feedback and center indicator features.
```

## 🧪 Testing

### Writing Tests

All new features should include tests:

```dart
testWidgets('DualSlider with haptic feedback', (WidgetTester tester) async {
  bool feedbackTriggered = false;
  
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: DualSlider(
          enableHapticFeedback: true,
          onChanged: (value) {
            feedbackTriggered = true;
          },
        ),
      ),
    ),
  );
  
  expect(find.byType(DualSlider), findsOneWidget);
  // ... more assertions
});
```

### Running Tests

```bash
# All tests
flutter test

# Specific test file
flutter test test/dual_slider_test.dart

# With coverage
flutter test --coverage
```

## 📚 Documentation

### Code Documentation

Use triple-slash comments for public APIs:

```dart
/// A dual-direction slider widget.
///
/// This widget extends from [-maxValue] to [+maxValue] with 0 at center.
///
/// Example:
/// ```dart
/// DualSlider(
///   maxValue: 50,
///   onChanged: (value) => print('Value: $value'),
/// )
/// ```
class DualSlider extends StatefulWidget {
  // ...
}
```

### README Updates

If your change affects usage:
- Update code examples
- Add screenshots if UI changed
- Update parameter documentation table
- Add to CHANGELOG.md

## 🎯 Feature Checklist

Before submitting a feature PR, ensure:

- [ ] Code follows style guidelines
- [ ] Tests added and passing
- [ ] Documentation updated
- [ ] Example app demonstrates feature
- [ ] CHANGELOG.md updated
- [ ] No breaking changes (or clearly documented)
- [ ] Backward compatible
- [ ] Works on all supported platforms

## ❓ Questions?

- **General questions**: Open a [Discussion](https://github.com/ctnmstf/dual_slider/discussions)
- **Bug reports**: Open an [Issue](https://github.com/ctnmstf/dual_slider/issues)
- **Feature requests**: Open an [Issue](https://github.com/ctnmstf/dual_slider/issues)

## 📄 License

By contributing, you agree that your contributions will be licensed under the MIT License.

---

Thank you for contributing! 🙏

