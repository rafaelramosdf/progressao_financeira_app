import 'package:progressao_financeira/models/entities/lancamento.entity.dart';
import 'package:progressao_financeira/repositories/_repository.dart';

class LancamentoRepository {
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
      "parcelado INTEGER NOT NULL DEFAULT 0,"
      "parcelas INTEGER NOT NULL DEFAULT 0,"
      "pago INTEGER NOT NULL DEFAULT 0"
      ")";

  // Inserir
  Future<int> inserir(LancamentoEntity lancamentoModel) async {
    final db = await Repository.instancia.banco;
    return db.insert(tabelaLancamento, lancamentoModel.toJson());
  }

  // Alterar
  Future<int> alterar(LancamentoEntity lancamentoModel) async {
    final db = await Repository.instancia.banco;
    return db.update(tabelaLancamento, lancamentoModel.toJson(),
        where: 'id = ?', whereArgs: [lancamentoModel.id]);
  }

  // Excluir
  Future<void> excluir(LancamentoEntity lancamentoModel) async {
    final db = await Repository.instancia.banco;
    return db.delete(tabelaLancamento,
        where: 'id = ?', whereArgs: [lancamentoModel.id]);
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

  // Listar Todos
  Future<List<LancamentoEntity>> listarTodos() async {
    final db = await Repository.instancia.banco;
    var query = await db.query(tabelaLancamento);
    return query.map((m) => LancamentoEntity.fromJson(m)).toList();
  }

  // Inserir Lista
  inserirLista(List<LancamentoEntity> lista) async {
    final db = await Repository.instancia.banco;
    lista.forEach((m) async {
      var resultado = await db.insert(tabelaLancamento, m.toJson());
      print('Lancamento: ${m.id} = $resultado');
    });
  }
}
