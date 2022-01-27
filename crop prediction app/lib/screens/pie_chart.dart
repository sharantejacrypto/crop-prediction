import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/indicator.dart';
import '../utilities/colors.dart';

class PieChartSample2 extends StatefulWidget {
  final diseaseData;
  PieChartSample2(this.diseaseData);
  @override
  State<StatefulWidget> createState() => PieChart2State(diseaseData);
}

class PieChart2State extends State {
  final diseaseData;
  PieChart2State(this.diseaseData);
  int touchedIndex;
  List<String> diseaseName;
  List<double> diseaseRate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    diseaseName = List();
    diseaseRate = List();
    diseaseData.forEach((key, value) {
      diseaseName.add(key);
      diseaseRate.add(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.3,
      child: Card(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: <Widget>[
                  // SizedBox(
                  //   width: 100,
                  // ),
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: PieChart(
                        PieChartData(
                            pieTouchData:
                                PieTouchData(touchCallback: (pieTouchResponse) {
                              setState(() {
                                if (pieTouchResponse.touchInput
                                        is FlLongPressEnd ||
                                    pieTouchResponse.touchInput is FlPanEnd) {
                                  touchedIndex = -1;
                                } else {
                                  touchedIndex =
                                      pieTouchResponse.touchedSectionIndex;
                                }
                              });
                            }),
                            borderData: FlBorderData(
                              show: false,
                            ),
                            sectionsSpace: 0,
                            centerSpaceRadius: 60,
                            sections: showingSections()),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: getIndicators(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> getIndicators() {
    int value;
    List<Widget> indicators = List();
    for (int i = 0; i < 23; i++) {
      value = (diseaseRate[i] * 100).round();
      if (value >= 1) {
        indicators.addAll([
          Indicator(
            color: kColors[i],
            text: '${diseaseName[i]}($value%)',
            isSquare: true,
          ),
          SizedBox(
            height: 4,
          )
        ]);
      }
    }
    indicators.add(SizedBox(
      height: 14,
    ));
    return indicators;
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(23, (index) {
      final isTouched = index == touchedIndex;
      final double fontSize = isTouched ? 30 : 23;
      final double radius = isTouched ? 110 : 100;
      return getPieChartSectionData(
          index, diseaseRate[index] * 100, radius, fontSize);
    });
  }

  PieChartSectionData getPieChartSectionData(
      int index, double value, double radius, double fontSize) {
    return PieChartSectionData(
      color: kColors[index],
      value: value,
      title: value < 4 ? '' : '${value.round()}%',
      radius: radius,
      titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: const Color(0xffffffff)),
    );
  }
}
