class PostSimulationProgressRequest {
  int currentStep;

  PostSimulationProgressRequest({
    required this.currentStep,
  });

  Map<String, dynamic> toJson() {
    return {
      'currentStep': currentStep,
    };
  }
}
