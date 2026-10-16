import 'package:flutter/material.dart';

import '../models/tarefa.dart';
import '../widgets/menu_navegacao.dart';
import 'cadastro_tarefa_page.dart';
import 'home_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int indiceSelecionado = 0;

  final List<Tarefa> tarefas = [];

  @override
  Widget build(BuildContext context) {
    final paginas = [
      const HomePage(),
      const Center(child: Text('Lista de tarefas em desenvolvimento.')),
    ];

    return Scaffold(
      body: SafeArea(child: paginas[indiceSelecionado]),
      bottomNavigationBar: MenuNavegacao(
        indiceSelecionado: indiceSelecionado,
        aoSelecionar: (indice) {
          if (indice == 2) {
            // Guardamos o ScaffoldMessenger antes da navegação.
            final messenger = ScaffoldMessenger.of(context);

            Navigator.push<Tarefa>(
              context,
              MaterialPageRoute<Tarefa>(
                builder: (context) => const CadastroTarefaPage(),
              ),
            ).then((tarefa) {
              if (!mounted) return;

              if (tarefa != null) {
                setState(() {
                  tarefas.add(tarefa);
                });

                messenger.showSnackBar(
                  const SnackBar(
                    content: Text('Tarefa cadastrada com sucesso!'),
                  ),
                );
              }
            });

            return;
          }

          setState(() {
            indiceSelecionado = indice;
          });
        },
      ),
    );
  }
}
