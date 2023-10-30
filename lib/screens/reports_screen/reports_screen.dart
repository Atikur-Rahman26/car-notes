import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Reports extends StatefulWidget {
  static const String id = "Reports";
  const Reports({super.key});

  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  double _fuelCost = 0;
  double _repairsCost = 0;
  double _papersCost = 0;
  double _totalCost = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.grey),
                  onPressed: () {},
                  child: const Text(
                    "by years",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                TextButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.grey),
                  onPressed: () {},
                  child: const Text(
                    "by ownerships years",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: double.infinity,
              height: 1,
              child: Container(
                color: Colors.grey,
              ),
            ),
            Row(
              children: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.grey),
                  onPressed: () {},
                  child: const Text(
                    "all time",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                TextButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.grey),
                  onPressed: () {},
                  child: const Text(
                    "last year",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: double.infinity,
              height: 1,
              child: Container(
                color: Colors.grey,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                left: 5,
                right: 5,
                top: 10,
                bottom: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: 80,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        const Text(
                          "Fuel",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "$_fuelCost ",
                              style: const TextStyle(
                                  color: Colors.yellow,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Icon(
                              Icons.currency_pound,
                              size: 25,
                              color: Colors.yellow,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: 80,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        const Text(
                          "Repairs",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "$_repairsCost ",
                              style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Icon(
                              Icons.currency_pound,
                              size: 25,
                              color: Colors.red,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: 80,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        const Text(
                          "Papers",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "$_fuelCost ",
                              style: const TextStyle(
                                  color: Colors.green,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Icon(
                              Icons.currency_pound,
                              size: 25,
                              color: Colors.green,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                left: 5,
                right: 5,
                top: 10,
                bottom: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: 80,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Container(
                      padding: const EdgeInsets.only(left: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          const Text(
                            "Total",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                "$_totalCost ",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              const Icon(
                                Icons.currency_pound,
                                size: 25,
                                color: Colors.white,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SfCartesianChart(
              primaryXAxis: CategoryAxis(
                  minorGridLines: const MinorGridLines(width: 0),
                  majorGridLines:
                      const MajorGridLines(width: 0), // Hide grid lines
                  axisLine: const AxisLine(width: 2),
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.white,
                  ),
                  labelRotation: 315,
                  interval: 2,
                  title: AxisTitle(
                      text: "Total costs",
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      )) // Customize axis line
                  ),
              primaryYAxis: NumericAxis(
                minorGridLines: const MinorGridLines(width: 1),
                majorGridLines: const MajorGridLines(width: 3),
                axisLine: const AxisLine(width: 2),
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.white,
                ),
                interval: 1,
                title: AxisTitle(
                  text: "Cost,thousands(pounds)",
                  textStyle: TextStyle(color: Colors.white),
                ),
              ),
              series: <ChartSeries>[
                LineSeries<TotalCostsGraph, String>(
                  dataSource: graphTotalCostsList,
                  color: Colors.blueAccent,
                  xValueMapper: (TotalCostsGraph totalcostsgraph, _) =>
                      totalcostsgraph.monthYear,
                  yValueMapper: (TotalCostsGraph totalcostsgraph, _) =>
                      totalcostsgraph.totalCosts,
                ),
              ],
            ),
            SfCartesianChart(
              primaryXAxis: CategoryAxis(
                minorGridLines: const MinorGridLines(width: 0),
                majorGridLines:
                    const MajorGridLines(width: 0), // Hide grid lines
                axisLine: const AxisLine(width: 2),
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.white,
                ),
                labelRotation: 270,
                interval: 1,
              ),
              primaryYAxis: NumericAxis(
                minorGridLines: const MinorGridLines(width: 1),
                majorGridLines: const MajorGridLines(width: 3),
                axisLine: const AxisLine(width: 2),
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.white,
                ),
                title: AxisTitle(
                  text: "Cost,thousands(pounds)",
                  textStyle: TextStyle(color: Colors.white),
                ),
              ),
              series: <ChartSeries>[
                LineSeries<TotalCostsGraph, String>(
                  dataSource: FuelCostsList,
                  color: Colors.yellow,
                  xValueMapper: (TotalCostsGraph totalcostsgraph, _) =>
                      totalcostsgraph.monthYear,
                  yValueMapper: (TotalCostsGraph totalcostsgraph, _) =>
                      totalcostsgraph.totalCosts,
                ),
                LineSeries<TotalCostsGraph, String>(
                  dataSource: PapersCostsList,
                  color: Colors.green,
                  xValueMapper: (TotalCostsGraph totalcostsgraph, _) =>
                      totalcostsgraph.monthYear,
                  yValueMapper: (TotalCostsGraph totalcostsgraph, _) =>
                      totalcostsgraph.totalCosts,
                ),
                LineSeries<TotalCostsGraph, String>(
                  dataSource: RepairsCostsList,
                  color: Colors.red,
                  xValueMapper: (TotalCostsGraph totalcostsgraph, _) =>
                      totalcostsgraph.monthYear,
                  yValueMapper: (TotalCostsGraph totalcostsgraph, _) =>
                      totalcostsgraph.totalCosts,
                ),
              ],
            ),
            Container(
              // Customize the color of the background box
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Fuel',
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 20,
                    height: 10,
                    color: Colors.yellow, // Customize the color of the box
                  ),
                ],
              ),
            ),
            Container(
              // Customize the color of the background box
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Papers',
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 20,
                    height: 10,
                    color: Colors.green, // Customize the color of the box
                  ),
                ],
              ),
            ),
            Container(
              // Customize the color of the background box
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Repairs',
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 20,
                    height: 10,
                    color: Colors.red, // Customize the color of the box
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SfCartesianChart(
              primaryXAxis: CategoryAxis(
                  minorGridLines: const MinorGridLines(width: 0),
                  majorGridLines:
                      const MajorGridLines(width: 0), // Hide grid lines
                  axisLine: const AxisLine(width: 2),
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.white,
                  ),
                  labelRotation: 315,
                  interval: 2,
                  title: AxisTitle(
                      text: "Fuel Consumption",
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      )) // Customize axis line
                  ),
              primaryYAxis: NumericAxis(
                minorGridLines: const MinorGridLines(width: 1),
                majorGridLines: const MajorGridLines(width: 3),
                majorTickLines: MajorTickLines(size: 0),
                minorTickLines: MinorTickLines(size: 0),
                axisLine: const AxisLine(width: 2),
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.white,
                ),
                interval: 1,
                title: AxisTitle(
                  text: "Average consumption,L/100 km",
                  textStyle: TextStyle(color: Colors.white),
                ),
              ),
              series: <ChartSeries>[
                LineSeries<TotalCostsGraph, String>(
                  dataSource: graphTotalCostsList,
                  color: Colors.blueAccent,
                  xValueMapper: (TotalCostsGraph totalcostsgraph, _) =>
                      totalcostsgraph.monthYear,
                  yValueMapper: (TotalCostsGraph totalcostsgraph, _) =>
                      totalcostsgraph.totalCosts,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<TotalCostsGraph> graphTotalCostsList = [
    TotalCostsGraph(monthYear: "Jan 23", totalCosts: 3.03),
    TotalCostsGraph(monthYear: "Feb 23", totalCosts: 2.56),
    TotalCostsGraph(monthYear: "Mar 23", totalCosts: 3.83),
    TotalCostsGraph(monthYear: "Apr 23", totalCosts: 4.13),
    TotalCostsGraph(monthYear: "May 23", totalCosts: 3.27),
    TotalCostsGraph(monthYear: "Jun 23", totalCosts: 5.19),
    TotalCostsGraph(monthYear: "Jul 23", totalCosts: 2.34),
    TotalCostsGraph(monthYear: "Aug 23", totalCosts: 1.95),
    TotalCostsGraph(monthYear: "Sep 23", totalCosts: 3.58),
    TotalCostsGraph(monthYear: "Oct 23", totalCosts: 3.14),
    TotalCostsGraph(monthYear: "Nov 23", totalCosts: 5.78),
    TotalCostsGraph(monthYear: "Dec 23", totalCosts: 4.29),
  ];
  List<TotalCostsGraph> FuelCostsList = [
    TotalCostsGraph(monthYear: "Jan 23", totalCosts: 1.25),
    TotalCostsGraph(monthYear: "Feb 23", totalCosts: 1.69),
    TotalCostsGraph(monthYear: "Mar 23", totalCosts: 1.09),
    TotalCostsGraph(monthYear: "Apr 23", totalCosts: 1.13),
    TotalCostsGraph(monthYear: "May 23", totalCosts: 2.02),
    TotalCostsGraph(monthYear: "Jun 23", totalCosts: 1.49),
    TotalCostsGraph(monthYear: "Jul 23", totalCosts: 1.61),
    TotalCostsGraph(monthYear: "Aug 23", totalCosts: 1.84),
    TotalCostsGraph(monthYear: "Sep 23", totalCosts: 1.87),
    TotalCostsGraph(monthYear: "Oct 23", totalCosts: 1.03),
    TotalCostsGraph(monthYear: "Nov 23", totalCosts: 1.91),
    TotalCostsGraph(monthYear: "Dec 23", totalCosts: 2.01),
  ];
  List<TotalCostsGraph> PapersCostsList = [
    TotalCostsGraph(monthYear: "Jan 23", totalCosts: 1.15),
    TotalCostsGraph(monthYear: "Feb 23", totalCosts: 1.59),
    TotalCostsGraph(monthYear: "Mar 23", totalCosts: 1.29),
    TotalCostsGraph(monthYear: "Apr 23", totalCosts: 1.53),
    TotalCostsGraph(monthYear: "May 23", totalCosts: 2.12),
    TotalCostsGraph(monthYear: "Jun 23", totalCosts: 1.90),
    TotalCostsGraph(monthYear: "Jul 23", totalCosts: 1.16),
    TotalCostsGraph(monthYear: "Aug 23", totalCosts: 1.48),
    TotalCostsGraph(monthYear: "Sep 23", totalCosts: 1.39),
    TotalCostsGraph(monthYear: "Oct 23", totalCosts: 1.30),
    TotalCostsGraph(monthYear: "Nov 23", totalCosts: 1.24),
    TotalCostsGraph(monthYear: "Dec 23", totalCosts: 2.11),
  ];
  List<TotalCostsGraph> RepairsCostsList = [
    TotalCostsGraph(monthYear: "Jan 23", totalCosts: 1.52),
    TotalCostsGraph(monthYear: "Feb 23", totalCosts: 1.61),
    TotalCostsGraph(monthYear: "Mar 23", totalCosts: 1.19),
    TotalCostsGraph(monthYear: "Apr 23", totalCosts: 1.46),
    TotalCostsGraph(monthYear: "May 23", totalCosts: 2.34),
    TotalCostsGraph(monthYear: "Jun 23", totalCosts: 1.41),
    TotalCostsGraph(monthYear: "Jul 23", totalCosts: 1.69),
    TotalCostsGraph(monthYear: "Aug 23", totalCosts: 1.41),
    TotalCostsGraph(monthYear: "Sep 23", totalCosts: 1.71),
    TotalCostsGraph(monthYear: "Oct 23", totalCosts: 1.20),
    TotalCostsGraph(monthYear: "Nov 23", totalCosts: 1.99),
    TotalCostsGraph(monthYear: "Dec 23", totalCosts: 2.12),
  ];
}

class TotalCostsGraph {
  final String monthYear;
  final double totalCosts;
  TotalCostsGraph({required this.monthYear, required this.totalCosts});
}
