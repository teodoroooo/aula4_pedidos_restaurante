import 'package:flutter/material.dart';

import '../models/item_cardapio.dart';
import 'tela_finalizacao.dart';

class TelaPagamento extends StatefulWidget {
  final ItemCardapio prato;
  final ItemCardapio bebida;
  final ItemCardapio sobremesa;

  const TelaPagamento({
    super.key,
    required this.prato,
    required this.bebida,
    required this.sobremesa,
  });

  @override
  State<TelaPagamento> createState() => _TelaPagamentoState();
}

class _TelaPagamentoState extends State<TelaPagamento> {
  static const List<String> formasPagamento = [
    'Pix',
    'Cartão de crédito',
    'Cartão de débito',
    'Dinheiro',
  ];

  String? formaSelecionada;

  void finalizar() {
    final forma = formaSelecionada;

    if (forma == null) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TelaFinalizacao(
          prato: widget.prato,
          bebida: widget.bebida,
          sobremesa: widget.sobremesa,
          formaPagamento: forma,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('4. Forma de pagamento')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Escolha a forma de pagamento:'),
            const SizedBox(height: 8),
            for (final forma in formasPagamento)
              ListTile(
                title: Text(forma),
                leading: Icon(
                  forma == formaSelecionada
                      ? Icons.radio_button_checked
                      : Icons.radio_button_unchecked,
                ),
                selected: forma == formaSelecionada,
                onTap: () {
                  setState(() {
                    formaSelecionada = forma;
                  });
                },
              ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: formaSelecionada == null ? null : finalizar,
              child: const Text('Finalizar pedido'),
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
