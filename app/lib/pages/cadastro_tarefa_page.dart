import 'package:flutter/material.dart';
import '../models/tarefa.dart';

class CadastroTarefaPage extends StatefulWidget {
  final Tarefa? tarefaParaEditar;

  const CadastroTarefaPage({super.key, this.tarefaParaEditar});

  @override
  State<CadastroTarefaPage> createState() => _CadastroTarefaPageState();
}

class _CadastroTarefaPageState extends State<CadastroTarefaPage> {
  DateTime? dataSelecionada;
  TimeOfDay? horarioSelecionado;
  final TextEditingController tituloController = TextEditingController();
  final TextEditingController descricaoController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final tarefa = widget.tarefaParaEditar;

    if (tarefa != null) {
      tituloController.text = tarefa.titulo;
      descricaoController.text = tarefa.descricao;
      dataSelecionada = tarefa.data;

      final partesHorario = tarefa.horario.split(':');

      if (partesHorario.length == 2) {
        horarioSelecionado = TimeOfDay(
          hour: int.parse(partesHorario[0]),
          minute: int.parse(partesHorario[1]),
        );
      }
    }
  }

  Future<void> selecionarData() async {
    final DateTime? data = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2035),
    );

    if (data != null) {
      setState(() {
        dataSelecionada = data;
      });
    }
  }

  Future<void> selecionarHorario() async {
    final TimeOfDay? horario = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (horario != null) {
      setState(() {
        horarioSelecionado = horario;
      });
    }
  }

  void cadastrarTarefa() {
    if (tituloController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Digite o título da tarefa.')),
      );
      return;
    }

    if (descricaoController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Digite a descrição da tarefa.')),
      );
      return;
    }

    if (dataSelecionada == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selecione a data da tarefa.')),
      );
      return;
    }

    if (horarioSelecionado == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selecione o horário da tarefa.')),
      );
      return;
    }

    final tarefaOriginal = widget.tarefaParaEditar;

    final tarefa = Tarefa(
      titulo: tituloController.text.trim(),
      descricao: descricaoController.text.trim(),
      data: dataSelecionada!,
      horario: horarioSelecionado!.format(context),
      concluida: tarefaOriginal?.concluida ?? false,
    );

    debugPrint('Tarefa cadastrada: ${tarefa.titulo}');
    debugPrint('Descrição: ${tarefa.descricao}');
    debugPrint('Data: ${tarefa.data}');
    debugPrint('Horário: ${tarefa.horario}');
    Navigator.pop(context, tarefa);
  }

  @override
  void dispose() {
    tituloController.dispose();
    descricaoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastrar tarefa')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: tituloController,
              decoration: const InputDecoration(
                labelText: 'Título da tarefa',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: descricaoController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Descrição',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
            ),

            const SizedBox(height: 16),

            OutlinedButton.icon(
              onPressed: selecionarData,
              icon: const Icon(Icons.calendar_month),
              label: Text(
                dataSelecionada == null
                    ? 'Selecionar data'
                    : '${dataSelecionada!.day.toString().padLeft(2, '0')}/'
                          '${dataSelecionada!.month.toString().padLeft(2, '0')}/'
                          '${dataSelecionada!.year}',
              ),
            ),

            const SizedBox(height: 16),

            OutlinedButton.icon(
              onPressed: selecionarHorario,
              icon: const Icon(Icons.access_time),
              label: Text(
                horarioSelecionado == null
                    ? 'Selecionar horário'
                    : horarioSelecionado!.format(context),
              ),
            ),

            const SizedBox(height: 24),

            ElevatedButton.icon(
              onPressed: cadastrarTarefa,
              icon: const Icon(Icons.save),
              label: Text(
                widget.tarefaParaEditar == null
                    ? 'Cadastrar tarefa'
                    : 'Salvar alterações',
              ),
            ),
          ],
        ),
      ),
    );
  }

  void limparFormulario() {
    tituloController.clear();
    descricaoController.clear();

    setState(() {
      dataSelecionada = null;
      horarioSelecionado = null;
    });
  }
}
