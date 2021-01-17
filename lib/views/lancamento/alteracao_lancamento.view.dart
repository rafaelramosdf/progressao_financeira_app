import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:progressao_financeira/controllers/lancamento.controller.dart';
import 'package:progressao_financeira/models/enums/tipoLancamento.enum.dart';
import 'package:progressao_financeira/views/tabs.view.dart';
import 'package:progressao_financeira/widgets/cores/cores.widget.dart';
import 'package:progressao_financeira/widgets/datepicker/date_select.widget.dart';

class AlteracaoLancamentoView extends StatelessWidget {
  final _controller = Get.put(LancamentoController());

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    MoneyMaskedTextController _valorController =
        new MoneyMaskedTextController();
    TextEditingController _categoriaController = new TextEditingController();
    TextEditingController _contaController = new TextEditingController();
    TextEditingController _vencimentoController = new TextEditingController();
    TextEditingController _descricaoController = new TextEditingController();

    _categoriaController.text = _controller.edicaoLancamento.categoria;
    _contaController.text = _controller.edicaoLancamento.conta;
    _descricaoController.text = _controller.edicaoLancamento.descricao;
    _controller.tipoLancamento = _controller.edicaoLancamento.gasto
        ? TipoLancamentoEnum.despesa
        : TipoLancamentoEnum.receita;
    _valorController.text = _controller.edicaoLancamento.valor;
    _vencimentoController.text =
        new DateFormat.yMd().format(_controller.edicaoLancamento.data);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: CoresGO.azulEscuro,
          title: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                child: Text(
                  "Lançamento",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => Get.defaultDialog(
                    title: "Excluir?",
                    content: Text("Deseja excluir este lançamento?"),
                    textConfirm: "Sim",
                    textCancel: "Não",
                    confirmTextColor: Colors.white,
                    onConfirm: () {
                      _controller
                          .excluirLancamento(
                              lancamento: _controller.edicaoLancamento)
                          .then((r) {
                        if (r > 0) {
                          _controller.initialTabIndex = 2;
                          _controller.buscarLancamentos();
                          Navigator.pop(context);
                          Get.offAll(TabsView());
                          Get.snackbar(
                            "Sucesso!",
                            "Lançamento excluído com sucesso!",
                            backgroundColor: Colors.greenAccent,
                          );
                        }
                      });
                    },
                    barrierDismissible: true,
                  ),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.delete),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: ListView(
          padding: EdgeInsets.all(20.0),
          children: <Widget>[
            Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: TextFormField(
                            controller: _valorController,
                            style: TextStyle(fontSize: 32.0),
                            autofocus: false,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.attach_money),
                              border: OutlineInputBorder(),
                              hintText: "0,00",
                            ),
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  double.tryParse(value) == 0.0)
                                return "Informe o valor!";
                              else
                                return null;
                            },
                            onSaved: (value) {
                              _controller.edicaoLancamento.valor = value;
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: ListTile(
                            title: Text(
                              'Gastei',
                              style: TextStyle(
                                color: CoresGO.rosa,
                                fontSize: 14.0,
                              ),
                            ),
                            leading: Obx(
                              () => Radio(
                                value: TipoLancamentoEnum.despesa,
                                groupValue: _controller.tipoLancamento,
                                onChanged: (TipoLancamentoEnum value) {
                                  _controller.tipoLancamento = value;
                                  _controller.edicaoLancamento.gasto =
                                      value == TipoLancamentoEnum.despesa;
                                },
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            title: Text(
                              'Recebi',
                              style: TextStyle(
                                color: Colors.green[700],
                                fontSize: 14.0,
                              ),
                            ),
                            leading: Obx(
                              () => Radio(
                                value: TipoLancamentoEnum.receita,
                                groupValue: _controller.tipoLancamento,
                                onChanged: (TipoLancamentoEnum value) {
                                  _controller.tipoLancamento = value;
                                  _controller.edicaoLancamento.gasto =
                                      value == TipoLancamentoEnum.despesa;
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: TextFormField(
                            controller: _categoriaController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.label),
                              border: OutlineInputBorder(),
                              hintText: "Categoria...",
                            ),
                            validator: (value) {
                              if (value.isEmpty)
                                return "Informe a categoria!";
                              else
                                return null;
                            },
                            onSaved: (value) {
                              _controller.edicaoLancamento.categoria = value;
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: TextFormField(
                            controller: _contaController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.account_balance),
                              border: OutlineInputBorder(),
                              hintText: "Conta...",
                            ),
                            validator: (value) {
                              if (value.isEmpty)
                                return "Informe a conta!";
                              else
                                return null;
                            },
                            onSaved: (value) {
                              _controller.edicaoLancamento.conta = value;
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: TextFormField(
                            controller: _vencimentoController,
                            readOnly: true,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.calendar_today),
                              border: OutlineInputBorder(),
                              hintText: "Vencimento...",
                            ),
                            onTap: () async {
                              var date =
                                  await DateSelectWidget.selectDate(context);
                              _vencimentoController.text =
                                  new DateFormat.yMd().format(date);
                              _controller.edicaoLancamento.data = date;
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: TextFormField(
                            controller: _descricaoController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.description),
                              border: OutlineInputBorder(),
                              hintText: "Descrição...",
                            ),
                            onSaved: (value) {
                              _controller.edicaoLancamento.descricao = value;
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.greenAccent[700],
          onPressed: () {
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();
              _controller.salvarAlteracaoLancamento().then((r) {
                if (r > 0) {
                  _controller.buscarLancamentos();
                  Navigator.pop(context);
                  Get.snackbar(
                    "Sucesso!",
                    "Lançamento alterado com sucesso!",
                    backgroundColor: Colors.greenAccent,
                  );
                }
              });
            }
          },
          tooltip: 'Salvar Despesa / Receita',
          child: Icon(Icons.save),
        ));
  }
}