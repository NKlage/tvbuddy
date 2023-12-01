/// Provides a general exception to capture app specific errors
class ApplicationException implements Exception {
  /// Standard constructor
  ///
  /// The [message] must be specified. [description]
  /// optionally accepts a more detailed error description. [isFatal]
  /// specifies whether it is a fatal exception, the default value is false.
  /// [isFatal] can be used in analysis services to record a fatal error.
  ApplicationException({
    required this.message,
    this.description,
    this.isFatal = false,
  });

  /// Exception message
  final String message;

  /// Detailed description of the exception
  final String? description;

  /// Indicates whether this is a fatal exception. Is useful for analysis
  /// services.
  final bool isFatal;

  @override
  String toString() {
    return 'ApplicationException{message: $message, description: $description, '
        'isFatal: $isFatal}';
  }
}
