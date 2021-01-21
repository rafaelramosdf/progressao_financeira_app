import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:progressao_financeira/controllers/base/base.controller.dart';
import 'package:progressao_financeira/models/entities/lancamento.entity.dart';
import 'package:progressao_financeira/models/utils/uuid.util.dart';
import 'package:progressao_financeira/repositories/lancamento.repository.dart';
import 'package:progressao_financeira/models/objects/progressao.object.dart';

class LancamentoController extends BaseController {
  final _repository = Get.put(LancamentoRepository());

  List<LancamentoEntity> _listaLancamentosAno = List<LancamentoEntity>().obs;
  List<LancamentoEntity> get listaLancamentosAno => this._listaLancamentosAno;
  set listaLancamentosAno(List<LancamentoEntity> value) {
    this._listaLancamentosAno = value;
    this.somarTotalizadores(this._listaLancamentosAno);
    this._listaProgressao = ProgressaoObject.obterListaProgressao(
        this._listaLancamentosAno, this.anoFiltro);
  }

  List<LancamentoEntity> _listaLancamentosMes = List<LancamentoEntity>().obs;
  List<LancamentoEntity> get listaLancamentosMes => this._listaLancamentosMes;
  set listaLancamentosMes(List<LancamentoEntity> value) {
    this._listaLancamentosMes = value;
  }

  List<ProgressaoObject> _listaProgressao = List<ProgressaoObject>().obs;
  List<ProgressaoObject> get listaProgressao => this._listaProgressao;

  final _edicaoLancamento = LancamentoEntity().obs;
  LancamentoEntity get edicaoLancamento => this._edicaoLancamento.value;
  set edicaoLancamento(LancamentoEntity value) =>
      this._edicaoLancamento.value = value;

  void buscarLancamentos() {
    this.carregando = true;

    _repository.listarTodosPorAno(this.anoFiltro).then((r) {
      listaLancamentosAno = new List<LancamentoEntity>();
      listaLancamentosMes = new List<LancamentoEntity>();

      if (r != null && r.length > 0) {
        listaLancamentosAno = r;
        listaLancamentosMes =
            r.where((m) => m.data.month == this.mesFiltro).toList();
      }

      this.carregando = false;
    });
  }

  void novoLancamento() {
    edicaoLancamento = LancamentoEntity(
      id: Uuid().generateV4(),
      categoria: "",
      conta: "",
      data: DateTime.now(),
      descricao: "",
      gasto: true,
      pago: false,
      codigoParcelamento: "",
      quantidadeParcelas: 1,
      parcela: 1,
      valor: "0,00",
    );
  }

  Future<int> salvarNovoLancamento() {
    this.carregando = true;

    if (edicaoLancamento.quantidadeParcelas > 1) {
      var parcelasLancamentos = new List<LancamentoEntity>();
      edicaoLancamento.codigoParcelamento = edicaoLancamento.id;
      parcelasLancamentos.add(edicaoLancamento);

      var mesParcela = edicaoLancamento.data.month;

      for (var i = 2; i <= edicaoLancamento.quantidadeParcelas; i++) {
        mesParcela++;

        parcelasLancamentos.add(new LancamentoEntity(
          categoria: edicaoLancamento.categoria,
          codigoParcelamento: edicaoLancamento.id,
          conta: edicaoLancamento.conta,
          data: new DateTime(edicaoLancamento.data.year, mesParcela,
              edicaoLancamento.data.day),
          descricao: edicaoLancamento.descricao,
          gasto: edicaoLancamento.gasto,
          id: Uuid().generateV4(),
          pago: edicaoLancamento.pago,
          quantidadeParcelas: edicaoLancamento.quantidadeParcelas,
          parcela: i,
          valor: edicaoLancamento.valor,
        ));
      }

      return _repository.inserirLista(parcelasLancamentos);
    } else {
      return _repository.inserir(edicaoLancamento);
    }
  }

  void editarLancamento({@required LancamentoEntity lancamento}) {
    edicaoLancamento = lancamento;
  }

  Future<int> salvarAlteracaoLancamento() {
    this.carregando = true;
    return _repository.alterar(edicaoLancamento);
  }

  Future<int> excluirLancamento({@required LancamentoEntity lancamento}) {
    this.carregando = true;
    return _repository.excluir(lancamento);
  }

  void mudarFiltroAno({int ano}) {
    this.anoFiltro = ano;
    buscarLancamentos();
  }

  void mudarFiltroMes({int mes}) {
    this.mesFiltro = mes;
    buscarLancamentos();
  }
}
