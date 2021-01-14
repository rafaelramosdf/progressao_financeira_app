import 'package:flutter/material.dart';

class FundoDegradeGO extends StatelessWidget {
  final Widget child;
  FundoDegradeGO({this.child});

  Widget _fundoDegrade() => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.indigo,
              Colors.indigo[100],
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
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
