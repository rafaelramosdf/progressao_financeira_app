import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progressao_financeira/controllers/lancamento.controller.dart';
import 'package:progressao_financeira/views/lancamento/inclusao_lancamento.view.dart';
import 'package:progressao_financeira/views/lancamento/listagem_lancamento.view.dart';
import 'package:progressao_financeira/views/progressao/progressao.view.dart';
import 'package:progressao_financeira/widgets/cores/cores.widget.dart';
import 'package:progressao_financeira/widgets/icones/icones.widget.dart';
import 'resumo/resumo.view.dart';

class TabsView extends StatelessWidget {
  final _controller = Get.put(LancamentoController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: _controller.initialTabIndex,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: CoresGO.azulEscuro,
          title: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Icon(Icons.insert_chart),
              SizedBox(width: 5.0),
              Expanded(
                child: Text(
                  "THREEGO - Progressão Financeira",
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
                flex: 8,
              ),
              Obx(
                () => Expanded(
                  child: PopupMenuButton<int>(
                    initialValue: _controller.anoFiltro,
                    child: Text(
                      "${_controller.anoFiltro}",
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    onSelected: (int ano) {
                      _controller.mudarFiltroAno(ano: ano);
                    },
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<int>>[
                      PopupMenuItem<int>(
                          value: DateTime.now().year - 1,
                          child: Text("${DateTime.now().year - 1}")),
                      PopupMenuItem<int>(
                          value: DateTime.now().year,
                          child: Text("${DateTime.now().year}")),
                      PopupMenuItem<int>(
                          value: DateTime.now().year + 1,
                          child: Text("${DateTime.now().year + 1}")),
                    ],
                  ),
                  flex: 2,
                ),
              ),
            ],
          ),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(IconesGO.resumo),
                text: "Resumo",
              ),
              Tab(
                icon: Icon(IconesGO.lancamentos),
                text: "Lançamentos",
              ),
              Tab(
                icon: Icon(IconesGO.progressao),
                text: "Progressão",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            ResumoView(),
            ListagemLancamentoView(),
            ProgressaoView(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _controller.novoLancamento();
            Get.to(InclusaoLancamentoView());
          },
          tooltip: 'Adicionar Despesa / Receita',
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
