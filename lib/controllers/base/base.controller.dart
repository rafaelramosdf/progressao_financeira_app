import 'package:get/get.dart';
import 'package:progressao_financeira/models/enums/tipoLancamento.enum.dart';

abstract class BaseController extends GetxController {
  final _dataAtual = DateTime.now().obs;
  DateTime get dataAtual => this._dataAtual.value;
  set dataAtual(DateTime value) => this._dataAtual.value = value;

  final _anoFiltro = DateTime.now().year.obs;
  int get anoFiltro => this._anoFiltro.value;
  set anoFiltro(int value) => this._anoFiltro.value = value;

  final _mesFiltro = DateTime.now().month.obs;
  int get mesFiltro => this._mesFiltro.value;
  set mesFiltro(int value) => this._mesFiltro.value = value;

  final _totalRecebidoAno = 0.0.obs;
  double get totalRecebidoAno => this._totalRecebidoAno.value;
  set totalRecebidoAno(double value) => this._totalRecebidoAno.value = value;

  final _totalGastoAno = 0.0.obs;
  double get totalGastoAno => this._totalGastoAno.value;
  set totalGastoAno(double value) => this._totalGastoAno.value = value;

  var totalSaldoAno = 0.0;

  var totalRecebidoMes = 0.0;

  var totalGastoMes = 0.0;

  var totalSaldoMes = 0.0;

  final _tipoLancamento = TipoLancamentoEnum.despesa.obs;
  TipoLancamentoEnum get tipoLancamento => this._tipoLancamento.value;
  set tipoLancamento(TipoLancamentoEnum value) =>
      this._tipoLancamento.value = value;

  final _carregando = false.obs;
  bool get carregando => this._carregando.value;
  set carregando(bool value) => this._carregando.value = value;
}
