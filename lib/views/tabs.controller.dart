import 'package:flutter/material.dart';
import 'package:progressao_financeira/blocs/lancamento.bloc.dart';
import 'package:progressao_financeira/models/enums/tipoAcao.enum.dart';
import 'package:progressao_financeira/views/lancamentos/lancamento.list.view.dart';
import 'package:progressao_financeira/views/progressao/progressao.view.dart';
import 'package:progressao_financeira/widgets/cores/cores.widget.dart';
import 'package:progressao_financeira/widgets/icones/icones.widget.dart';
import 'package:provider/provider.dart';

import 'lancamentos/lancamento.form.view.dart';
import 'resumo/resumo.view.dart';

class TabsController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
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
              Expanded(
                child: Consumer<LancamentoBloc>(
                  builder: (context, lancamentoBloc, child) =>
                      PopupMenuButton<int>(
                    initialValue: lancamentoBloc.anoFiltro,
                    child: Text(
                      "${lancamentoBloc.anoFiltro}",
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    onSelected: (int ano) {
                      lancamentoBloc.mudarFiltroAno(ano: ano);
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
                ),
                flex: 2,
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
                icon: Icon(IconesGO.progressao),
                text: "Progressão",
              ),
              Tab(
                icon: Icon(IconesGO.lancamentos),
                text: "Lançamentos",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            ResumoView(),
            ProgressaoView(),
            LancamentoListView(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Provider.of<LancamentoBloc>(context, listen: false)
                .novoLancamento();
            Navigator.push(
              context,
              new MaterialPageRoute(
                builder: (context) =>
                    LancamentoFormView(acao: TipoAcaoEnum.incluir),
              ),
            );
          },
          tooltip: 'Adicionar Despesa / Receita',
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
