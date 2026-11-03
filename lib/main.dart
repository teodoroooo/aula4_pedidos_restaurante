import 'package:flutter/material.dart';

import 'telas/tela_prato_principal.dart';

void main() {
  runApp(const RootApp());
}

class RootApp extends StatelessWidget {
  const RootApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pedidos de restaurante',
      home: TelaPratoPrincipal(),
    );
  }
}
