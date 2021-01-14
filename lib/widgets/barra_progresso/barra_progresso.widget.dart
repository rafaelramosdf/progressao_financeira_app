import 'package:flutter/material.dart';

class BarraProgressoGO extends StatelessWidget {
  final Color corBarra;
  final double progresso;
  final String titulo;
  final Color corTitulo;

  final _height = 12.0;

  BarraProgressoGO({
    @required this.corBarra,
    @required this.progresso,
    this.titulo: "",
    this.corTitulo: Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Stack(
                children: [
                  Container(
                    height: _height,
                    color: Colors.grey.withOpacity(0.1),
                  ),
                  AnimatedContainer(
                    height: _height,
                    width: ((progresso / constraints.maxWidth) / 100) *
                        constraints.maxWidth,
                    color: corBarra,
                    duration: Duration(milliseconds: 300),
                  ),
                ],
              );
            },
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 8.0),
          child: Text(
            titulo,
            style: TextStyle(
              color: corTitulo,
            ),
          ),
        )
      ],
    );
  }
}
