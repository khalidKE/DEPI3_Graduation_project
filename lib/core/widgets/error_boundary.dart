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
  VoidCallback? _postFrameCallback;

  @override
  void initState() {
    super.initState();
    _setupErrorHandling();
  }

  void _setupErrorHandling() {
    _originalErrorHandler = FlutterError.onError;
    
    FlutterError.onError = (FlutterErrorDetails details) async {
      // Call original handler first
      _originalErrorHandler?.call(details);
      
      if (kDebugMode) {
        FlutterError.presentError(details);
      }
      
      // Cancel any pending frame callbacks
      _postFrameCallback?.call();
      
      // Use post-frame callback to avoid calling setState during build
      _postFrameCallback = () {
        if (mounted) {
          setState(() {
            _hasError = true;
            _errorDetails = details;
          });
        }
      };
      
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _postFrameCallback?.call();
      });
    };
  }
  
  void _handleError(dynamic error, StackTrace stackTrace) {
    FlutterError.reportError(
      FlutterErrorDetails(
        exception: error,
        stack: stackTrace,
        library: 'ErrorBoundary',
        context: ErrorDescription('inside _ErrorBoundaryState'),
      ),
    );
  }

  @override
  void dispose() {
    // Cancel any pending frame callbacks
    _postFrameCallback?.call();
    
    // Restore original error handler
    FlutterError.onError = _originalErrorHandler;
    
    super.dispose();
  }
  
  @override
  void reassemble() {
    super.reassemble();
    // Reset error state on hot reload
    if (_hasError) {
      setState(() {
        _hasError = false;
        _errorDetails = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return widget.fallback ??
          CustomErrorWidget(
            _errorDetails?.exception ?? 'An error occurred',
            stackTrace: _errorDetails?.stack,
            onRetry: _handleRetry,
          );
    }
    
    // Use Builder to catch errors during build
    return Builder(
      builder: (context) {
        try {
          return widget.child;
        } catch (error, stackTrace) {
          _handleError(error, stackTrace);
          return widget.fallback ?? 
              CustomErrorWidget(
                error,
                stackTrace: stackTrace,
                onRetry: _handleRetry,
              );
        }
      },
    );
  }
  
  void _handleRetry() {
    if (mounted) {
      setState(() {
        _hasError = false;
        _errorDetails = null;
      });
    }
  }
}

/// Error widget to display errors
class CustomErrorWidget extends StatelessWidget {
  final Object? error;
  final StackTrace? stackTrace;
  final VoidCallback? onRetry;

  const CustomErrorWidget(
    this.error, {
    super.key,
    this.stackTrace,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    // Get the current text direction or default to LTR
    final textDirection = Directionality.maybeOf(context) ?? TextDirection.ltr;
    
    return Directionality(
      textDirection: textDirection,
      child: Scaffold(
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
              const SizedBox(height: 16),
              if (onRetry != null) ...[
                ElevatedButton(
                  onPressed: onRetry,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Retry'),
                ),
                const SizedBox(height: 8),
              ],
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[200],
                  foregroundColor: Colors.black87,
                ),
                child: const Text('Go Back'),
              ),
                ],
              ),
            ),
          ),
        ),
      );
  }
}

