import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progressao_financeira/controllers/_global.controller.dart';
import 'package:progressao_financeira/controllers/lancamento.controller.dart';
import 'package:progressao_financeira/models/entities/lancamento.entity.dart';
import 'package:progressao_financeira/widgets/backgrounds/fundo_degrade.widget.dart';
import 'package:progressao_financeira/widgets/cards/card_lancamento.widget.dart';
import 'package:progressao_financeira/widgets/cores/cores.widget.dart';

class LancamentoListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _controller = Get.put(LancamentoController());
    final _globalController = Get.put(GlobalController());

    return FundoDegradeGO(
        child: _globalController.carregando
            ? Center(child: CircularProgressIndicator())
            : Stack(
                children: <Widget>[
                  ListView.builder(
                    padding: EdgeInsets.fromLTRB(10.0, 90.0, 10.0, 10.0),
                    itemCount: _controller.listaLancamentos.length,
                    itemBuilder: (context, index) {
                      return _getCardLancamento(
                          context, index, _controller.listaLancamentos);
                    },
                  ),
                  Container(
                    color: Colors.indigo[900],
                    height: 80.0,
                    padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: PopupMenuButton<int>(
                            initialValue: 0,
                            child: Text(
                              "JAN",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: CoresGO.branco,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            onSelected: (int mes) {
                              _controller.mudarFiltroMes(mes: mes);
                            },
                            itemBuilder: (BuildContext context) =>
                                _popUpItemMes,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Recebi",
                                style: TextStyle(
                                  color: CoresGO.branco,
                                  fontSize: 12.0,
                                ),
                              ),
                              Text(
                                "${_globalController.totalRecebidoMes}",
                                style: TextStyle(
                                  color: CoresGO.verde,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Gastei",
                                style: TextStyle(
                                  color: CoresGO.branco,
                                  fontSize: 12.0,
                                ),
                              ),
                              Text(
                                "${_globalController.totalGastoMes}",
                                style: TextStyle(
                                  color: CoresGO.rosa,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Sobrou",
                                style: TextStyle(
                                  color: CoresGO.branco,
                                  fontSize: 12.0,
                                ),
                              ),
                              Text(
                                "${_globalController.totalSaldoMes}",
                                style: TextStyle(
                                  color: CoresGO.branco,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ));
  }

  final List<PopupMenuEntry<int>> _popUpItemMes = [
    const PopupMenuItem<int>(value: 0, child: Text("JAN")),
    const PopupMenuItem<int>(value: 1, child: Text("FEV")),
    const PopupMenuItem<int>(value: 2, child: Text("MAR")),
    const PopupMenuItem<int>(value: 3, child: Text("ABR")),
    const PopupMenuItem<int>(value: 4, child: Text("MAI")),
    const PopupMenuItem<int>(value: 5, child: Text("JUN")),
    const PopupMenuItem<int>(value: 6, child: Text("JUL")),
    const PopupMenuItem<int>(value: 7, child: Text("AGO")),
    const PopupMenuItem<int>(value: 8, child: Text("SET")),
    const PopupMenuItem<int>(value: 9, child: Text("OUT")),
    const PopupMenuItem<int>(value: 10, child: Text("NOV")),
    const PopupMenuItem<int>(value: 11, child: Text("DEZ")),
  ];

  Widget _getCardLancamento(
      BuildContext context, int index, List<LancamentoEntity> lancamentos) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
      child: CardLancamentoGO(
        lancamento: lancamentos[index],
      ),
    );
  }
}
