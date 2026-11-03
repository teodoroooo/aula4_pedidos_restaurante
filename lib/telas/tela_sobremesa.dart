import 'package:flutter/material.dart';

import '../models/item_cardapio.dart';
import '../utils/formatar_valor.dart';
import 'tela_pagamento.dart';

class TelaSobremesa extends StatefulWidget {
  final ItemCardapio prato;
  final ItemCardapio bebida;

  const TelaSobremesa({
    super.key,
    required this.prato,
    required this.bebida,
  });

  @override
  State<TelaSobremesa> createState() => _TelaSobremesaState();
}

class _TelaSobremesaState extends State<TelaSobremesa> {
  static const List<ItemCardapio> sobremesas = [
    ItemCardapio('Pudim de leite', 12.00),
    ItemCardapio('Petit gâteau', 18.90),
    ItemCardapio('Salada de frutas', 10.50),
  ];

  ItemCardapio? sobremesaSelecionada;

  void avancar() {
    final sobremesa = sobremesaSelecionada;

    if (sobremesa == null) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TelaPagamento(
          prato: widget.prato,
          bebida: widget.bebida,
          sobremesa: sobremesa,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('3. Sobremesa')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Escolha a sobremesa:'),
            const SizedBox(height: 8),
            for (final sobremesa in sobremesas)
              ListTile(
                title: Text(sobremesa.nome),
                subtitle: Text(formatarValor(sobremesa.valor)),
                leading: Icon(
                  sobremesa == sobremesaSelecionada
                      ? Icons.radio_button_checked
                      : Icons.radio_button_unchecked,
                ),
                selected: sobremesa == sobremesaSelecionada,
                onTap: () {
                  setState(() {
                    sobremesaSelecionada = sobremesa;
                  });
                },
              ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: sobremesaSelecionada == null ? null : avancar,
              child: const Text('Avançar'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Voltar à tela anterior'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, (rota) => rota.isFirst);
              },
              child: const Text('Voltar ao início'),
            ),
          ],
        ),
      ),
    );
  }
}
