import 'package:flutter/material.dart';
import '../models/animal.dart';
import '../utils/app_colors.dart';
import '../state/auth_state.dart';
import '../screens/login_screen.dart';
import '../screens/interest_form_screen.dart';

/// BottomSheet com detalhes do animal, aberto tanto pela Tela Inicial
/// quanto pela Tela de Listagem ao tocar em um card/linha.
/// Satisfaz o requisito de "Interação com usuário" via BottomSheet.
class AnimalDetailsSheet extends StatelessWidget {
  final Animal animal;

  const AnimalDetailsSheet({super.key, required this.animal});

  Future<void> _handleAdoptTap(BuildContext context) async {
    if (!AuthState.instance.isLoggedIn) {
      final loggedIn = await Navigator.of(context).push<bool>(
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
      if (loggedIn != true) return;
    }
    if (!context.mounted) return;
    Navigator.of(context).pop(); // fecha o bottom sheet
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => InterestFormScreen(animal: animal)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: AppColors.photoBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: Text(animal.emoji, style: const TextStyle(fontSize: 32)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      animal.name,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${animal.breed} · ${animal.age} · ${animal.city}',
                      style: const TextStyle(color: AppColors.grayText, fontSize: 12),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.badgeBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  animal.healthBadge,
                  style: const TextStyle(fontSize: 11, color: AppColors.badgeText),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            animal.description.isEmpty
                ? 'Este animal está disponível para adoção responsável. Entre em contato para saber mais.'
                : animal.description,
            style: const TextStyle(height: 1.4),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _handleAdoptTap(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: Text(
                'Quero adotar o ${animal.name}',
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
