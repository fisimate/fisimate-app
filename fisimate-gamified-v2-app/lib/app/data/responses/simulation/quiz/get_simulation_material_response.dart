class GetSimulationMaterialResponse {
  final bool success;
  final String message;
  final SimulationMaterial data;

  GetSimulationMaterialResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory GetSimulationMaterialResponse.fromJson(Map<String, dynamic> json) {
    return GetSimulationMaterialResponse(
      success: json['success'],
      message: json['message'],
      data: SimulationMaterial.fromJson(json['data']),
    );
  }
}

class SimulationMaterial {
  final String id;
  final String? filePath;
  final String simulationId;
  final DateTime createdAt;
  final DateTime updatedAt;

  SimulationMaterial({
    required this.id,
    required this.filePath,
    required this.simulationId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SimulationMaterial.fromJson(Map<String, dynamic> json) {
    return SimulationMaterial(
      id: json['id'],
      filePath: json['filePath'],
      simulationId: json['simulationId'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}