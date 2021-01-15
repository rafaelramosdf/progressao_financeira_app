import 'package:get/get.dart';
import 'package:progressao_financeira/models/enums/tipoLancamento.enum.dart';

class GlobalController extends GetxController {
  static GlobalController get instance => Get.find<GlobalController>();

  var _dataAtual = DateTime.now();
  DateTime get dataAtual => this._dataAtual;
  set dataAtual(DateTime value) {
    this._dataAtual = value;
    update();
  }

  var _anoFiltro = DateTime.now().year;
  int get anoFiltro => this._anoFiltro;
  set anoFiltro(int value) {
    this._anoFiltro = value;
    update();
  }

  var _mesFiltro = DateTime.now().month;
  int get mesFiltro => this._mesFiltro;
  set mesFiltro(int value) {
    this._mesFiltro = value;
    update();
  }

  var _totalRecebidoAno = 0.0;
  double get totalRecebidoAno => this._totalRecebidoAno;
  set totalRecebidoAno(double value) {
    this._totalRecebidoAno = value;
    update();
  }

  var _totalGastoAno = 0.0;
  double get totalGastoAno => this._totalGastoAno;
  set totalGastoAno(double value) {
    this._totalGastoAno = value;
    update();
  }

  var totalSaldoAno = 0.0;

  var totalRecebidoMes = 0.0;

  var totalGastoMes = 0.0;

  var totalSaldoMes = 0.0;

  var _tipoLancamento = TipoLancamentoEnum.despesa;
  TipoLancamentoEnum get tipoLancamento => this._tipoLancamento;
  set tipoLancamento(TipoLancamentoEnum value) {
    this._tipoLancamento = value;
    update();
  }

  var _carregando = false;
  bool get carregando => this._carregando;
  set carregando(bool value) {
    this._carregando = value;
    update();
  }
}
