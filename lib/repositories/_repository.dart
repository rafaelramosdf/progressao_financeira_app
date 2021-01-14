import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:progressao_financeira/repositories/lancamento.repository.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class Repository {
  Repository._(); // Construtor Privado
  static final Repository instancia = Repository._();

  static Database _banco;

  Future<Database> get banco async {
    if (_banco != null) return _banco;
    _banco = await iniciarBanco();
    return _banco;
  }

  Future<String> get _localPath async {
    final diretorio = await getApplicationDocumentsDirectory();
    return diretorio.path;
  }

  get _bancoPath async {
    String diretorioDocumentos = await _localPath;
    return join(diretorioDocumentos, "ProgressaoFinanceiraDB.db");
  }

  Future<bool> bancoExiste() async {
    return File(await _bancoPath).exists();
  }

  iniciarBanco() async {
    String path = await _bancoPath;
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        print("Repository:: Criando Banco de Dados...");
        await db.execute(LancamentoRepository.sqlCriarTabelaLancamento);
      },
    );
  }

  fecharBanco() {
    if (_banco != null) {
      _banco.close();
    }
  }
}
