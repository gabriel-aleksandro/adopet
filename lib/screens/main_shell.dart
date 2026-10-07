import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../state/auth_state.dart';
import 'home_screen.dart';
import 'listing_screen.dart';
import 'login_screen.dart';

/// Shell com BottomNavigationBar, satisfazendo o requisito de navegação
/// entre todas as telas do app. Início e Listagem são abas reais;
/// Favoritos e Perfil exigem login antes de mostrar qualquer conteúdo.
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  final List<Widget> _tabs = const [
    HomeScreen(),
    ListingScreen(),
  ];

  Future<void> _onTap(int index) async {
    // index 2 = Favoritos, 3 = Perfil -> exigem login antes de prosseguir
    if (index == 2 || index == 3) {
      if (!AuthState.instance.isLoggedIn) {
        final loggedIn = await Navigator.of(context).push<bool>(
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
        if (loggedIn != true) return;
      }
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            index == 2
                ? 'Seus animais favoritos aparecerão aqui.'
                : 'Seu perfil aparecerá aqui.',
          ),
          backgroundColor: AppColors.navy,
        ),
      );
      return;
    }
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _tabs,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.grey,
        onTap: _onTap,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Início'),
          BottomNavigationBarItem(icon: Icon(Icons.list_rounded), label: 'Listagem'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border_rounded), label: 'Favoritos'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline_rounded), label: 'Perfil'),
        ],
      ),
    );
  }
}
