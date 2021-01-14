import 'package:flutter/material.dart';

class BotaoIconeFloatGO extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {},
      tooltip: 'Adicionar Despesa / Receita',
      child: Icon(Icons.add),
    );
  }
}
