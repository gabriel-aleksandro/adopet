import 'package:flutter/material.dart';
import '../models/animal.dart';
import '../utils/app_colors.dart';

/// TELA 5 DE 5 · CONFIRMAÇÃO DE AÇÃO
/// Exibida logo após o envio do formulário de interesse (Tela 3).
class ConfirmationScreen extends StatelessWidget {
  final Animal animal;

  const ConfirmationScreen({super.key, required this.animal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20),
              color: AppColors.primary,
              alignment: Alignment.center,
              child: const Text(
                'AdoPet 🐾',
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircleAvatar(
                        radius: 44,
                        backgroundColor: AppColors.badgeBg,
                        child: Icon(Icons.check, color: AppColors.badgeText, size: 40),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Interesse registrado!',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.navy),
                      ),
                      const SizedBox(height: 12),
                      Text.rich(
                        TextSpan(
                          style: const TextStyle(fontSize: 14, color: AppColors.grayText, height: 1.5),
                          children: [
                            const TextSpan(
                              text: 'Obrigado por considerar uma adoção. 🐾\nO protetor responsável pelo ',
                            ),
                            TextSpan(
                              text: animal.name,
                              style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.navy),
                            ),
                            const TextSpan(
                              text: ' vai analisar seus dados e entrar em contato pelo e-mail cadastrado em breve.',
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 28),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Tela "Meus pedidos" ainda não implementada.')),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          child: const Text(
                            'Ver meus pedidos',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: AppColors.primary),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          child: const Text(
                            'Continuar navegando',
                            style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
