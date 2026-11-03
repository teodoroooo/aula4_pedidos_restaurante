import 'package:flutter/material.dart';

import '../models/item_cardapio.dart';
import '../utils/formatar_valor.dart';
import 'tela_bebida.dart';

class TelaPratoPrincipal extends StatefulWidget {
  const TelaPratoPrincipal({super.key});

  @override
  State<TelaPratoPrincipal> createState() => _TelaPratoPrincipalState();
}

class _TelaPratoPrincipalState extends State<TelaPratoPrincipal> {
  static const List<ItemCardapio> pratos = [
    ItemCardapio('Filé à parmegiana', 49.90),
    ItemCardapio('Frango grelhado', 36.50),
    ItemCardapio('Lasanha à bolonhesa', 42.00),
    ItemCardapio('Risoto de cogumelos', 45.75),
  ];

  ItemCardapio? pratoSelecionado;

  void avancar() {
    final prato = pratoSelecionado;

    if (prato == null) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TelaBebida(prato: prato),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('1. Prato principal')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Escolha o prato principal:'),
            const SizedBox(height: 8),
            for (final prato in pratos)
              ListTile(
                title: Text(prato.nome),
                subtitle: Text(formatarValor(prato.valor)),
                leading: Icon(
                  prato == pratoSelecionado
                      ? Icons.radio_button_checked
                      : Icons.radio_button_unchecked,
                ),
                selected: prato == pratoSelecionado,
                onTap: () {
                  setState(() {
                    pratoSelecionado = prato;
                  });
                },
              ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: pratoSelecionado == null ? null : avancar,
              child: const Text('Avançar'),
            ),
          ],
        ),
      ),
    );
  }
}
