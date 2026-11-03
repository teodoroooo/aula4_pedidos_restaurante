# Aula 4 – Navegação entre telas

**Programação para Dispositivos Móveis – Prof. Arley**

Exercício: **Aplicativo de pedidos de restaurante**, em que o pedido é montado ao longo de cinco telas.

## Telas

1. **Prato principal**: quatro opções com preço.
2. **Bebida**: três opções com preço.
3. **Sobremesa**: três opções com preço.
4. **Forma de pagamento**: Pix, cartão de crédito, cartão de débito ou dinheiro.
5. **Finalização do pedido**: itens escolhidos, preço de cada item, valor total e forma de pagamento.

## Como as regras foram atendidas

| Regra | Implementação |
|---|---|
| Só avança após selecionar | O botão **Avançar** fica desabilitado (`onPressed: null`) enquanto nada é selecionado. |
| Telas 2, 3 e 4 voltam à anterior ou ao início | `Navigator.pop(context)` e `Navigator.popUntil(context, (rota) => rota.isFirst)`. |
| A escolha permanece ao voltar | Cada tela é um `StatefulWidget`. Como `Navigator.push()` não substitui a rota anterior, o `State` da tela de baixo continua na pilha, e a seleção feita nela é mantida e pode ser alterada. |
| Finalização não volta às etapas | `PopScope(canPop: false)` bloqueia o voltar do sistema, e `automaticallyImplyLeading: false` remove a seta do `AppBar`. |
| Novo pedido reinicia as escolhas | `Navigator.pushAndRemoveUntil(..., (rota) => false)` esvazia a pilha e cria uma nova `TelaPratoPrincipal`, sem nenhuma seleção. |
| Valores em reais com duas casas | `formatarValor()` em `utils/formatar_valor.dart`. |

Os dados passam de uma tela para a seguinte pelos **construtores**. Por exemplo, `TelaSobremesa(prato: ..., bebida: ...)`.

## Estrutura

```
lib/
├── main.dart
├── models/
│   └── item_cardapio.dart
├── utils/
│   └── formatar_valor.dart
└── telas/
    ├── tela_prato_principal.dart
    ├── tela_bebida.dart
    ├── tela_sobremesa.dart
    ├── tela_pagamento.dart
    └── tela_finalizacao.dart
```

## Como executar

```bash
flutter pub get
flutter run
```

## Testes

```bash
flutter test
```

Os testes em `test/widget_test.dart` passam por todo o fluxo do pedido. Eles verificam a seleção obrigatória, o retorno com a escolha mantida, o retorno ao início, os valores e o total na finalização, o bloqueio do voltar e o "Novo pedido".
