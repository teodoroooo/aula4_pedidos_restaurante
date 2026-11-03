import 'package:flutter/material.dart';

import '../models/item_cardapio.dart';
import '../utils/formatar_valor.dart';
import 'tela_prato_principal.dart';

class TelaFinalizacao extends StatelessWidget {
  final ItemCardapio prato;
  final ItemCardapio bebida;
  final ItemCardapio sobremesa;
  final String formaPagamento;

  const TelaFinalizacao({
    super.key,
    required this.prato,
    required this.bebida,
    required this.sobremesa,
    required this.formaPagamento,
  });

  double calcularTotal() {
    return prato.valor + bebida.valor + sobremesa.valor;
  }

  void novoPedido(BuildContext context) {
    // Remove todas as rotas da pilha e abre uma nova tela inicial,
    // com as escolhas reiniciadas.
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const TelaPratoPrincipal()),
      (rota) => false,
    );
  }

  Widget linhaItem(String categoria, ItemCardapio item) {
    return ListTile(
      title: Text(item.nome),
      subtitle: Text(categoria),
      trailing: Text(formatarValor(item.valor)),
    );
  }

  @override
  Widget build(BuildContext context) {
    // PopScope com canPop: false impede o retorno às etapas anteriores
    // pelo botão/gesto de voltar do sistema.
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('5. Finalização do pedido'),
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Resumo do pedido:'),
              const SizedBox(height: 8),
              linhaItem('Prato principal', prato),
              linhaItem('Bebida', bebida),
              linhaItem('Sobremesa', sobremesa),
              const Divider(),
              ListTile(
                title: const Text(
                  'Total',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: Text(
                  formatarValor(calcularTotal()),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                title: const Text('Forma de pagamento'),
                trailing: Text(formaPagamento),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => novoPedido(context),
                child: const Text('Novo pedido'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
