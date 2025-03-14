import 'package:flutter/material.dart';
import '../utils/constants.dart';
import 'package:fl_chart/fl_chart.dart';

class CleanerStatsScreen extends StatefulWidget {
  final int initialTab;

  const CleanerStatsScreen({
    Key? key,
    this.initialTab = 0,
  }) : super(key: key);

  @override
  State<CleanerStatsScreen> createState() => _CleanerStatsScreenState();
}

class _CleanerStatsScreenState extends State<CleanerStatsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedPeriod = 1; // 0 - week, 1 - month, 2 - year

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: widget.initialTab,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Statistics',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.primary,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.secondaryText,
          tabs: const [
            Tab(text: 'Earnings'),
            Tab(text: 'Cleanings'),
            Tab(text: 'Rating'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildEarningsTab(),
          _buildCleaningsTab(),
          _buildRatingTab(),
        ],
      ),
    );
  }

  Widget _buildPeriodSelector() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          _buildPeriodButton('Week', 0),
          _buildPeriodButton('Month', 1),
          _buildPeriodButton('Year', 2),
        ],
      ),
    );
  }

  Widget _buildPeriodButton(String text, int period) {
    final isSelected = _selectedPeriod == period;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedPeriod = period),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? Colors.white : AppColors.secondaryText,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEarningsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPeriodSelector(),
          const SizedBox(height: 24),
          _buildEarningsOverview(),
          const SizedBox(height: 24),
          _buildEarningsChart(),
          const SizedBox(height: 24),
          _buildTopClients(),
        ],
      ),
    );
  }

  Widget _buildEarningsOverview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Overview',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildStatItem('Monthly Earnings', '\$700', Icons.payments),
            _buildStatItem('Average Job', '\$35', Icons.receipt),
            _buildStatItem('Bonus Points', '2,400', Icons.savings),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildStatItem('Total Cleanings', '20', Icons.cleaning_services),
            _buildStatItem('Rating', '4.9', Icons.star),
            _buildStatItem('Work Hours', '60', Icons.timer),
          ],
        ),
      ],
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.28,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: AppColors.primary,
            size: 24,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.secondaryText,
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildEarningsChart() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Earnings Trend',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 200,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 1,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: AppColors.divider,
                      strokeWidth: 1,
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        const style = TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 12,
                        );
                        Widget text;
                        switch (value.toInt()) {
                          case 0:
                            text = const Text('Mon', style: style);
                            break;
                          case 1:
                            text = const Text('Tue', style: style);
                            break;
                          case 2:
                            text = const Text('Wed', style: style);
                            break;
                          case 3:
                            text = const Text('Thu', style: style);
                            break;
                          case 4:
                            text = const Text('Fri', style: style);
                            break;
                          case 5:
                            text = const Text('Sat', style: style);
                            break;
                          case 6:
                            text = const Text('Sun', style: style);
                            break;
                          default:
                            text = const Text('', style: style);
                            break;
                        }
                        return SideTitleWidget(
                          axisSide: meta.axisSide,
                          child: text,
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          '${value.toInt()}K',
                          style: const TextStyle(
                            color: AppColors.secondaryText,
                            fontSize: 12,
                          ),
                        );
                      },
                      reservedSize: 30,
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                minX: 0,
                maxX: 6,
                minY: 0,
                maxY: 6,
                lineBarsData: [
                  LineChartBarData(
                    spots: const [
                      FlSpot(0, 3),
                      FlSpot(1, 2),
                      FlSpot(2, 4),
                      FlSpot(3, 3),
                      FlSpot(4, 5),
                      FlSpot(5, 3),
                      FlSpot(6, 4),
                    ],
                    isCurved: true,
                    color: AppColors.primary,
                    barWidth: 2,
                    isStrokeCapRound: true,
                    dotData: FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      color: AppColors.primary.withOpacity(0.1),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopClients() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Regular Clients',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 3,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final clients = [
              {'name': 'Anna M.', 'cleanings': 8, 'earnings': '\$280'},
              {'name': 'John K.', 'cleanings': 6, 'earnings': '\$210'},
              {'name': 'Elena S.', 'cleanings': 4, 'earnings': '\$140'},
            ];
            final client = clients[index];
            return Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        client['name'].toString().substring(0, 1),
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          client['name'].toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              '${client['cleanings']} cleanings',
                              style: const TextStyle(
                                color: AppColors.secondaryText,
                                fontSize: 14,
                              ),
                            ),
                            const Text(
                              ' • ',
                              style: TextStyle(
                                color: AppColors.secondaryText,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              client['earnings'].toString(),
                              style: const TextStyle(
                                color: AppColors.secondaryText,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildCleaningsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPeriodSelector(),
          const SizedBox(height: 24),
          _buildCleaningsOverview(),
          const SizedBox(height: 24),
          _buildCleaningsChart(),
          const SizedBox(height: 24),
          _buildCleaningTypes(),
        ],
      ),
    );
  }

  Widget _buildCleaningsOverview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Overview',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildStatItem('Monthly Cleanings', '20', Icons.cleaning_services),
            _buildStatItem('Average Time', '3h', Icons.timer),
            _buildStatItem('Cancelled', '1', Icons.cancel),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildStatItem('On Time', '95%', Icons.timer),
            _buildStatItem('Repeat Clients', '60%', Icons.repeat),
            _buildStatItem('Areas', '3', Icons.location_on),
          ],
        ),
      ],
    );
  }

  Widget _buildCleaningTypes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Cleaning Types',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 3,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final types = [
              {'name': 'Regular', 'count': 12, 'percent': '60%'},
              {'name': 'Deep Clean', 'count': 5, 'percent': '25%'},
              {'name': 'Post-Renovation', 'count': 3, 'percent': '15%'},
            ];
            final type = types[index];
            return Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.cleaning_services,
                      color: AppColors.primary,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          type['name'].toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              '${type['count']} cleanings',
                              style: const TextStyle(
                                color: AppColors.secondaryText,
                                fontSize: 14,
                              ),
                            ),
                            const Text(
                              ' • ',
                              style: TextStyle(
                                color: AppColors.secondaryText,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              type['percent'].toString(),
                              style: const TextStyle(
                                color: AppColors.secondaryText,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildRatingTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPeriodSelector(),
          const SizedBox(height: 24),
          _buildRatingOverview(),
          const SizedBox(height: 24),
          _buildRatingChart(),
          const SizedBox(height: 24),
          _buildRecentReviews(),
        ],
      ),
    );
  }

  Widget _buildRatingOverview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Overview',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildStatItem('Average Rating', '4.9', Icons.star),
            _buildStatItem('Total Reviews', '125', Icons.reviews),
            _buildStatItem('This Month', '16', Icons.calendar_today),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildStatItem('5 Stars', '80%', Icons.star_rate),
            _buildStatItem('4 Stars', '15%', Icons.star_half),
            _buildStatItem('Under 3', '5%', Icons.star_border),
          ],
        ),
      ],
    );
  }

  Widget _buildRecentReviews() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recent Reviews',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 3,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final reviews = [
              {
                'name': 'Anna M.',
                'rating': 5,
                'text': 'Excellent cleaning! Everything is spotless.',
                'date': '2 days ago'
              },
              {
                'name': 'John K.',
                'rating': 5,
                'text': 'Thank you for the quality work!',
                'date': '4 days ago'
              },
              {
                'name': 'Elena S.',
                'rating': 4,
                'text': 'Good cleaning, but could be better.',
                'date': '5 days ago'
              },
            ];
            final review = reviews[index];
            return Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            review['name'].toString().substring(0, 1),
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              review['name'].toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                ...List.generate(
                                  5,
                                  (index) => Icon(
                                    index < (review['rating'] as int)
                                        ? Icons.star
                                        : Icons.star_border,
                                    color: Colors.amber,
                                    size: 16,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  review['date'].toString(),
                                  style: const TextStyle(
                                    color: AppColors.secondaryText,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (review['text'] != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      review['text'].toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildCleaningsChart() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Cleanings Count',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 200,
            child: Center(
              child: Text(
                'Cleanings Chart',
                style: TextStyle(
                  color: AppColors.secondaryText,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingChart() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Rating Trend',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 200,
            child: Center(
              child: Text(
                'Rating Chart',
                style: TextStyle(
                  color: AppColors.secondaryText,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
} 