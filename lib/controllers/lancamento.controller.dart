import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:progressao_financeira/controllers/base/base.controller.dart';
import 'package:progressao_financeira/models/entities/lancamento.entity.dart';
import 'package:progressao_financeira/models/utils/uuid.util.dart';
import 'package:progressao_financeira/repositories/lancamento.repository.dart';

class LancamentoController extends BaseController {
  final _repository = Get.put(LancamentoRepository());

  List<LancamentoEntity> _listaLancamentosAno = List<LancamentoEntity>().obs;
  List<LancamentoEntity> get listaLancamentosAno => this._listaLancamentosAno;
  set listaLancamentosAno(List<LancamentoEntity> value) {
    this._listaLancamentosAno = value;
    this.somarTotalizadores(this._listaLancamentosAno);
  }

  List<LancamentoEntity> _listaLancamentosMes = List<LancamentoEntity>().obs;
  List<LancamentoEntity> get listaLancamentosMes => this._listaLancamentosMes;
  set listaLancamentosMes(List<LancamentoEntity> value) {
    this._listaLancamentosMes = value;
    this.somarTotalizadores(this._listaLancamentosMes);
  }

  final _edicaoLancamento = LancamentoEntity().obs;
  LancamentoEntity get edicaoLancamento => this._edicaoLancamento.value;
  set edicaoLancamento(LancamentoEntity value) =>
      this._edicaoLancamento.value = value;

  void buscarLancamentosAno() {
    this.carregando = true;
    _repository.listarTodosPorAno(this.anoFiltro).then((r) {
      listaLancamentosAno = r;
      this.carregando = false;
    });
  }

  void buscarLancamentosMes() {
    this.carregando = true;
    _repository.listarTodosPorMes(this.anoFiltro, this.mesFiltro).then((r) {
      listaLancamentosMes = r;
      this.carregando = false;
    });
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
      valor: "0,00",
    );
  }

  Future<int> salvarNovoLancamento() {
    this.carregando = true;
    return _repository.inserir(edicaoLancamento);
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
    buscarLancamentosAno();
    buscarLancamentosMes();
  }

  void mudarFiltroMes({int mes}) {
    this.mesFiltro = mes;
    buscarLancamentosMes();
  }
}
