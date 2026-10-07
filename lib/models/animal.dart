enum Species { dog, cat }

/// Modelo de um animal disponível para adoção.
/// `emoji` é um placeholder visual no lugar da foto real (que viria do
/// Firebase Storage quando o backend estiver conectado).
class Animal {
  final String id;
  final String name;
  final String breed;
  final String age;
  final String city;
  final Species species;
  final String healthBadge;
  final String emoji;
  final String description;

  const Animal({
    required this.id,
    required this.name,
    required this.breed,
    required this.age,
    required this.city,
    required this.species,
    required this.healthBadge,
    required this.emoji,
    this.description = '',
  });
}
