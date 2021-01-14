import 'package:flutter/material.dart';

class BotaoIconeGO extends StatelessWidget {
  final String texto;
  final Color corFundo;
  final Color corTexto;
  final IconData icone;

  BotaoIconeGO({
    this.texto,
    this.corFundo,
    this.corTexto,
    this.icone,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 5.0,
      child: InkWell(
        onTap: () {},
        child: Container(
          height: 200.0,
          width: 200.0,
          padding: EdgeInsets.all(30.0),
          color: corFundo,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                icone,
                color: Colors.white,
                size: 50.0,
              ),
              Text(
                texto,
                style: TextStyle(
                  color: corTexto ?? Colors.white,
                  fontSize: 20.0,
                ),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
