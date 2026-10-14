
import 'package:flutter/material.dart';

import 'home_page.dart';
import '../widgets/menu_navegacao.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int indiceSelecionado = 0;

  @override
  Widget build(BuildContext context) {
    final paginas = [
      const HomePage(),
      const Center(
        child: Text('Lista de tarefas em desenvolvimento.'),
      ),
      const Center(
        child: Text('Cadastro de tarefas em desenvolvimento.'),
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: paginas[indiceSelecionado],
      ),
      bottomNavigationBar: MenuNavegacao(
        indiceSelecionado: indiceSelecionado,
        aoSelecionar: (indice) {
          setState(() {
            indiceSelecionado = indice;
          });
        },
      ),
    );
  }
}
