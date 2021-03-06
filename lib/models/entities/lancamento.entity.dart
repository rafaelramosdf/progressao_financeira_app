import 'dart:convert';
import 'package:progressao_financeira/models/utils/uuid.util.dart';

LancamentoEntity lancamentoModelFromJson(String str) =>
    LancamentoEntity.fromJson(json.decode(str));

String lancamentoModelToJson(LancamentoEntity data) =>
    json.encode(data.toJson());

class LancamentoEntity {
  String id;
  String valor;
  bool gasto;
  String categoria;
  String conta;
  DateTime data;
  String descricao;
  String codigoParcelamento;
  int quantidadeParcelas;
  int parcela;
  bool pago;

  LancamentoEntity({
    String id,
    this.valor,
    this.gasto,
    this.categoria,
    this.conta,
    this.data,
    this.descricao,
    this.codigoParcelamento,
    this.quantidadeParcelas,
    this.parcela,
    this.pago,
  }) : this.id = id ?? Uuid().generateV4();

  factory LancamentoEntity.fromJson(Map<String, dynamic> json) =>
      new LancamentoEntity(
        id: json["id"],
        valor: json["valor"],
        gasto: json["gasto"] > 0,
        categoria: json["categoria"],
        conta: json["conta"],
        data: DateTime.parse(json["data"]),
        descricao: json["descricao"],
        codigoParcelamento: json["codigoParcelamento"],
        quantidadeParcelas: json["quantidadeParcelas"],
        parcela: json["parcela"],
        pago: json["pago"] > 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "valor": valor,
        "gasto": gasto ? 1 : 0,
        "categoria": categoria,
        "conta": conta,
        "data":
            "${data.year.toString().padLeft(4, '0')}-${data.month.toString().padLeft(2, '0')}-${data.day.toString().padLeft(2, '0')}",
        "descricao": descricao,
        "codigoParcelamento": codigoParcelamento,
        "quantidadeParcelas": quantidadeParcelas,
        "parcela": parcela,
        "pago": pago ? 1 : 0,
      };
}
