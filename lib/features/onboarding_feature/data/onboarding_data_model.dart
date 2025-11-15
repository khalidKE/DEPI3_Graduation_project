class OnboardingData {
  String highlight = '';
  String description = '';
  String imagePath = '';
  String stagePath = '';
  String buttunText = '';
  
  OnboardingData();
  
  OnboardingData.getData(Map<String, dynamic> data) {
    highlight = data['highlight'] ?? '';
    description = data['description'] ?? '';
    imagePath = data['imagePath'] ?? '';
    stagePath = data['stagePath'] ?? '';
    buttunText = data['buttunText'] ?? '';
  }
}
