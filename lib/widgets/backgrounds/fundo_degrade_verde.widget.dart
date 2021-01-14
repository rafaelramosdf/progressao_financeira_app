import 'package:flutter/material.dart';

class FundoDegradeVerdeGO extends StatelessWidget {
  final Widget child;
  FundoDegradeVerdeGO({this.child});

  Widget _fundoDegrade() => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.greenAccent[400],
              Colors.green[900],
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
