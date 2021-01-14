import 'package:flutter/material.dart';
import 'package:progressao_financeira/widgets/backgrounds/fundo_degrade.widget.dart';
import 'package:progressao_financeira/widgets/cards/card_resumo.widget.dart';

class ProgressaoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FundoDegradeGO(
      child: Stack(
        children: <Widget>[
          ListView.builder(
            padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
            itemCount: _meses.length,
            itemBuilder: (context, index) {
              return _listaCardResumo(context, index);
            },
          ),
        ],
      ),
    );
  }

  final List<String> _meses = [
    "Janeiro",
    "Fevereiro",
    "Março",
    "Abril",
    "Maio",
    "Junho",
    "Julho",
    "Agosto",
    "Setembro",
    "Outubro",
    "Novembro",
    "Dezembro"
  ];

  Widget _listaCardResumo(BuildContext context, int index) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
      child: CardResumoGO(
        titulo: _meses[index],
      ),
    );
  }
}
