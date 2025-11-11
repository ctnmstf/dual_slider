import 'package:flutter/material.dart';
import 'package:dual_slider/dual_slider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dual Slider Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const DualSliderDemo(),
    );
  }
}

class DualSliderDemo extends StatefulWidget {
  const DualSliderDemo({super.key});

  @override
  State<DualSliderDemo> createState() => _DualSliderDemoState();
}

class _DualSliderDemoState extends State<DualSliderDemo> {
  double _basicValue = 0.0;
  double _solidValue = 0.0;
  double _gradientValue = 0.0;
  double _tickMarksValue = 0.0;
  double _customShapeValue = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Dual Slider Demo'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Basic Example
            _buildExample(
              title: 'Basic Usage',
              description: 'Default gradient slider with standard options',
              value: _basicValue,
              child: DualSlider(
                onChanged: (value) => setState(() => _basicValue = value),
              ),
            ),

            // Solid Color
            _buildExample(
              title: 'Solid Color',
              description: 'Single color track, custom icon and size',
              value: _solidValue,
              child: DualSlider(
                trackColors: const [Colors.orange],
                thumbColor: Colors.deepOrange,
                thumbIcon: Icons.horizontal_rule,
                trackHeight: 40.0,
                onChanged: (value) => setState(() => _solidValue = value),
              ),
            ),

            // Multi-color Gradient
            _buildExample(
              title: 'Multi-Color Gradient',
              description: 'Custom 3-color gradient with custom range',
              value: _gradientValue,
              child: DualSlider(
                maxValue: 50,
                trackColors: const [Colors.red, Colors.yellow, Colors.green],
                thumbColor: Colors.indigo,
                thumbIcon: Icons.compare_arrows,
                onChanged: (value) => setState(() => _gradientValue = value),
              ),
            ),

            // Tick Marks
            _buildExample(
              title: 'With Tick Marks',
              description: 'Divisions with colored tick marks',
              value: _tickMarksValue,
              child: DualSlider(
                maxValue: 10,
                divisions: 4,
                showTickMarks: true,
                activeTickMarkColor: Colors.red.withValues(alpha: 0.8),
                inactiveTickMarkColor: Colors.green.withValues(alpha: 0.8),
                trackColors: const [Colors.purple, Colors.amber],
                thumbColor: Colors.purple,
                onChanged: (value) => setState(() => _tickMarksValue = value),
              ),
            ),

            // Custom Shape
            _buildExample(
              title: 'Custom Border Radius',
              description: 'Sharp corners for modern design',
              value: _customShapeValue,
              child: DualSlider(
                trackBorderRadius: BorderRadius.circular(8),
                trackColors: const [Colors.blueGrey, Colors.lightBlue],
                thumbColor: Colors.blueGrey,
                thumbIcon: Icons.settings_ethernet,
                trackHeight: 35.0,
                onChanged: (value) => setState(() => _customShapeValue = value),
              ),
            ),

            const SizedBox(height: 32),

            // Features List
            _buildFeaturesList(),
          ],
        ),
      ),
    );
  }

  Widget _buildExample({
    required String title,
    required String description,
    required double value,
    required Widget child,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: TextStyle(fontSize: 13, color: Colors.grey[600]),
            ),
            const SizedBox(height: 16),
            child,
            const SizedBox(height: 12),
            Center(
              child: Text(
                'Value: ${value.toStringAsFixed(1)}',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.blue[700],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturesList() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.star, color: Colors.blue[700], size: 20),
              const SizedBox(width: 8),
              Text(
                'Key Features',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[700],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildFeatureItem('Dual direction slider (-max to +max)'),
          _buildFeatureItem('Customizable colors and gradients'),
          _buildFeatureItem('Adjustable track and thumb sizes'),
          _buildFeatureItem('Tick marks with custom colors'),
          _buildFeatureItem('Custom border radius options'),
          _buildFeatureItem('Icon customization for thumb'),
          _buildFeatureItem('Division support for discrete values'),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Icon(Icons.check_circle, size: 16, color: Colors.blue[700]),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 13, color: Colors.grey[800]),
            ),
          ),
        ],
      ),
    );
  }
}
