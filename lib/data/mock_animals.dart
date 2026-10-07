import '../models/animal.dart';

/// Dados mockados em memória. Quando o Firestore estiver conectado,
/// isso é substituído por um stream de `animalsCollection.snapshots()`.
final List<Animal> mockAnimals = [
  const Animal(
    id: '1',
    name: 'Thor',
    breed: 'Vira-lata',
    age: '2 anos',
    city: 'Campinas/SP',
    species: Species.dog,
    healthBadge: 'Vacinado',
    emoji: '🐕',
    description:
        'Thor é brincalhão e adora correr no quintal. Já é castrado e vacinado, '
        'e se dá bem com crianças e outros cães.',
  ),
  const Animal(
    id: '2',
    name: 'Mia',
    breed: 'SRD',
    age: '8 meses',
    city: 'Campinas/SP',
    species: Species.cat,
    healthBadge: 'Castrada',
    emoji: '🐈',
    description:
        'Mia é carinhosa e gosta de dormir no sol. Convive bem com outros gatos '
        'e já está com todas as vacinas em dia.',
  ),
  const Animal(
    id: '3',
    name: 'Luna',
    breed: 'Poodle',
    age: '3 anos',
    city: 'Limeira/SP',
    species: Species.dog,
    healthBadge: 'Vacinada',
    emoji: '🐩',
    description:
        'Luna é calma, ótima para apartamento, e já sabe alguns comandos básicos '
        'como sentar e dar a pata.',
  ),
  const Animal(
    id: '4',
    name: 'Salém',
    breed: 'SRD',
    age: '1 ano',
    city: 'Americana/SP',
    species: Species.cat,
    healthBadge: 'Castrado',
    emoji: '🐈‍⬛',
    description:
        'Salém é independente mas adora um carinho à noite. Prefere uma casa '
        'tranquila, sem muitas visitas.',
  ),
  const Animal(
    id: '5',
    name: 'Bento',
    breed: 'Labrador',
    age: '4 anos',
    city: 'Piracicaba/SP',
    species: Species.dog,
    healthBadge: 'Vacinado',
    emoji: '🐕‍🦺',
    description:
        'Bento é super dócil, ótimo com crianças, e adora um passeio longo '
        'todos os dias.',
  ),
];
