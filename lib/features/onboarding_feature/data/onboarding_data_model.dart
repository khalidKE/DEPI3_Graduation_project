class OnboardingData {
  final String highlight;
  final String description;
  final String imagePath;
  final String stagePath;
  final String buttonText;

  const OnboardingData({
    required this.highlight,
    required this.description,
    required this.imagePath,
    required this.stagePath,
    required this.buttonText,
  });

  factory OnboardingData.empty() => const OnboardingData(
        highlight: '',
        description: '',
        imagePath: '',
        stagePath: '',
        buttonText: '',
      );

  factory OnboardingData.fromMap(Map<String, dynamic> data) {
    return OnboardingData(
      highlight: data['highlight'] as String? ?? '',
      description: data['description'] as String? ?? '',
      imagePath: data['imagePath'] as String? ?? '',
      stagePath: data['stagePath'] as String? ?? '',
      buttonText: data['buttonText'] as String? ??
          data['buttunText'] as String? ?? // backward compatibility
          '',
    );
  }

  OnboardingData copyWith({
    String? highlight,
    String? description,
    String? imagePath,
    String? stagePath,
    String? buttonText,
  }) {
    return OnboardingData(
      highlight: highlight ?? this.highlight,
      description: description ?? this.description,
      imagePath: imagePath ?? this.imagePath,
      stagePath: stagePath ?? this.stagePath,
      buttonText: buttonText ?? this.buttonText,
    );
  }
}
