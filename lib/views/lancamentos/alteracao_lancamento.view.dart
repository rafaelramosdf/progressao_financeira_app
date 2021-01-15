import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:progressao_financeira/controllers/lancamento.controller.dart';
import 'package:progressao_financeira/models/enums/tipoLancamento.enum.dart';
import 'package:progressao_financeira/widgets/cores/cores.widget.dart';
import 'package:progressao_financeira/widgets/datepicker/date_select.widget.dart';
import 'package:progressao_financeira/widgets/icones/icones.widget.dart';

class AlteracaoLancamentoView extends StatefulWidget {
  final _controller = Get.put(LancamentoController());

  @override
  _AlteracaoLancamentoViewState createState() =>
      _AlteracaoLancamentoViewState();
}

class _AlteracaoLancamentoViewState extends State<AlteracaoLancamentoView> {
  final _formKey = GlobalKey<FormState>();
  MoneyMaskedTextController _valorController = new MoneyMaskedTextController();
  TextEditingController _categoriaController = new TextEditingController();
  TextEditingController _contaController = new TextEditingController();
  TextEditingController _vencimentoController = new TextEditingController();
  TextEditingController _descricaoController = new TextEditingController();
  TipoLancamentoEnum _tipoLancamento = TipoLancamentoEnum.despesa;

  @override
  Widget build(BuildContext context) {
    _categoriaController.text = widget._controller.edicaoLancamento.categoria;
    _contaController.text = widget._controller.edicaoLancamento.conta;
    _descricaoController.text = widget._controller.edicaoLancamento.descricao;
    _tipoLancamento = widget._controller.edicaoLancamento.gasto
        ? TipoLancamentoEnum.despesa
        : TipoLancamentoEnum.receita;
    _valorController.text = widget._controller.edicaoLancamento.valor;
    _vencimentoController.text =
        new DateFormat.yMd().format(widget._controller.edicaoLancamento.data);

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
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Icon(IconesGO.lancamentos),
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
                            autofocus: true,
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
                              widget._controller.edicaoLancamento.valor = value;
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
                                fontSize: 18.0,
                              ),
                            ),
                            leading: Radio(
                              value: TipoLancamentoEnum.despesa,
                              groupValue: _tipoLancamento,
                              onChanged: (TipoLancamentoEnum value) {
                                _tipoLancamento = value;
                                widget._controller.edicaoLancamento.gasto =
                                    value == TipoLancamentoEnum.despesa;
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            title: Text(
                              'Recebi',
                              style: TextStyle(
                                color: Colors.green[700],
                                fontSize: 18.0,
                              ),
                            ),
                            leading: Radio(
                              value: TipoLancamentoEnum.receita,
                              groupValue: _tipoLancamento,
                              onChanged: (TipoLancamentoEnum value) {
                                _tipoLancamento = value;
                                widget._controller.edicaoLancamento.gasto =
                                    value == TipoLancamentoEnum.despesa;
                              },
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
                              widget._controller.edicaoLancamento.categoria =
                                  value;
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
                              widget._controller.edicaoLancamento.conta = value;
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
                              widget._controller.edicaoLancamento.data = date;
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
                              widget._controller.edicaoLancamento.descricao =
                                  value;
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
              widget._controller.salvarAlteracaoLancamento().then((r) {
                if (r > 0) {
                  Navigator.pop(context);
                  widget._controller.buscarLancamentos();
                }
              });
              Scaffold.of(context).showSnackBar(
                new SnackBar(
                  content: Text("Lançamento salvo com sucesso!"),
                ),
              );
            }
          },
          tooltip: 'Salvar Despesa / Receita',
          child: Icon(Icons.save),
        ));
  }
}
