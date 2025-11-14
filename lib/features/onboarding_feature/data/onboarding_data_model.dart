class OnboardingData {
  late String highlight;
  late String description;
  late String imagePath;
  late String stagePath;
  late String buttunText;
  OnboardingData();
  OnboardingData.getData(Map<String, dynamic> data) {
    highlight = data['highlight'];
    description = data['description'];
    imagePath = data['imagePath'];
    stagePath = data['stagePath'];
    buttunText = data['buttunText'];
  }
}
