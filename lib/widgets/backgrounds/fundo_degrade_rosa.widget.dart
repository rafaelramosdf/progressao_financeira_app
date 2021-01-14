import 'package:flutter/material.dart';

class FundoDegradeRosaGO extends StatelessWidget {
  final Widget child;
  FundoDegradeRosaGO({this.child});

  Widget _fundoDegrade() => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.pinkAccent[400],
              Colors.pink[900],
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
