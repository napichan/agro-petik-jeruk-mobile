import '../../domain/entities/chat_recommendation.dart';

/// Representasi data rekomendasi jeruk dari sumber data.
class RecommendationModel {
  const RecommendationModel({
    required this.id,
    required this.name,
    required this.sector,
    required this.grade,
    required this.pricePerKg,
    required this.brix,
    required this.readyPercent,
    required this.description,
    required this.emoji,
  });

  final String id;
  final String name;
  final String sector;
  final String grade;
  final int pricePerKg;
  final double brix;
  final int readyPercent;
  final String description;
  final String emoji;

  ChatRecommendation toEntity() {
    return ChatRecommendation(
      id: id,
      name: name,
      sector: sector,
      grade: grade,
      pricePerKg: pricePerKg,
      brix: brix,
      readyPercent: readyPercent,
      description: description,
      emoji: emoji,
    );
  }
}
