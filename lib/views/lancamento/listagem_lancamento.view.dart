import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:progressao_financeira/controllers/lancamento.controller.dart';
import 'package:progressao_financeira/models/entities/lancamento.entity.dart';
import 'package:progressao_financeira/widgets/backgrounds/fundo_degrade.widget.dart';
import 'package:progressao_financeira/widgets/cards/card_lancamento.widget.dart';
import 'package:progressao_financeira/widgets/cores/cores.widget.dart';

class ListagemLancamentoView extends StatelessWidget {
  final _controller = Get.put(LancamentoController());

  @override
  Widget build(BuildContext context) {
    _controller.buscarLancamentosMes();

    return FundoDegradeGO(
      child: Obx(
        () => _controller.carregando
            ? Center(child: CircularProgressIndicator())
            : Stack(
                children: <Widget>[
                  ListView.builder(
                    padding: EdgeInsets.fromLTRB(10.0, 90.0, 10.0, 10.0),
                    itemCount: _controller.listaLancamentosMes.length,
                    itemBuilder: (context, index) {
                      return _getCardLancamento(
                          context, index, _controller.listaLancamentosMes);
                    },
                  ),
                  Container(
                    color: Colors.indigo[900],
                    height: 80.0,
                    padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Obx(
                            () => PopupMenuButton<int>(
                              initialValue: _controller.mesFiltro,
                              child: Text(
                                new DateFormat()
                                    .add_MMM()
                                    .format(new DateTime(_controller.anoFiltro,
                                        _controller.mesFiltro, 1))
                                    .toUpperCase(),
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
                                "${_controller.totalRecebidoMes}",
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
                                "${_controller.totalGastoMes}",
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
                                "${_controller.totalSaldoMes}",
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
              ),
      ),
    );
  }

  final List<PopupMenuEntry<int>> _popUpItemMes = [
    const PopupMenuItem<int>(value: 1, child: Text("JAN")),
    const PopupMenuItem<int>(value: 2, child: Text("FEV")),
    const PopupMenuItem<int>(value: 3, child: Text("MAR")),
    const PopupMenuItem<int>(value: 4, child: Text("ABR")),
    const PopupMenuItem<int>(value: 5, child: Text("MAI")),
    const PopupMenuItem<int>(value: 6, child: Text("JUN")),
    const PopupMenuItem<int>(value: 7, child: Text("JUL")),
    const PopupMenuItem<int>(value: 8, child: Text("AGO")),
    const PopupMenuItem<int>(value: 9, child: Text("SET")),
    const PopupMenuItem<int>(value: 10, child: Text("OUT")),
    const PopupMenuItem<int>(value: 11, child: Text("NOV")),
    const PopupMenuItem<int>(value: 12, child: Text("DEZ")),
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
