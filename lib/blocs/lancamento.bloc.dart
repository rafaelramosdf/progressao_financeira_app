import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:progressao_financeira/models/entities/lancamento.entity.dart';
import 'package:progressao_financeira/models/enums/tipoAcao.enum.dart';
import 'package:progressao_financeira/models/enums/tipoLancamento.enum.dart';
import 'package:progressao_financeira/models/utils/uuid.util.dart';
import 'package:progressao_financeira/repositories/lancamento.repository.dart';

class LancamentoBloc extends ChangeNotifier {
  var dataAtual = DateTime.now();
  var anoFiltro = DateTime.now().year;
  var mesFiltro = DateTime.now().month;
  var totalRecebidoAno = 0.0;
  var totalGastoAno = 0.0;
  var totalSaldoAno = 0.0;
  var totalRecebidoMes = 0.0;
  var totalGastoMes = 0.0;
  var totalSaldoMes = 0.0;
  var tipoLancamento = TipoLancamentoEnum.despesa;
  var carregando = false;

  List<LancamentoEntity> listaLancamentos;
  LancamentoEntity edicaoLancamento = new LancamentoEntity();

  void buscarLancamentos() {
    carregando = true;
    notifyListeners();
    LancamentoRepository().listarTodos().then((r) {
      listaLancamentos = r;
      carregando = false;
      Future.delayed(Duration(seconds: 1)).then((r) {
        notifyListeners();
      });
    });
  }

  Future<int> salvarLancamento({@required TipoAcaoEnum acao}) {
    carregando = true;
    notifyListeners();
    switch (acao) {
      case TipoAcaoEnum.alterar:
        return LancamentoRepository().alterar(edicaoLancamento);
        break;
      default:
        return LancamentoRepository().inserir(edicaoLancamento);
    }
  }

  void editarLancamento({@required LancamentoEntity lancamento}) {
    edicaoLancamento = lancamento;
    notifyListeners();
  }

  void novoLancamento() {
    edicaoLancamento = LancamentoEntity(
      id: Uuid().generateV4(),
      categoria: "Despesa Avulsa",
      conta: "Conta Corrente",
      data: DateTime.now(),
      descricao: "",
      gasto: true,
      pago: false,
      parcelado: false,
      parcelas: 1,
      valor: "",
    );

    notifyListeners();
  }

  void mudarFiltroAno({int ano}) {
    anoFiltro = ano;
    buscarLancamentos();
  }

  void mudarFiltroMes({int mes}) {
    mesFiltro = mes;
    buscarLancamentos();
  }

  void sincronizar() {
    notifyListeners();
  }
}
