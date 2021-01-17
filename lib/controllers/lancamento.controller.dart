import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:progressao_financeira/controllers/base/base.controller.dart';
import 'package:progressao_financeira/models/entities/lancamento.entity.dart';
import 'package:progressao_financeira/models/utils/uuid.util.dart';
import 'package:progressao_financeira/repositories/lancamento.repository.dart';

class LancamentoController extends BaseController {
  final _repository = Get.put(LancamentoRepository());

  List<LancamentoEntity> _listaLancamentos = List<LancamentoEntity>().obs;
  List<LancamentoEntity> get listaLancamentos => this._listaLancamentos;
  set listaLancamentos(List<LancamentoEntity> value) =>
      this._listaLancamentos = value;

  final _edicaoLancamento = LancamentoEntity().obs;
  LancamentoEntity get edicaoLancamento => this._edicaoLancamento.value;
  set edicaoLancamento(LancamentoEntity value) =>
      this._edicaoLancamento.value = value;

  void buscarLancamentos() {
    this.carregando = true;
    _repository.listarTodos().then((r) {
      listaLancamentos = r;
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
      valor: "",
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
    buscarLancamentos();
  }

  void mudarFiltroMes({int mes}) {
    this.mesFiltro = mes;
    buscarLancamentos();
  }
}
