import 'package:get/get.dart';
import 'package:progressao_financeira/views/lancamento/alteracao_lancamento.view.dart';
import 'package:progressao_financeira/views/lancamento/inclusao_lancamento.view.dart';
import 'package:progressao_financeira/views/tabs.view.dart';
part './app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.INITIAL,
      page: () => TabsView(),
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
