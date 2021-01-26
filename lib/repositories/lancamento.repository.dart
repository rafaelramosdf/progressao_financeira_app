import 'package:get/get.dart';
import 'package:progressao_financeira/models/entities/lancamento.entity.dart';
import 'package:progressao_financeira/repositories/_repository.dart';

class LancamentoRepository {
  static LancamentoRepository get instance => Get.find<LancamentoRepository>();

  static final String tabelaLancamento = "Lancamento";
  static final String sqlCriarTabelaLancamento =
      "CREATE TABLE $tabelaLancamento ("
      "id TEXT PRIMARY KEY,"
      "valor REAL,"
      "gasto INTEGER NOT NULL DEFAULT 1,"
      "categoria TEXT,"
      "conta TEXT,"
      "data TEXT,"
      "descricao TEXT,"
      "codigoParcelamento TEXT,"
      "quantidadeParcelas INTEGER NOT NULL DEFAULT 1,"
      "parcela INTEGER NOT NULL DEFAULT 1,"
      "pago INTEGER NOT NULL DEFAULT 0"
      ")";

  // Inserir
  Future<int> inserir(LancamentoEntity lancamentoModel) async {
    final db = await Repository.instancia.banco;
    return db.insert(tabelaLancamento, lancamentoModel.toJson());
  }

  Future<int> inserirLista(List<LancamentoEntity> lista) async {
    Future<int> resultado;
    final db = await Repository.instancia.banco;
    lista.forEach((m) async {
      resultado = db.insert(tabelaLancamento, m.toJson());
    });
    return resultado;
  }

  // Alterar
  Future<int> alterar(LancamentoEntity lancamentoModel) async {
    final db = await Repository.instancia.banco;
    return db.update(tabelaLancamento, lancamentoModel.toJson(),
        where: 'id = ?', whereArgs: [lancamentoModel.id]);
  }

  // Excluir
  Future<int> excluir(LancamentoEntity lancamentoModel) async {
    final db = await Repository.instancia.banco;
    return db.delete(tabelaLancamento,
        where: 'id = ?', whereArgs: [lancamentoModel.id]);
  }

  Future<int> excluirLista(List<LancamentoEntity> lista) async {
    Future<int> resultado;
    final db = await Repository.instancia.banco;
    lista.forEach((m) async {
      resultado =
          db.delete(tabelaLancamento, where: 'id = ?', whereArgs: [m.id]);
    });
    return resultado;
  }

  // Listar
  Future<LancamentoEntity> listar(String id) async {
    final db = await Repository.instancia.banco;
    List<Map> resultado =
        await db.query(tabelaLancamento, where: 'id = ?', whereArgs: [id]);
    if (resultado.length > 0) {
      return LancamentoEntity.fromJson(resultado.first);
    }
    return null;
  }

  Future<List<LancamentoEntity>> listarTodos() async {
    final db = await Repository.instancia.banco;
    var query = await db.query(tabelaLancamento, orderBy: "data desc");
    return query.map((m) => LancamentoEntity.fromJson(m)).toList();
  }

  Future<List<LancamentoEntity>> listarTodosPorAno(int ano) async {
    final db = await Repository.instancia.banco;
    var query = await db.query(tabelaLancamento,
        where: 'data >= "$ano-01-01" and data <= "$ano-12-31"',
        orderBy: "data desc");
    return query.map((m) => LancamentoEntity.fromJson(m)).toList();
  }

  Future<List<LancamentoEntity>> listarTodosPorMes(int ano, int mes) async {
    var mesSeguinte = mes + 1;
    var anoSeguinte = ano + 1;
    var queryMesSeguinte = "";

    if (mesSeguinte < 13) {
      queryMesSeguinte =
          'data < "$ano-${mesSeguinte.toString().padLeft(2, '0')}-01"';
    } else {
      queryMesSeguinte = 'data < "$anoSeguinte-01-01"';
    }

    final db = await Repository.instancia.banco;
    var query = await db.query(tabelaLancamento,
        where:
            'data >= "$ano-${mes.toString().padLeft(2, '0')}-01" and $queryMesSeguinte',
        orderBy: "data desc");

    return query.map((m) => LancamentoEntity.fromJson(m)).toList();
  }

  Future<List<LancamentoEntity>> listarTodosPorCodigoParcelamento(
    String codigoParcelamento,
  ) async {
    final db = await Repository.instancia.banco;
    var query = await db.query(tabelaLancamento,
        where: 'codigoParcelamento = "$codigoParcelamento"', orderBy: "data");
    return query.map((m) => LancamentoEntity.fromJson(m)).toList();
  }
}
