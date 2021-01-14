import 'package:flutter/material.dart';
import 'package:progressao_financeira/blocs/lancamento.bloc.dart';
import 'package:progressao_financeira/models/entities/lancamento.entity.dart';
import 'package:progressao_financeira/models/enums/tipoAcao.enum.dart';
import 'package:progressao_financeira/views/lancamentos/lancamento.form.view.dart';
import 'package:progressao_financeira/widgets/cores/cores.widget.dart';
import 'package:provider/provider.dart';

class CardLancamentoGO extends StatefulWidget {
  final LancamentoEntity lancamento;
  CardLancamentoGO({this.lancamento});

  @override
  _CardLancamentoGOState createState() => _CardLancamentoGOState();
}

class _CardLancamentoGOState extends State<CardLancamentoGO> {
  Color _corTextoCategoria;

  @override
  void initState() {
    if (widget.lancamento.gasto)
      _corTextoCategoria = CoresGO.rosa;
    else
      _corTextoCategoria = CoresGO.verde;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<LancamentoBloc>(context)
            .editarLancamento(lancamento: widget.lancamento);

        Navigator.push(
          context,
          new MaterialPageRoute(
            builder: (context) => LancamentoFormView(
              acao: TipoAcaoEnum.alterar,
            ),
          ),
        );
      },
      child: Card(
        elevation: 1.0,
        color: CoresGO.azulEscuro,
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Text(
                      "${widget.lancamento.data.day}/${widget.lancamento.data.month}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18.0,
                        color: CoresGO.branco,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(
                          widget.lancamento.categoria,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: _corTextoCategoria,
                          ),
                        ),
                        Text(
                          widget.lancamento.descricao,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400,
                            color: CoresGO.branco,
                          ),
                        ),
                        Text(
                          widget.lancamento.conta,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w400,
                              color: CoresGO.azulClaro),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      widget.lancamento.valor.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: _corTextoCategoria,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
