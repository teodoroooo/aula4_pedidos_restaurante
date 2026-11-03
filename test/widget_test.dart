import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:aula4_pedidos_restaurante/main.dart';
import 'package:aula4_pedidos_restaurante/utils/formatar_valor.dart';

ElevatedButton botao(WidgetTester tester, String texto) {
  return tester.widget<ElevatedButton>(
    find.widgetWithText(ElevatedButton, texto),
  );
}

Future<void> tocar(WidgetTester tester, String texto) async {
  await tester.tap(find.text(texto));
  await tester.pumpAndSettle();
}

bool selecionado(WidgetTester tester, String nome) {
  return tester.widget<ListTile>(find.widgetWithText(ListTile, nome)).selected;
}

void main() {
  test('formatarValor apresenta reais com duas casas decimais', () {
    expect(formatarValor(49.9), 'R\$ 49,90');
    expect(formatarValor(4), 'R\$ 4,00');
  });

  testWidgets('só avança após selecionar uma opção', (tester) async {
    await tester.pumpWidget(const RootApp());

    expect(find.text('1. Prato principal'), findsOneWidget);
    expect(botao(tester, 'Avançar').onPressed, isNull);

    await tocar(tester, 'Frango grelhado');
    expect(botao(tester, 'Avançar').onPressed, isNotNull);

    await tocar(tester, 'Avançar');
    expect(find.text('2. Bebida'), findsOneWidget);
    expect(botao(tester, 'Avançar').onPressed, isNull);
  });

  testWidgets('ao voltar, a escolha anterior permanece selecionada',
      (tester) async {
    await tester.pumpWidget(const RootApp());

    await tocar(tester, 'Frango grelhado');
    await tocar(tester, 'Avançar');
    await tocar(tester, 'Suco natural');
    await tocar(tester, 'Avançar');
    expect(find.text('3. Sobremesa'), findsOneWidget);

    await tocar(tester, 'Voltar à tela anterior');
    expect(find.text('2. Bebida'), findsOneWidget);
    expect(selecionado(tester, 'Suco natural'), isTrue);

    // A escolha pode ser alterada.
    await tocar(tester, 'Água mineral');
    expect(selecionado(tester, 'Água mineral'), isTrue);
    expect(selecionado(tester, 'Suco natural'), isFalse);

    await tocar(tester, 'Voltar ao início');
    expect(find.text('1. Prato principal'), findsOneWidget);
    expect(selecionado(tester, 'Frango grelhado'), isTrue);
  });

  testWidgets('finalização exibe itens, total e pagamento; novo pedido reinicia',
      (tester) async {
    await tester.pumpWidget(const RootApp());

    await tocar(tester, 'Filé à parmegiana'); // 49,90
    await tocar(tester, 'Avançar');
    await tocar(tester, 'Refrigerante lata'); // 6,50
    await tocar(tester, 'Avançar');
    await tocar(tester, 'Pudim de leite'); // 12,00
    await tocar(tester, 'Avançar');

    expect(find.text('4. Forma de pagamento'), findsOneWidget);
    expect(botao(tester, 'Finalizar pedido').onPressed, isNull);
    await tocar(tester, 'Pix');
    await tocar(tester, 'Finalizar pedido');

    expect(find.text('5. Finalização do pedido'), findsOneWidget);
    expect(find.text('R\$ 49,90'), findsOneWidget);
    expect(find.text('R\$ 6,50'), findsOneWidget);
    expect(find.text('R\$ 12,00'), findsOneWidget);
    expect(find.text('R\$ 68,40'), findsOneWidget);
    expect(find.text('Pix'), findsOneWidget);

    // Não há botões nem seta para retornar às etapas anteriores.
    expect(find.byType(BackButton), findsNothing);
    expect(find.text('Voltar à tela anterior'), findsNothing);
    expect(find.byType(ElevatedButton), findsOneWidget);

    // O botão voltar do sistema não sai da finalização.
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    expect(find.text('5. Finalização do pedido'), findsOneWidget);

    await tocar(tester, 'Novo pedido');
    expect(find.text('1. Prato principal'), findsOneWidget);
    expect(selecionado(tester, 'Filé à parmegiana'), isFalse);
    expect(botao(tester, 'Avançar').onPressed, isNull);
    expect(find.byType(BackButton), findsNothing);
  });
}
