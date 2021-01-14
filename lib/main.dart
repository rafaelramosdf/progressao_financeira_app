import 'package:flutter/material.dart';
import 'package:progressao_financeira/app.dart';
import 'package:provider/provider.dart';

import 'blocs/lancamento.bloc.dart';

void main() => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (context) => LancamentoBloc()),
      ],
      child: App(),
    ));
