import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progressao_financeira/controllers/lancamento.controller.dart';
import 'package:progressao_financeira/widgets/backgrounds/fundo_degrade.widget.dart';
import 'package:progressao_financeira/widgets/barra_progresso/barra_progresso.widget.dart';
import 'package:progressao_financeira/widgets/cores/cores.widget.dart';
import 'package:progressao_financeira/models/utils/extensions.util.dart';

class ResumoView extends StatelessWidget {
  final _controller = Get.put(LancamentoController());

  ResumoView() {
    _controller.buscarLancamentos();
  }

  @override
  Widget build(BuildContext context) {
    return FundoDegradeGO(
      child: ListView(
        padding: EdgeInsets.all(10.0),
        children: <Widget>[
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(height: 25.0),
                Material(
                  elevation: 5,
                  type: MaterialType.card,
                  color: CoresGO.azulEscuro,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Saldo do Ano",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: CoresGO.azulClaro,
                            fontSize: 22,
                          ),
                        ),
                        SizedBox(height: 15.0),
                        Obx(
                          () => BarraProgressoGO(
                            corBarra: CoresGO.verde,
                            progresso: _controller.totalRecebidoAno > 0.0
                                ? _controller.totalRecebidoAno
                                : 0.0,
                            titulo: "Ganhos",
                            corTitulo: CoresGO.azulClaro,
                          ),
                        ),
                        Obx(
                          () => BarraProgressoGO(
                            corBarra: CoresGO.rosa,
                            progresso: _controller.totalGastoAno > 0.0
                                ? _controller.totalGastoAno
                                : 0.0,
                            titulo: "Gastos",
                            corTitulo: CoresGO.azulClaro,
                          ),
                        ),
                        Obx(
                          () => BarraProgressoGO(
                            corBarra: CoresGO.azul,
                            progresso: _controller.totalSaldoAno > 0.0
                                ? _controller.totalSaldoAno
                                : 0.0,
                            titulo: "Saldo",
                            corTitulo: CoresGO.azulClaro,
                          ),
                        ),
                        SizedBox(height: 10.0),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Material(
                  elevation: 5,
                  type: MaterialType.card,
                  color: CoresGO.verde,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            "Recebi: ",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: CoresGO.branco,
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Obx(
                            () => Text(
                              "${_controller.totalRecebidoAno.formatToCurrencyString()}",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: CoresGO.verdeClaro,
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Material(
                  elevation: 5,
                  type: MaterialType.card,
                  color: CoresGO.rosa,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            "Gastei: ",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: CoresGO.branco,
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Obx(
                            () => Text(
                              "${_controller.totalGastoAno.formatToCurrencyString()}",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: CoresGO.rosaClaro,
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Material(
                  elevation: 5,
                  type: MaterialType.card,
                  color: CoresGO.azul,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            "Sobrou: ",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: CoresGO.branco,
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Obx(
                            () => Text(
                              "${_controller.totalSaldoAno.formatToCurrencyString()}",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: CoresGO.branco,
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
