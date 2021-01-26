import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progressao_financeira/controllers/lancamento.controller.dart';
import 'package:progressao_financeira/widgets/backgrounds/fundo_degrade.widget.dart';
import 'package:progressao_financeira/widgets/cards/card_resumo.widget.dart';

class ProgressaoView extends StatelessWidget {
  final _controller = Get.put(LancamentoController());

  ProgressaoView() {
    this._controller.buscarLancamentos();
  }

  @override
  Widget build(BuildContext context) {
    return FundoDegradeGO(
      child: Obx(
        () => _controller.carregando
            ? Center(child: CircularProgressIndicator())
            : Stack(
                children: <Widget>[
                  ListView.builder(
                    padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
                    itemCount: _controller.listaProgressao.length,
                    itemBuilder: (context, index) {
                      return _listaCardResumo(context, index);
                    },
                  ),
                ],
              ),
      ),
    );
  }

  Widget _listaCardResumo(BuildContext context, int index) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
      child: CardResumoGO(
        resumoMes: _controller.listaProgressao[index],
      ),
    );
  }
}
