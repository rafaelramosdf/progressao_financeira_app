import 'package:intl/intl.dart';
import 'package:progressao_financeira/models/entities/lancamento.entity.dart';
import 'package:progressao_financeira/models/utils/extensions.util.dart';

class ProgressaoObject {
  int ano = DateTime.now().year;

  String get mes =>
      new DateFormat().add_MMMM().format(new DateTime(ano, mesCodigo, 1));

  int mesCodigo = 1;
  double totalRecebido = 0.0;
  double totalGasto = 0.0;
  double totalSaldo = 0.0;

  ProgressaoObject(
    this.ano,
    this.mesCodigo,
    this.totalRecebido,
    this.totalGasto,
    this.totalSaldo,
  );

  static List<ProgressaoObject> obterListaProgressao(
      List<LancamentoEntity> listaLancamentos, int ano) {
    var listaProgressao = <ProgressaoObject>[];
    for (var mes = 1; mes <= 12; mes++) {
      var recebido = 0.0;
      var gasto = 0.0;
      var saldo = 0.0;

      if (listaLancamentos != null && listaLancamentos.length > 0) {
        var listaLancamentoMes =
            listaLancamentos.where((m) => m.data.month == mes).toList();

        listaLancamentoMes.forEach((m) {
          if (m.gasto)
            gasto += m.valor.toDouble();
          else
            recebido += m.valor.toDouble();
        });

        saldo = recebido - gasto;

        listaProgressao
            .add(new ProgressaoObject(ano, mes, recebido, gasto, saldo));
      }
    }
    return listaProgressao;
  }
}
