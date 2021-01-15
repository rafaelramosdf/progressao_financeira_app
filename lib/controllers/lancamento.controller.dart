import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:progressao_financeira/controllers/_global.controller.dart';
import 'package:progressao_financeira/models/entities/lancamento.entity.dart';
import 'package:progressao_financeira/models/utils/uuid.util.dart';
import 'package:progressao_financeira/repositories/lancamento.repository.dart';

class LancamentoController extends GetxController {
  final _repository = Get.put(LancamentoRepository());
  final _globalController = Get.put(GlobalController());

  List<LancamentoEntity> _listaLancamentos = List<LancamentoEntity>().obs;
  List<LancamentoEntity> get listaLancamentos => this._listaLancamentos;
  set listaLancamentos(List<LancamentoEntity> value) =>
      this._listaLancamentos = value;

  final _edicaoLancamento = LancamentoEntity().obs;
  LancamentoEntity get edicaoLancamento => this._edicaoLancamento.value;
  set edicaoLancamento(LancamentoEntity value) =>
      this._edicaoLancamento.value = value;

  void buscarLancamentos() {
    _globalController.carregando = true;
    _repository.listarTodos().then((r) {
      listaLancamentos = r;
      _globalController.carregando = false;
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
    _globalController.carregando = true;
    return _repository.inserir(edicaoLancamento);
  }

  void editarLancamento({@required LancamentoEntity lancamento}) {
    edicaoLancamento = lancamento;
  }

  Future<int> salvarAlteracaoLancamento() {
    _globalController.carregando = true;
    return _repository.alterar(edicaoLancamento);
  }

  void mudarFiltroAno({int ano}) {
    _globalController.anoFiltro = ano;
    buscarLancamentos();
  }

  void mudarFiltroMes({int mes}) {
    _globalController.mesFiltro = mes;
    buscarLancamentos();
  }
}
