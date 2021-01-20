import 'package:flutter/material.dart';
import 'package:progressao_financeira/widgets/cores/cores.widget.dart';
import 'package:progressao_financeira/models/objects/progressao.object.dart';

class CardResumoGO extends StatelessWidget {
  final ProgressaoObject resumoMes;

  CardResumoGO({
    this.resumoMes,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      child: Padding(
        padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    this.resumoMes.mes,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: CoresGO.cinza,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    "Recebi",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12.0,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    "Gastei",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12.0,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    "Sobrou",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12.0,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    "R\$ ${this.resumoMes.totalRecebido}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: CoresGO.verde,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    "R\$ ${this.resumoMes.totalGasto}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: CoresGO.rosa,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    "R\$ ${this.resumoMes.totalSaldo}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: CoresGO.azul,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.0),
          ],
        ),
      ),
    );
  }
}
