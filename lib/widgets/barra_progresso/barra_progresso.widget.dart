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
        Container(
          width: 60.0,
          child: Text(
            titulo,
            style: TextStyle(
              color: corTitulo,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        Expanded(
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Stack(
                children: [
                  Container(
                    width: 250.0,
                    height: _height,
                    color: Colors.grey.withOpacity(0.1),
                  ),
                  AnimatedContainer(
                    height: _height,
                    width: progresso / 250.0,
                    color: corBarra,
                    duration: Duration(milliseconds: 400),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
