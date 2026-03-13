import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class StatsCharts extends StatefulWidget {
  final List<int> weeklyData;
  final List<int> monthlyData;
  final List<int> yearlyData;

  const StatsCharts({
    super.key,
    required this.weeklyData,
    required this.monthlyData,
    required this.yearlyData,
  });

  @override
  State<StatsCharts> createState() => _StatsChartsState();
}

class _StatsChartsState extends State<StatsCharts> {
  final PageController _controller = PageController();
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 247,

          child: PageView(
            controller: _controller,

            onPageChanged: (index) {
              setState(() {
                currentPage = index;
              });
            },

            children: [
              _buildChartCard("Weekly Activity", [
                "Mon",
                "Tue",
                "Wed",
                "Thu",
                "Fri",
                "Sat",
                "Sun",
              ], widget.weeklyData),

              _buildChartCard("Monthly Focus", [
                "W1",
                "W2",
                "W3",
                "W4",
              ], widget.monthlyData),

              _buildChartCard("Yearly Focus", [
                "Jan",
                "Feb",
                "Mar",
                "Apr",
                "May",
                "Jun",
                "Jul",
                "Aug",
                "Sep",
                "Oct",
                "Nov",
                "Dec",
              ], widget.yearlyData),
            ],
          ),
        ),

        const SizedBox(height: 10),

        _buildIndicator(),
      ],
    );
  }

  Widget _buildIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,

      children: List.generate(3, (index) {
        bool active = currentPage == index;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),

          margin: const EdgeInsets.symmetric(horizontal: 4),

          width: active ? 18 : 8,
          height: 8,

          decoration: BoxDecoration(
            color: active ? const Color(0xFFE53935) : Colors.grey.shade400,

            borderRadius: BorderRadius.circular(20),
          ),
        );
      }),
    );
  }

  Widget _buildChartCard(String title, List<String> labels, List<int> data) {
    double maxY = (data.reduce((a, b) => a > b ? a : b) + 2).toDouble();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),

      child: Card(
        color: Colors.white,

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),

        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                height: 150,

                child: BarChart(
                  BarChartData(
                    maxY: maxY,
                    alignment: BarChartAlignment.spaceAround,
                    borderData: FlBorderData(show: false),

                    titlesData: FlTitlesData(
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),

                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),

                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),

                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,

                          getTitlesWidget: (value, meta) {
                            int index = value.toInt();

                            if (index < 0 || index >= labels.length) {
                              return const SizedBox();
                            }

                            return Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: Text(
                                labels[index],
                                style: const TextStyle(fontSize: 10),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    barGroups: List.generate(
                      data.length,
                      (i) => BarChartGroupData(
                        x: i,
                        barRods: [
                          BarChartRodData(
                            toY: data[i].toDouble(),
                            width: 14,
                            borderRadius: BorderRadius.circular(4),
                            color: const Color(0xFFE53935),
                          ),
                        ],
                      ),
                    ),
                  ),
                  swapAnimationDuration: const Duration(milliseconds: 800),
                  swapAnimationCurve: Curves.easeOutCubic,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
