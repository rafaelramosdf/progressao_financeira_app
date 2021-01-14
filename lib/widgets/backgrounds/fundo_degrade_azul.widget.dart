import 'package:flutter/material.dart';

class FundoDegradeAzulGO extends StatelessWidget {
  final Widget child;
  FundoDegradeAzulGO({this.child});

  Widget _fundoDegrade() => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.indigoAccent[400],
              Colors.indigo[900],
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      );
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _fundoDegrade(),
        child,
      ],
    );
  }
}
