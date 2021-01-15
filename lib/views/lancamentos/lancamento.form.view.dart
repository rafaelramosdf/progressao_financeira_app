// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_masked_text/flutter_masked_text.dart';
// import 'package:intl/intl.dart';
// import 'package:progressao_financeira/models/enums/tipoAcao.enum.dart';
// import 'package:progressao_financeira/models/enums/tipoLancamento.enum.dart';
// import 'package:progressao_financeira/widgets/cores/cores.widget.dart';
// import 'package:progressao_financeira/widgets/datepicker/date_select.widget.dart';
// import 'package:progressao_financeira/widgets/icones/icones.widget.dart';

// class LancamentoFormView extends StatefulWidget {
//   final TipoAcaoEnum acao;
//   LancamentoFormView({@required this.acao});
//   @override
//   _LancamentoFormPageState createState() => _LancamentoFormPageState();
// }

// class _LancamentoFormPageState extends State<LancamentoFormView> {
//   final _formKey = GlobalKey<FormState>();
//   MoneyMaskedTextController _valorController = new MoneyMaskedTextController();
//   TextEditingController _categoriaController = new TextEditingController();
//   TextEditingController _contaController = new TextEditingController();
//   TextEditingController _vencimentoController = new TextEditingController();
//   TextEditingController _descricaoController = new TextEditingController();
//   TipoLancamentoEnum _tipoLancamento = TipoLancamentoEnum.despesa;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: CoresGO.azulEscuro,
//         title: Row(
//           mainAxisSize: MainAxisSize.max,
//           children: <Widget>[
//             Expanded(
//               child: Text(
//                 "Lançamento",
//                 textAlign: TextAlign.left,
//                 style: TextStyle(
//                   fontSize: 18.0,
//                 ),
//               ),
//             ),
//             Expanded(
//               child: Align(
//                 alignment: Alignment.centerRight,
//                 child: Icon(IconesGO.lancamentos),
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: ListView(
//         padding: EdgeInsets.all(20.0),
//         children: <Widget>[
//           Form(
//             key: _formKey,
//             child: Consumer<LancamentoBloc>(
//               builder: (context, lancamentoBloc, child) {
//                 _categoriaController.text =
//                     lancamentoBloc.edicaoLancamento.categoria;
//                 _contaController.text = lancamentoBloc.edicaoLancamento.conta;
//                 _descricaoController.text =
//                     lancamentoBloc.edicaoLancamento.descricao;
//                 _tipoLancamento = lancamentoBloc.edicaoLancamento.gasto
//                     ? TipoLancamentoEnum.despesa
//                     : TipoLancamentoEnum.receita;
//                 _valorController.text = lancamentoBloc.edicaoLancamento.valor;
//                 _vencimentoController.text = new DateFormat.yMd()
//                     .format(lancamentoBloc.edicaoLancamento.data);

//                 return Column(
//                   children: <Widget>[
//                     Row(
//                       children: <Widget>[
//                         Expanded(
//                           child: TextFormField(
//                             controller: _valorController,
//                             style: TextStyle(fontSize: 32.0),
//                             autofocus: true,
//                             keyboardType: TextInputType.number,
//                             decoration: InputDecoration(
//                               prefixIcon: Icon(Icons.attach_money),
//                               border: OutlineInputBorder(),
//                               hintText: "0,00",
//                             ),
//                             validator: (value) {
//                               if (value == null ||
//                                   value.isEmpty ||
//                                   double.tryParse(value) == 0.0)
//                                 return "Informe o valor!";
//                               else
//                                 return null;
//                             },
//                             onSaved: (value) {
//                               setState(() {
//                                 lancamentoBloc.edicaoLancamento.valor = value;
//                               });
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       children: <Widget>[
//                         Expanded(
//                           child: ListTile(
//                             title: Text(
//                               'Gastei',
//                               style: TextStyle(
//                                 color: CoresGO.rosa,
//                                 fontSize: 18.0,
//                               ),
//                             ),
//                             leading: Radio(
//                               value: TipoLancamentoEnum.despesa,
//                               groupValue: _tipoLancamento,
//                               onChanged: (TipoLancamentoEnum value) {
//                                 setState(() {
//                                   _tipoLancamento = value;
//                                   lancamentoBloc.edicaoLancamento.gasto =
//                                       value == TipoLancamentoEnum.despesa;
//                                 });
//                               },
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           child: ListTile(
//                             title: Text(
//                               'Recebi',
//                               style: TextStyle(
//                                 color: Colors.green[700],
//                                 fontSize: 18.0,
//                               ),
//                             ),
//                             leading: Radio(
//                               value: TipoLancamentoEnum.receita,
//                               groupValue: _tipoLancamento,
//                               onChanged: (TipoLancamentoEnum value) {
//                                 setState(() {
//                                   _tipoLancamento = value;
//                                   lancamentoBloc.edicaoLancamento.gasto =
//                                       value == TipoLancamentoEnum.despesa;
//                                 });
//                               },
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       children: <Widget>[
//                         Expanded(
//                           child: TextFormField(
//                             controller: _categoriaController,
//                             decoration: InputDecoration(
//                               prefixIcon: Icon(Icons.label),
//                               border: OutlineInputBorder(),
//                               hintText: "Categoria...",
//                             ),
//                             validator: (value) {
//                               if (value.isEmpty)
//                                 return "Informe a categoria!";
//                               else
//                                 return null;
//                             },
//                             onSaved: (value) {
//                               setState(() {
//                                 lancamentoBloc.edicaoLancamento.categoria =
//                                     value;
//                               });
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 10.0),
//                     Row(
//                       children: <Widget>[
//                         Expanded(
//                           child: TextFormField(
//                             controller: _contaController,
//                             decoration: InputDecoration(
//                               prefixIcon: Icon(Icons.account_balance),
//                               border: OutlineInputBorder(),
//                               hintText: "Conta...",
//                             ),
//                             validator: (value) {
//                               if (value.isEmpty)
//                                 return "Informe a conta!";
//                               else
//                                 return null;
//                             },
//                             onSaved: (value) {
//                               setState(() {
//                                 lancamentoBloc.edicaoLancamento.conta = value;
//                               });
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 10.0),
//                     Row(
//                       children: <Widget>[
//                         Expanded(
//                           child: TextFormField(
//                             controller: _vencimentoController,
//                             readOnly: true,
//                             decoration: InputDecoration(
//                               prefixIcon: Icon(Icons.calendar_today),
//                               border: OutlineInputBorder(),
//                               hintText: "Vencimento...",
//                             ),
//                             onTap: () async {
//                               setState(() async {
//                                 var date =
//                                     await DateSelectWidget.selectDate(context);
//                                 _vencimentoController.text =
//                                     new DateFormat.yMd().format(date);
//                                 lancamentoBloc.edicaoLancamento.data = date;
//                               });
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 10.0),
//                     Row(
//                       children: <Widget>[
//                         Expanded(
//                           child: TextFormField(
//                             controller: _descricaoController,
//                             decoration: InputDecoration(
//                               prefixIcon: Icon(Icons.description),
//                               border: OutlineInputBorder(),
//                               hintText: "Descrição...",
//                             ),
//                             onSaved: (value) {
//                               setState(() {
//                                 lancamentoBloc.edicaoLancamento.descricao =
//                                     value;
//                               });
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: Consumer<LancamentoBloc>(
//         builder: (context, lancamentoBloc, child) {
//           return FloatingActionButton(
//             backgroundColor: Colors.greenAccent[700],
//             onPressed: () {
//               if (_formKey.currentState.validate()) {
//                 _formKey.currentState.save();
//                 lancamentoBloc.salvarLancamento(acao: widget.acao).then((r) {
//                   if (r > 0) {
//                     Navigator.pop(context);
//                     lancamentoBloc.buscarLancamentos();
//                   }
//                 });
//                 Scaffold.of(context).showSnackBar(
//                   new SnackBar(
//                     content: Text("Lançamento salvo com sucesso!"),
//                   ),
//                 );
//               }
//             },
//             tooltip: 'Salvar Despesa / Receita',
//             child: Icon(Icons.save),
//           );
//         },
//       ),
//     );
//   }
// }
