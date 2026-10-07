import 'package:flutter/material.dart';
import '../models/animal.dart';
import '../utils/app_colors.dart';
import 'confirmation_screen.dart';

enum _Residencia { casaComQuintal, casaSemQuintal, apartamento }

/// TELA 3 DE 5 · COLETA DE DADOS DA FUNCIONALIDADE PRINCIPAL
/// Formulário de interesse na adoção. Usa de propósito uma variedade de
/// widgets de entrada (RadioButton, Switch, Slider, TextFormField) para
/// atender ao requisito do enunciado de não se limitar a TextFormFields.
class InterestFormScreen extends StatefulWidget {
  final Animal animal;

  const InterestFormScreen({super.key, required this.animal});

  @override
  State<InterestFormScreen> createState() => _InterestFormScreenState();
}

class _InterestFormScreenState extends State<InterestFormScreen> {
  _Residencia _residencia = _Residencia.casaComQuintal;
  bool _teveOutrosAnimais = false;
  bool _moradoresConcordam = true;
  double _horasDisponiveis = 4;
  final _motivoController = TextEditingController();

  @override
  void dispose() {
    _motivoController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    // Interação com o usuário via Dialog antes de confirmar o envio.
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Confirmar envio?'),
        content: Text(
          'Seu interesse em adotar ${widget.animal.name} será enviado ao '
          'protetor responsável. Deseja continuar?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
            child: const Text('Enviar', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    if (confirmar != true || !mounted) return;

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => ConfirmationScreen(animal: widget.animal)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              color: AppColors.primary,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        'Quero adotar o ${widget.animal.name} ${widget.animal.emoji}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        'Conte um pouco sobre você',
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  const Text('Tipo de residência', style: TextStyle(fontWeight: FontWeight.bold)),
                  RadioListTile<_Residencia>(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Casa com quintal'),
                    value: _Residencia.casaComQuintal,
                    groupValue: _residencia,
                    activeColor: AppColors.primary,
                    onChanged: (v) => setState(() => _residencia = v!),
                  ),
                  RadioListTile<_Residencia>(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Casa sem quintal'),
                    value: _Residencia.casaSemQuintal,
                    groupValue: _residencia,
                    activeColor: AppColors.primary,
                    onChanged: (v) => setState(() => _residencia = v!),
                  ),
                  RadioListTile<_Residencia>(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Apartamento'),
                    value: _Residencia.apartamento,
                    groupValue: _residencia,
                    activeColor: AppColors.primary,
                    onChanged: (v) => setState(() => _residencia = v!),
                  ),
                  const Divider(height: 32),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Já teve outros animais?', style: TextStyle(fontWeight: FontWeight.bold)),
                    value: _teveOutrosAnimais,
                    activeColor: AppColors.primary,
                    onChanged: (v) => setState(() => _teveOutrosAnimais = v),
                  ),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Todos os moradores concordam?', style: TextStyle(fontWeight: FontWeight.bold)),
                    value: _moradoresConcordam,
                    activeColor: AppColors.primary,
                    onChanged: (v) => setState(() => _moradoresConcordam = v),
                  ),
                  const Divider(height: 32),
                  Text(
                    'Tempo disponível por dia: ${_horasDisponiveis.round()}h',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Slider(
                    value: _horasDisponiveis,
                    min: 0,
                    max: 8,
                    divisions: 8,
                    activeColor: AppColors.primary,
                    label: '${_horasDisponiveis.round()}h',
                    onChanged: (v) => setState(() => _horasDisponiveis = v),
                  ),
                  const SizedBox(height: 16),
                  const Text('Motivo da adoção', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _motivoController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: 'Quero companhia para minha família...',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _handleSubmit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Text(
                        'Enviar interesse',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
