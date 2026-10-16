
import 'package:flutter/material.dart';

class MenuNavegacao extends StatelessWidget {
  final int indiceSelecionado;
  final ValueChanged<int> aoSelecionar;

  const MenuNavegacao({
    super.key,
    required this.indiceSelecionado,
    required this.aoSelecionar,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: indiceSelecionado,
      onDestinationSelected: aoSelecionar,
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home),
          label: 'Início',
        ),
        NavigationDestination(
          icon: Icon(Icons.list_alt_outlined),
          selectedIcon: Icon(Icons.list_alt),
          label: 'Tarefas',
        ),
        NavigationDestination(
          icon: Icon(Icons.add_circle_outline),
          selectedIcon: Icon(Icons.add_circle),
          label: 'Adicionar',
        ),
      ],
    );
  }
}
