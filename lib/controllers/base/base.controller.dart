import 'package:get/get.dart';
import 'package:progressao_financeira/models/entities/lancamento.entity.dart';
import 'package:progressao_financeira/models/enums/tipoLancamento.enum.dart';
import 'package:progressao_financeira/models/utils/extensions.util.dart';

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

  final _totalSaldoAno = 0.0.obs;
  double get totalSaldoAno => this._totalSaldoAno.value;
  set totalSaldoAno(double value) => this._totalSaldoAno.value = value;

  final _totalRecebidoMes = 0.0.obs;
  double get totalRecebidoMes => this._totalRecebidoMes.value;
  set totalRecebidoMes(double value) => this._totalRecebidoMes.value = value;

  final _totalGastoMes = 0.0.obs;
  double get totalGastoMes => this._totalGastoMes.value;
  set totalGastoMes(double value) => this._totalGastoMes.value = value;

  final _totalSaldoMes = 0.0.obs;
  double get totalSaldoMes => this._totalSaldoMes.value;
  set totalSaldoMes(double value) => this._totalSaldoMes.value = value;

  final _tipoLancamento = TipoLancamentoEnum.despesa.obs;
  TipoLancamentoEnum get tipoLancamento => this._tipoLancamento.value;
  set tipoLancamento(TipoLancamentoEnum value) =>
      this._tipoLancamento.value = value;

  final _carregando = false.obs;
  bool get carregando => this._carregando.value;
  set carregando(bool value) => this._carregando.value = value;

  final _initialTabIndex = 0.obs;
  int get initialTabIndex => this._initialTabIndex.value;
  set initialTabIndex(int value) => this._initialTabIndex.value = value;

  void somarTotalizadores(List<LancamentoEntity> listaLancamentosAno) {
    this.totalGastoAno = 0.0;
    this.totalGastoMes = 0.0;
    this.totalRecebidoAno = 0.0;
    this.totalRecebidoMes = 0.0;
    this.totalSaldoAno = 0.0;
    this.totalSaldoMes = 0.0;

    if (listaLancamentosAno != null && listaLancamentosAno.length > 0) {
      var listaLancamentosMes = listaLancamentosAno
          .where((m) => m.data.month == this.mesFiltro)
          .toList();

      listaLancamentosMes.forEach((m) {
        if (m.gasto) {
          this.totalGastoMes += m.valor.toDouble();
        } else {
          this.totalRecebidoMes += m.valor.toDouble();
        }
      });
      this.totalSaldoMes = this.totalRecebidoMes - this.totalGastoMes;

      listaLancamentosAno.forEach((m) {
        if (m.gasto) {
          this.totalGastoAno += m.valor.toDouble();
        } else {
          this.totalRecebidoAno += m.valor.toDouble();
        }
      });
      this.totalSaldoAno = this.totalRecebidoAno - this.totalGastoAno;
    }
  }
}
