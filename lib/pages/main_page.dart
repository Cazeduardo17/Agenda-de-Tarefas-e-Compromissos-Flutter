import 'package:flutter/material.dart';

import '../models/tarefa.dart';
import '../widgets/menu_navegacao.dart';
import 'cadastro_tarefa_page.dart';
import 'home_page.dart';
import 'lista_tarefas_page.dart';

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
      HomePage(
        tarefas: tarefas,
        aoAlternarConclusao: (tarefa) {
          setState(() {
            tarefa.alternarConclusao();
          });
        },
      ),
      ListaTarefasPage(
        tarefas: tarefas,
        aoAlternarConclusao: (index) {
          setState(() {
            tarefas[index].alternarConclusao();
          });
        },
        aoEditarTarefa: (index, tarefaEditada) {
          setState(() {
            tarefas[index] = tarefaEditada;
          });
        },
        aoRemoverTarefa: (index) {
          setState(() {
            tarefas.removeAt(index);
          });
        },
      ),
    ];

    return Scaffold(
      body: SafeArea(child: paginas[indiceSelecionado]),
      bottomNavigationBar: MenuNavegacao(
        indiceSelecionado: indiceSelecionado,
        aoSelecionar: (indice) {
          if (indice == 2) {
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
