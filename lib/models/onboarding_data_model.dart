class OnboardingData {
  late String highlight;
  late String description;
  late String imagePath;
  late String stagePath;
  late String buttunText;
  OnboardingData();
  OnboardingData.getData(Map<String, dynamic> data) {
    this.highlight = data['highlight'];
    this.description = data['description'];
    this.imagePath = data['imagePath'];
    this.stagePath = data['stagePath'];
    this.buttunText = data['buttunText'];
  }
}
