import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

/// Error boundary widget to catch and display errors gracefully
class ErrorBoundary extends StatefulWidget {
  final Widget child;
  final Widget? fallback;

  const ErrorBoundary({
    super.key,
    required this.child,
    this.fallback,
  });

  @override
  State<ErrorBoundary> createState() => _ErrorBoundaryState();
}

class _ErrorBoundaryState extends State<ErrorBoundary> {
  bool _hasError = false;
  FlutterErrorDetails? _errorDetails;
  FlutterExceptionHandler? _originalErrorHandler;

  @override
  void initState() {
    super.initState();
    // Store the original error handler
    _originalErrorHandler = FlutterError.onError;
    
    // Set up custom error handler
    FlutterError.onError = (FlutterErrorDetails details) {
      // Call original handler first
      _originalErrorHandler?.call(details);
      
      if (kDebugMode) {
        FlutterError.presentError(details);
      }
      
      // Use post-frame callback to avoid calling setState during build
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() {
            _hasError = true;
            _errorDetails = details;
          });
        }
      });
    };
  }

  @override
  void dispose() {
    // Restore original error handler
    FlutterError.onError = _originalErrorHandler;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return widget.fallback ??
          CustomErrorWidget(
            _errorDetails?.exception ?? 'An error occurred',
            stackTrace: _errorDetails?.stack,
          );
    }
    
    // Use Builder to catch errors during build
    return Builder(
      builder: (context) {
        return widget.child;
      },
    );
  }
}

/// Error widget to display errors
class CustomErrorWidget extends StatelessWidget {
  final Object? error;
  final StackTrace? stackTrace;

  const CustomErrorWidget(
    this.error, {
    super.key,
    this.stackTrace,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red,
              ),
              const SizedBox(height: 16),
              const Text(
                'Something went wrong',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                error?.toString() ?? 'Unknown error',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  // Try to recover or restart the app
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                child: const Text('Go Back'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

