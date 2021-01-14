import 'dart:async';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:progressao_financeira/widgets/cores/cores.widget.dart';

class GraficoLinhaGO extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => GraficoLinhaGOState();
}

class GraficoLinhaGOState extends State<GraficoLinhaGO> {
  StreamController<LineTouchResponse> controller;
  @override
  void initState() {
    super.initState();

    controller = StreamController();
    controller.stream.distinct().listen((LineTouchResponse response) {
      print('response: ${response.touchInput}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.2,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            gradient: LinearGradient(
              colors: [
                Color(0xff2c274c),
                Color(0xff46426c),
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 10.0),
            Text(
              "Gráfico Anual",
              style: TextStyle(
                color: Colors.white30,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 4.0),
            Text(
              "Progressão Financeira 2019",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10.0),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 16.0, left: 6.0),
                child: FlChart(
                  chart: LineChart(
                    LineChartData(
                      lineTouchData: LineTouchData(
                          touchResponseSink: controller.sink,
                          touchTooltipData: TouchTooltipData(
                            tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
                          )),
                      gridData: FlGridData(show: false),
                      titlesData: FlTitlesData(
                        bottomTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 14,
                          textStyle: TextStyle(
                            color: const Color(0xff72719b),
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                          margin: 10,
                          getTitles: (value) {
                            switch (value.toInt()) {
                              case 0:
                                return 'JAN';
                              case 1:
                                return 'FEV';
                              case 2:
                                return 'MAR';
                              case 3:
                                return 'ABR';
                              case 4:
                                return 'MAI';
                              case 5:
                                return 'JUN';
                              case 6:
                                return 'JUL';
                              case 7:
                                return 'AGO';
                              case 8:
                                return 'SET';
                              case 9:
                                return 'OUT';
                              case 10:
                                return 'NOV';
                              case 11:
                                return 'DEZ';
                            }
                            return '';
                          },
                        ),
                        leftTitles: SideTitles(
                          showTitles: true,
                          textStyle: TextStyle(
                            color: Color(0xff75729e),
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                          getTitles: (value) {
                            if (value < 1000)
                              return "0 - 1m";
                            else if (value >= 1000 && value < 5000)
                              return "1m - 4m";
                            else if (value >= 5000 && value < 10000)
                              return "5m - 9m";
                            else if (value >= 10000 && value < 50000)
                              return "10m - 50m";
                            else if (value >= 50000 && value < 100000)
                              return "50m - 100m";
                            else
                              return "";
                          },
                          margin: 8,
                          reservedSize: 20.0,
                        ),
                      ),
                      borderData: FlBorderData(
                        show: true,
                        border: Border(
                          bottom: BorderSide(
                            color: Color(0xff4e4965),
                            width: 4,
                          ),
                          left: BorderSide(color: Colors.transparent),
                          right: BorderSide(color: Colors.transparent),
                          top: BorderSide(color: Colors.transparent),
                        ),
                      ),
                      lineBarsData: [
                        LineChartBarData(
                          spots: [
                            FlSpot(0, 10000.0),
                            FlSpot(1, 8000.0),
                            FlSpot(2, 15000.0),
                            FlSpot(3, 10000.0),
                            FlSpot(4, 8000.0),
                            FlSpot(5, 15000.0),
                            FlSpot(6, 10000.0),
                            FlSpot(7, 8000.0),
                            FlSpot(8, 15000.0),
                            FlSpot(9, 10000.0),
                            FlSpot(10, 8000.0),
                            FlSpot(11, 15000.0),
                          ],
                          isCurved: true,
                          colors: [CoresGO.rosa],
                          barWidth: 15,
                          dotData: FlDotData(show: false),
                          belowBarData: BelowBarData(show: false),
                        ),
                        LineChartBarData(
                          spots: [
                            FlSpot(0, 20000.0),
                            FlSpot(1, 20000.0),
                            FlSpot(2, 20000.0),
                            FlSpot(3, 20000.0),
                            FlSpot(4, 20000.0),
                            FlSpot(5, 20000.0),
                            FlSpot(6, 20000.0),
                            FlSpot(7, 20000.0),
                            FlSpot(8, 20000.0),
                            FlSpot(9, 20000.0),
                            FlSpot(10, 20000.0),
                            FlSpot(11, 20000.0),
                          ],
                          isCurved: true,
                          colors: [CoresGO.verde],
                          barWidth: 15,
                          dotData: FlDotData(show: false),
                          belowBarData: BelowBarData(show: false),
                        ),
                        LineChartBarData(
                          spots: [
                            FlSpot(0, 10000.0),
                            FlSpot(1, 12000.0),
                            FlSpot(2, 5000.0),
                            FlSpot(3, 10000.0),
                            FlSpot(4, 12000.0),
                            FlSpot(5, 5000.0),
                            FlSpot(6, 10000.0),
                            FlSpot(7, 12000.0),
                            FlSpot(8, 5000.0),
                            FlSpot(9, 10000.0),
                            FlSpot(10, 12000.0),
                            FlSpot(11, 5000.0),
                          ],
                          isCurved: true,
                          colors: [CoresGO.azul],
                          barWidth: 15,
                          dotData: FlDotData(show: false),
                          belowBarData: BelowBarData(show: false),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.close();
  }
}
