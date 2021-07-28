import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:progressao_financeira/controllers/base/base.controller.dart';
import 'package:progressao_financeira/models/entities/lancamento.entity.dart';
import 'package:progressao_financeira/models/utils/uuid.util.dart';
import 'package:progressao_financeira/repositories/lancamento.repository.dart';
import 'package:progressao_financeira/models/objects/progressao.object.dart';

class LancamentoController extends BaseController {
  final _repository = Get.put(LancamentoRepository());

  List<LancamentoEntity> _listaLancamentosAno = <LancamentoEntity>[].obs;
  List<LancamentoEntity> get listaLancamentosAno => this._listaLancamentosAno;

  List<ProgressaoObject> _listaProgressao = <ProgressaoObject>[].obs;
  List<ProgressaoObject> get listaProgressao => this._listaProgressao;

  List<LancamentoEntity> _listaLancamentosMes = <LancamentoEntity>[].obs;
  List<LancamentoEntity> get listaLancamentosMes => this._listaLancamentosMes;

  set listaLancamentosAno(List<LancamentoEntity> value) {
    this._listaLancamentosAno = value;
    this.somarTotalizadores(this._listaLancamentosAno);
    this._listaProgressao = ProgressaoObject.obterListaProgressao(
        this._listaLancamentosAno, this.anoFiltro);
  }

  set listaLancamentosMes(List<LancamentoEntity> value) {
    this._listaLancamentosMes = value;
  }

  final _edicaoLancamento = LancamentoEntity().obs;
  LancamentoEntity get edicaoLancamento => this._edicaoLancamento.value;
  set edicaoLancamento(LancamentoEntity value) =>
      this._edicaoLancamento.value = value;

  void buscarLancamentos() {
    carregando = true;

    _repository.listarTodosPorAno(anoFiltro).then((r) {
      listaLancamentosAno = new List<LancamentoEntity>.empty(growable: true);
      listaLancamentosMes = new List<LancamentoEntity>.empty(growable: true);

      if (r != null && r.length > 0) {
        listaLancamentosAno = r;
        listaLancamentosMes =
            r.where((m) => m.data.month == mesFiltro).toList();
      }

      carregando = false;
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
    carregando = true;

    if (edicaoLancamento.quantidadeParcelas > 1) {
      var parcelasLancamentos =
          new List<LancamentoEntity>.empty(growable: true);
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
    carregando = true;
    return _repository.alterar(edicaoLancamento);
  }

  Future<int> excluirLancamento({@required LancamentoEntity lancamento}) {
    carregando = true;
    return _repository.excluir(lancamento);
  }

  Future<int> excluirLancamentoTodasParcelas(
      {@required LancamentoEntity lancamento}) async {
    carregando = true;
    var lista = await _repository
        .listarTodosPorCodigoParcelamento(lancamento.codigoParcelamento);
    return _repository.excluirLista(lista);
  }

  void mudarFiltroAno({int ano}) {
    anoFiltro = ano;
    buscarLancamentos();
  }

  void mudarFiltroMes({int mes}) {
    mesFiltro = mes;
    buscarLancamentos();
  }
}
