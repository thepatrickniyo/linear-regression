import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Performance Prediction',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6366F1),
          brightness: Brightness.light,
        ),
        fontFamily: 'Roboto',
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey.shade50,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF6366F1), width: 2),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _hoursStudiedController = TextEditingController();
  final TextEditingController _previousScoresController =
      TextEditingController();
  final TextEditingController _extracurricularActivitiesController =
      TextEditingController();
  final TextEditingController _sleepHoursController = TextEditingController();
  final TextEditingController _sampleQuestionPapersPracticedController =
      TextEditingController();

  bool _isLoading = false;
  String? _lastPrediction;

  final List<Map<String, dynamic>> _inputFields = [
    {
      'icon': Icons.schedule,
      'label': 'Hours Studied',
      'hint': 'Enter hours per day (1-12)',
      'suffix': 'hrs',
    },
    {
      'icon': Icons.grade,
      'label': 'Previous Scores',
      'hint': 'Enter score (0-100)',
      'suffix': '%',
    },
    {
      'icon': Icons.sports_soccer,
      'label': 'Extracurricular Activities',
      'hint': 'Enter 1 for Yes, 0 for No',
      'suffix': '',
    },
    {
      'icon': Icons.bedtime,
      'label': 'Sleep Hours',
      'hint': 'Enter hours per night (4-12)',
      'suffix': 'hrs',
    },
    {
      'icon': Icons.quiz,
      'label': 'Sample Papers Practiced',
      'hint': 'Enter number of papers (0-10)',
      'suffix': 'papers',
    },
  ];

  List<TextEditingController> get _controllers => [
        _hoursStudiedController,
        _previousScoresController,
        _extracurricularActivitiesController,
        _sleepHoursController,
        _sampleQuestionPapersPracticedController,
      ];

  Future<void> _predictStudentPerformance() async {
    // Validate input fields
    if (_controllers.any((controller) => controller.text.isEmpty)) {
      _showDialog('Error', 'Please fill in all fields before predicting.');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse('https://linear-regression-s8mw.onrender.com/predict'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'HoursStudied': int.parse(_hoursStudiedController.text),
          'PreviousScores': int.parse(_previousScoresController.text),
          'ExtracurricularActivities':
              int.parse(_extracurricularActivitiesController.text),
          'SleepHours': int.parse(_sleepHoursController.text),
          'SampleQuestionPapersPracticed':
              int.parse(_sampleQuestionPapersPracticedController.text),
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final double prediction = responseData['prediction'];
        setState(() {
          _lastPrediction = prediction.toStringAsFixed(2);
        });
        _showPredictionDialog(prediction);
      } else {
        _showDialog('Error', 'Failed to get prediction. Please try again.');
      }
    } catch (e) {
      _showDialog('Error', 'Network error. Please check your connection.');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showPredictionDialog(double prediction) {
    Color scoreColor;
    String performance;
    IconData scoreIcon;

    if (prediction >= 80) {
      scoreColor = Colors.green;
      performance = 'Excellent';
      scoreIcon = Icons.star;
    } else if (prediction >= 60) {
      scoreColor = Colors.orange;
      performance = 'Good';
      scoreIcon = Icons.thumb_up;
    } else {
      scoreColor = Colors.red;
      performance = 'Needs Improvement';
      scoreIcon = Icons.trending_up;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [scoreColor.withOpacity(0.1), Colors.white],
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  scoreIcon,
                  size: 64,
                  color: scoreColor,
                ),
                const SizedBox(height: 16),
                Text(
                  'Prediction Result',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${prediction.toStringAsFixed(1)}%',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: scoreColor,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  performance,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: scoreColor,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Close'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        _clearFields();
                      },
                      child: const Text('New Prediction'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _clearFields() {
    for (var controller in _controllers) {
      controller.clear();
    }
    setState(() {
      _lastPrediction = null;
    });
  }

  void _showDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF6366F1),
              Color(0xFF8B5CF6),
              Color(0xFFA855F7),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header Section
              Container(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
                child: Column(
                  children: [
                    const Icon(
                      Icons.psychology,
                      size: 36,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Student Performance\nPredictor',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            height: 1.1,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'AI-powered academic performance prediction',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.white.withOpacity(0.9),
                          ),
                    ),
                  ],
                ),
              ),

              // Form Section
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 8),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Form Title
                        Text(
                          'Enter Student Information',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade800,
                                  ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Fill in all fields to get an accurate prediction',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Colors.grey.shade600,
                                  ),
                        ),
                        const SizedBox(height: 16),

                        // Input Fields
                        ...List.generate(_inputFields.length, (index) {
                          final field = _inputFields[index];
                          final controller = _controllers[index];

                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      field['icon'],
                                      size: 18,
                                      color: const Color(0xFF6366F1),
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      field['label'],
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.grey.shade700,
                                          ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                TextField(
                                  controller: controller,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: field['hint'],
                                    suffixText: field['suffix'].isEmpty
                                        ? null
                                        : field['suffix'],
                                    prefixIcon: Icon(
                                      field['icon'],
                                      color: Colors.grey.shade400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),

                        const SizedBox(height: 20),

                        // Predict Button
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                            ),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF6366F1).withOpacity(0.3),
                                blurRadius: 12,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            onPressed:
                                _isLoading ? null : _predictStudentPerformance,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: _isLoading
                                ? const SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.analytics,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Predict Performance',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ],
                                  ),
                          ),
                        ),

                        if (_lastPrediction != null) ...[
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade50,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey.shade200),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.history,
                                  color: Color(0xFF6366F1),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Last Prediction',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium
                                            ?.copyWith(
                                              color: Colors.grey.shade600,
                                            ),
                                      ),
                                      Text(
                                        '${_lastPrediction}%',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge
                                            ?.copyWith(
                                              color: const Color(0xFF6366F1),
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  onPressed: _clearFields,
                                  icon: const Icon(Icons.refresh),
                                  color: Colors.grey.shade600,
                                ),
                              ],
                            ),
                          ),
                        ],

                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
