import 'package:flutter/material.dart';

import '../models/item_cardapio.dart';
import '../utils/formatar_valor.dart';
import 'tela_sobremesa.dart';

class TelaBebida extends StatefulWidget {
  final ItemCardapio prato;

  const TelaBebida({super.key, required this.prato});

  @override
  State<TelaBebida> createState() => _TelaBebidaState();
}

class _TelaBebidaState extends State<TelaBebida> {
  static const List<ItemCardapio> bebidas = [
    ItemCardapio('Refrigerante lata', 6.50),
    ItemCardapio('Suco natural', 9.00),
    ItemCardapio('Água mineral', 4.00),
  ];

  ItemCardapio? bebidaSelecionada;

  void avancar() {
    final bebida = bebidaSelecionada;

    if (bebida == null) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            TelaSobremesa(prato: widget.prato, bebida: bebida),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('2. Bebida')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Escolha a bebida:'),
            const SizedBox(height: 8),
            for (final bebida in bebidas)
              ListTile(
                title: Text(bebida.nome),
                subtitle: Text(formatarValor(bebida.valor)),
                leading: Icon(
                  bebida == bebidaSelecionada
                      ? Icons.radio_button_checked
                      : Icons.radio_button_unchecked,
                ),
                selected: bebida == bebidaSelecionada,
                onTap: () {
                  setState(() {
                    bebidaSelecionada = bebida;
                  });
                },
              ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: bebidaSelecionada == null ? null : avancar,
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
