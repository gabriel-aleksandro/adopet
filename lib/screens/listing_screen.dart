import 'package:flutter/material.dart';
import '../data/mock_animals.dart';
import '../models/animal.dart';
import '../utils/app_colors.dart';
import '../widgets/animal_details_sheet.dart';

/// TELA 4 DE 5 · LISTAGEM DE DADOS DO SISTEMA
/// Lista completa dos animais cadastrados, organizada por espécie.
/// Satisfaz o requisito de "Mostrando Dados" via ListView.builder.
class ListingScreen extends StatefulWidget {
  const ListingScreen({super.key});

  @override
  State<ListingScreen> createState() => _ListingScreenState();
}

class _ListingScreenState extends State<ListingScreen> {
  Species _species = Species.dog;
  int _visibleCount = 3;

  List<Animal> get _animalsOfSpecies =>
      mockAnimals.where((a) => a.species == _species).toList();

  void _openDetails(Animal animal) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => AnimalDetailsSheet(animal: animal),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dogsCount = mockAnimals.where((a) => a.species == Species.dog).length;
    final catsCount = mockAnimals.where((a) => a.species == Species.cat).length;
    final animals = _animalsOfSpecies;
    final visibleAnimals = animals.take(_visibleCount).toList();
    final hasMore = visibleAnimals.length < animals.length;

    return SafeArea(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 18),
            color: AppColors.primary,
            child: Column(
              children: [
                const Text(
                  'Todos os animais',
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${mockAnimals.length} disponíveis para adoção',
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: ChoiceChip(
                    label: Text('Cães ($dogsCount)'),
                    selected: _species == Species.dog,
                    onSelected: (_) => setState(() {
                      _species = Species.dog;
                      _visibleCount = 3;
                    }),
                    selectedColor: AppColors.primary,
                    labelStyle: TextStyle(
                      color: _species == Species.dog ? Colors.white : AppColors.primary,
                    ),
                    backgroundColor: Colors.white,
                    shape: const StadiumBorder(side: BorderSide(color: AppColors.primary)),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ChoiceChip(
                    label: Text('Gatos ($catsCount)'),
                    selected: _species == Species.cat,
                    onSelected: (_) => setState(() {
                      _species = Species.cat;
                      _visibleCount = 3;
                    }),
                    selectedColor: AppColors.primary,
                    labelStyle: TextStyle(
                      color: _species == Species.cat ? Colors.white : AppColors.primary,
                    ),
                    backgroundColor: Colors.white,
                    shape: const StadiumBorder(side: BorderSide(color: AppColors.primary)),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: visibleAnimals.length + (hasMore ? 1 : 0),
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                if (index == visibleAnimals.length) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: OutlinedButton(
                      onPressed: () => setState(() => _visibleCount += 3),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size.fromHeight(44),
                        side: const BorderSide(color: AppColors.cardBorder),
                      ),
                      child: const Text(
                        'Carregar mais ▾',
                        style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                }
                final animal = visibleAnimals[index];
                return InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () => _openDetails(animal),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.cardBorder),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Container(
                          width: 46,
                          height: 46,
                          decoration: BoxDecoration(
                            color: AppColors.photoBg,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          alignment: Alignment.center,
                          child: Text(animal.emoji, style: const TextStyle(fontSize: 20)),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${animal.name} · ${animal.breed}',
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                              ),
                              Text(
                                '${animal.age} · ${animal.city}',
                                style: const TextStyle(fontSize: 11, color: AppColors.grayText),
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.chevron_right, color: AppColors.grayText),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
