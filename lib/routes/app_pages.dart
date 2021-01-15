import 'package:get/get.dart';
import 'package:progressao_financeira/views/lancamentos/alteracao_lancamento.view.dart';
import 'package:progressao_financeira/views/lancamentos/inclusao_lancamento.view.dart';
import 'package:progressao_financeira/views/lancamentos/lancamento.list.view.dart';
import 'package:progressao_financeira/views/resumo/resumo.view.dart';
part './app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.INITIAL,
      page: () => ResumoView(),
    ),
    GetPage(
      name: Routes.LANCAMENTO_LIST,
      page: () => LancamentoListView(),
    ),
    GetPage(
      name: Routes.LANCAMENTO_INCLUSAO,
      page: () => InclusaoLancamentoView(),
    ),
    GetPage(
      name: Routes.LANCAMENTO_ALTERACAO,
      page: () => AlteracaoLancamentoView(),
    ),
  ];
}
