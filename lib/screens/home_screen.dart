import 'package:flutter/material.dart';
import '../data/mock_animals.dart';
import '../models/animal.dart';
import '../utils/app_colors.dart';
import '../state/auth_state.dart';
import '../widgets/animal_card.dart';
import '../widgets/animal_details_sheet.dart';
import 'login_screen.dart';

enum _FilterOption { todos, caes, gatos, filhotes }

/// TELA 1 DE 5 · PÚBLICA · SEM LOGIN
/// Tela inicial: acessível sem autenticação, mostra o catálogo de animais.
/// O login só é disparado ao tocar no coração (favoritar) ou nos itens
/// "Favoritos"/"Perfil" da navegação inferior (ver MainShell).
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  _FilterOption _filter = _FilterOption.todos;
  final Set<String> _favoriteIds = {};

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Animal> get _filteredAnimals {
    final query = _searchController.text.trim().toLowerCase();
    return mockAnimals.where((a) {
      final matchesFilter = switch (_filter) {
        _FilterOption.todos => true,
        _FilterOption.caes => a.species == Species.dog,
        _FilterOption.gatos => a.species == Species.cat,
        _FilterOption.filhotes => a.age.contains('meses'),
      };
      final matchesQuery = query.isEmpty ||
          a.name.toLowerCase().contains(query) ||
          a.breed.toLowerCase().contains(query) ||
          a.city.toLowerCase().contains(query);
      return matchesFilter && matchesQuery;
    }).toList();
  }

  Future<void> _handleFavoriteTap(Animal animal) async {
    if (!AuthState.instance.isLoggedIn) {
      final loggedIn = await Navigator.of(context).push<bool>(
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
      if (loggedIn != true) return;
    }
    if (!mounted) return;
    setState(() {
      if (_favoriteIds.contains(animal.id)) {
        _favoriteIds.remove(animal.id);
      } else {
        _favoriteIds.add(animal.id);
      }
    });
    final isFav = _favoriteIds.contains(animal.id);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isFav
              ? '${animal.name} adicionado aos favoritos ❤️'
              : '${animal.name} removido dos favoritos',
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

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
    final animals = _filteredAnimals;

    return SafeArea(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 18),
            color: AppColors.primary,
            child: const Column(
              children: [
                Text(
                  'AdoPet 🐾',
                  style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 2),
                Text(
                  'Adote com responsabilidade',
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                TextField(
                  controller: _searchController,
                  onChanged: (_) => setState(() {}),
                  decoration: InputDecoration(
                    hintText: 'Buscar por nome, raça, cidade...',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: const BorderSide(color: AppColors.cardBorder),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 36,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _FilterChip(
                        label: 'Todos',
                        selected: _filter == _FilterOption.todos,
                        onTap: () => setState(() => _filter = _FilterOption.todos),
                      ),
                      _FilterChip(
                        label: 'Cães',
                        selected: _filter == _FilterOption.caes,
                        onTap: () => setState(() => _filter = _FilterOption.caes),
                      ),
                      _FilterChip(
                        label: 'Gatos',
                        selected: _filter == _FilterOption.gatos,
                        onTap: () => setState(() => _filter = _FilterOption.gatos),
                      ),
                      _FilterChip(
                        label: 'Filhotes',
                        selected: _filter == _FilterOption.filhotes,
                        onTap: () => setState(() => _filter = _FilterOption.filhotes),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                if (animals.isEmpty)
                  const Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: Center(child: Text('Nenhum animal encontrado.')),
                  )
                else
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: animals.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 0.78,
                    ),
                    itemBuilder: (context, index) {
                      final animal = animals[index];
                      return AnimalCard(
                        animal: animal,
                        isFavorite: _favoriteIds.contains(animal.id),
                        onTap: () => _openDetails(animal),
                        onFavoriteTap: () => _handleFavoriteTap(animal),
                      );
                    },
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _FilterChip({required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => onTap(),
        selectedColor: AppColors.primary,
        labelStyle: TextStyle(
          color: selected ? Colors.white : AppColors.primary,
          fontWeight: FontWeight.w600,
        ),
        backgroundColor: Colors.white,
        shape: const StadiumBorder(side: BorderSide(color: AppColors.primary)),
      ),
    );
  }
}
