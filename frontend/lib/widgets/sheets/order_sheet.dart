import 'package:flutter/material.dart';
import '../../models/service.dart';
import '../../models/cleaner.dart';
import '../../utils/constants.dart';
import '../../utils/sample_data.dart';

class OrderSheet extends StatefulWidget {
  final String address;

  const OrderSheet({
    super.key,
    required this.address,
  });

  @override
  OrderSheetState createState() => OrderSheetState();
}

class OrderSheetState extends State<OrderSheet> {
  int _currentStep = 0;
  Service? _selectedService;
  Cleaner? _selectedCleaner;
  DateTime _selectedDate = DateTime.now().add(const Duration(days: 1));
  String _selectedTime = '10:00 AM';
  String _selectedAddress = '';
  bool _isAddingNewAddress = false;
  String _selectedPaymentMethod = 'card';
  
  final List<Service> _services = SampleData.services;
  final List<Cleaner> _cleaners = SampleData.cleaners;
  final TextEditingController _addressController = TextEditingController();
  
  final List<String> _savedAddresses = [
    '123 Main St, Apt 4B, New York, NY 10001',
    '456 Park Ave, Suite 2C, New York, NY 10022',
  ];

  final List<String> _availableTimes = [
    '8:00 AM',
    '9:00 AM',
    '10:00 AM',
    '11:00 AM',
    '12:00 PM',
    '1:00 PM',
    '2:00 PM',
    '3:00 PM',
    '4:00 PM',
    '5:00 PM',
  ];

  final List<Map<String, dynamic>> _paymentMethods = [
    {
      'id': 'card',
      'title': 'Credit Card',
      'subtitle': '•••• 4242',
      'icon': Icons.credit_card,
    },
    {
      'id': 'apple',
      'title': 'Apple Pay',
      'subtitle': 'iPhone',
      'icon': Icons.apple,
    },
    {
      'id': 'google',
      'title': 'Google Pay',
      'subtitle': 'Android',
      'icon': Icons.g_mobiledata,
    },
  ];

  @override
  void initState() {
    super.initState();
    _selectedAddress = widget.address;
  }

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep < 3) {
      setState(() {
        _currentStep++;
      });
    }
  }

  void _prevStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    }
  }

  void _selectService(Service service) {
    setState(() {
      _selectedService = service;
    });
  }

  void _selectCleaner(Cleaner cleaner) {
    setState(() {
      _selectedCleaner = cleaner;
    });
  }

  void _selectDate(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
  }

  void _selectTime(String time) {
    setState(() {
      _selectedTime = time;
    });
  }

  String _formatDate(DateTime date) {
    final List<String> weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final List<String> months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    
    return '${weekdays[date.weekday - 1]}, ${months[date.month - 1]} ${date.day}';
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    final double bottomSheetHeight = isLandscape ? screenHeight * 0.9 : screenHeight * 0.85;
    
    return Container(
      height: bottomSheetHeight,
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Step indicator
          _buildStepIndicator(),

          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey.shade800,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _getStepTitle(),
                    style: AppTextStyles.headline3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (_currentStep > 0)
                  TextButton(
                    onPressed: _prevStep,
                    child: const Text('Back'),
                  ),
              ],
            ),
          ),

          // Content
          Expanded(
            child: _buildStepContent(),
          ),

          // Bottom button
          if (_currentStep < 3)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: _getNextButtonEnabled() ? _nextStep : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  disabledBackgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                ),
                child: Text(_getNextButtonText()),
              ),
            ),

          // Book button (only shown in the last step)
          if (_currentStep == 3)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Your cleaning has been booked!'),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Book Now',
                  style: AppTextStyles.button,
                ),
              ),
            ),
        ],
      ),
    );
  }

  String _getStepTitle() {
    switch (_currentStep) {
      case 0:
        return 'Select Service';
      case 1:
        return 'Choose Cleaner';
      case 2:
        return 'Select Date & Time';
      case 3:
        return 'Order Summary';
      default:
        return '';
    }
  }

  bool _getNextButtonEnabled() {
    switch (_currentStep) {
      case 0:
        return _selectedService != null;
      case 1:
        return _selectedCleaner != null;
      case 2:
        return true; // Date and time are pre-selected
      default:
        return false;
    }
  }

  String _getNextButtonText() {
    if (_currentStep == 2) {
      return 'Review Order';
    }
    return 'Continue';
  }

  Widget _buildStepContent() {
    switch (_currentStep) {
      case 0:
        return _buildServiceSelection();
      case 1:
        return _buildCleanerSelection();
      case 2:
        return _buildDateTimeSelection();
      case 3:
        return _buildOrderSummary();
      default:
        return Container();
    }
  }

  Widget _buildServiceSelection() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _services.length,
      itemBuilder: (context, index) {
        final service = _services[index];
        final bool isSelected = _selectedService == service;
        
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: InkWell(
            onTap: () => _selectService(service),
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isSelected ? Theme.of(context).colorScheme.primary.withOpacity(0.2) : AppColors.card,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected ? Theme.of(context).colorScheme.primary : Colors.transparent,
                  width: 2,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Service image placeholder
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.cleaning_services,
                        size: 35,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  
                  // Service details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          service.title,
                          style: AppTextStyles.subtitle1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '\$24${service.price.toStringAsFixed(2)}',
                          style: AppTextStyles.price,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${service.duration} min • ${service.description}',
                          style: AppTextStyles.body2,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  
                  // Checkbox
                  Container(
                    width: 24,
                    height: 24,
                    margin: const EdgeInsets.only(left: 8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSelected ? Theme.of(context).colorScheme.primary : Colors.transparent,
                      border: Border.all(
                        color: isSelected ? Theme.of(context).colorScheme.primary : Colors.grey,
                        width: 2,
                      ),
                    ),
                    child: isSelected
                        ? const Icon(
                            Icons.check,
                            size: 16,
                            color: Colors.white,
                          )
                        : null,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCleanerSelection() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _cleaners.length,
      itemBuilder: (context, index) {
        final cleaner = _cleaners[index];
        final bool isSelected = _selectedCleaner == cleaner;
        
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: InkWell(
            onTap: () => _selectCleaner(cleaner),
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isSelected ? Theme.of(context).colorScheme.primary.withOpacity(0.2) : AppColors.card,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected ? Theme.of(context).colorScheme.primary : Colors.transparent,
                  width: 2,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Cleaner image placeholder
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade700,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.person,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 16),
                  
                  // Cleaner details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cleaner.name,
                          style: AppTextStyles.subtitle1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                '${cleaner.rating} (${cleaner.reviewCount} reviews)',
                                style: AppTextStyles.body2,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          cleaner.description,
                          style: AppTextStyles.body2,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  
                  // Checkbox
                  Container(
                    width: 24,
                    height: 24,
                    margin: const EdgeInsets.only(left: 8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSelected ? Theme.of(context).colorScheme.primary : Colors.transparent,
                      border: Border.all(
                        color: isSelected ? Theme.of(context).colorScheme.primary : Colors.grey,
                        width: 2,
                      ),
                    ),
                    child: isSelected
                        ? const Icon(
                            Icons.check,
                            size: 16,
                            color: Colors.white,
                          )
                        : null,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDateTimeSelection() {
    final DateTime now = DateTime.now();
    final DateTime firstDay = now.add(const Duration(days: 1));
    final DateTime lastDay = now.add(const Duration(days: 30));
    
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Calendar view
            const Text(
              'Select Date',
              style: AppTextStyles.headline3,
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  // Month and year header
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${_getMonthName(_selectedDate.month)} ${_selectedDate.year}',
                          style: AppTextStyles.subtitle1,
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.chevron_left),
                              onPressed: () {
                                setState(() {
                                  _selectedDate = DateTime(
                                    _selectedDate.year,
                                    _selectedDate.month - 1,
                                    _selectedDate.day,
                                  );
                                });
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.chevron_right),
                              onPressed: () {
                                setState(() {
                                  _selectedDate = DateTime(
                                    _selectedDate.year,
                                    _selectedDate.month + 1,
                                    _selectedDate.day,
                                  );
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Weekday headers
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        Text('Sun', style: AppTextStyles.body2),
                        Text('Mon', style: AppTextStyles.body2),
                        Text('Tue', style: AppTextStyles.body2),
                        Text('Wed', style: AppTextStyles.body2),
                        Text('Thu', style: AppTextStyles.body2),
                        Text('Fri', style: AppTextStyles.body2),
                        Text('Sat', style: AppTextStyles.body2),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Calendar grid
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(8),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 7,
                      childAspectRatio: 1,
                    ),
                    itemCount: _getDaysInMonth(_selectedDate) + _getFirstDayOffset(_selectedDate),
                    itemBuilder: (context, index) {
                      final int firstDayOffset = _getFirstDayOffset(_selectedDate);
                      if (index < firstDayOffset) return Container();
                      
                      final int day = index - firstDayOffset + 1;
                      final DateTime date = DateTime(_selectedDate.year, _selectedDate.month, day);
                      final bool isSelected = date.year == _selectedDate.year &&
                          date.month == _selectedDate.month &&
                          date.day == _selectedDate.day;
                      final bool isAvailable = date.isAfter(now) && date.isBefore(lastDay);
                      
                      return GestureDetector(
                        onTap: isAvailable ? () => _selectDate(date) : null,
                        child: Container(
                          margin: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: isSelected ? Theme.of(context).colorScheme.primary : null,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              day.toString(),
                              style: TextStyle(
                                color: !isAvailable
                                    ? Colors.grey
                                    : isSelected
                                        ? Colors.white
                                        : null,
                                fontWeight: isSelected ? FontWeight.bold : null,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Time selection
            const Text(
              'Select Time',
              style: AppTextStyles.headline3,
            ),
            const SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 2.5,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: _availableTimes.length,
              itemBuilder: (context, index) {
                final time = _availableTimes[index];
                final bool isSelected = time == _selectedTime;
                
                return InkWell(
                  onTap: () => _selectTime(time),
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected ? Theme.of(context).colorScheme.primary : AppColors.card,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      time,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: isSelected ? FontWeight.bold : null,
                        color: isSelected ? Colors.white : null,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  String _getMonthName(int month) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[month - 1];
  }

  int _getDaysInMonth(DateTime date) {
    return DateTime(date.year, date.month + 1, 0).day;
  }

  int _getFirstDayOffset(DateTime date) {
    return DateTime(date.year, date.month, 1).weekday % 7;
  }

  Widget _buildOrderSummary() {
    final service = _selectedService!;
    final cleaner = _selectedCleaner!;
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Address
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Cleaning Location',
                style: AppTextStyles.headline3,
              ),
              TextButton.icon(
                onPressed: _showAddressBottomSheet,
                icon: const Icon(Icons.edit, size: 16),
                label: const Text('Change'),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(50, 30),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.location_on,
                  color: Colors.grey,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _savedAddresses.indexOf(_selectedAddress) == 0 ? 'Home' : 'Work',
                        style: AppTextStyles.subtitle1,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _selectedAddress,
                        style: AppTextStyles.body2,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Service
          const Text(
            'Service Details',
            style: AppTextStyles.headline3,
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Service image placeholder
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.cleaning_services,
                      size: 24,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                
                // Service details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        service.title,
                        style: AppTextStyles.subtitle1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '\$24${service.price.toStringAsFixed(2)}',
                        style: AppTextStyles.price,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${service.duration} min • ${service.description}',
                        style: AppTextStyles.body2,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _currentStep = 0;
                    });
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(50, 30),
                  ),
                  child: const Text('Change'),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Cleaner
          const Text(
            'Cleaner',
            style: AppTextStyles.headline3,
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Cleaner image placeholder
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade700,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person,
                    size: 24,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 16),
                
                // Cleaner details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cleaner.name,
                        style: AppTextStyles.subtitle1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              '${cleaner.rating} (${cleaner.reviewCount} reviews)',
                              style: AppTextStyles.body2,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _currentStep = 1;
                    });
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(50, 30),
                  ),
                  child: const Text('Change'),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Date and time
          const Text(
            'Date & Time',
            style: AppTextStyles.headline3,
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.calendar_today,
                      size: 24,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _formatDate(_selectedDate),
                        style: AppTextStyles.subtitle1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _selectedTime,
                        style: AppTextStyles.body2,
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _currentStep = 2;
                    });
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(50, 30),
                  ),
                  child: const Text('Change'),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Payment method
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Payment Method',
                style: AppTextStyles.headline3,
              ),
              TextButton.icon(
                onPressed: _showPaymentMethodSheet,
                icon: const Icon(Icons.edit, size: 16),
                label: const Text('Change'),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(50, 30),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    _paymentMethods
                        .firstWhere((m) => m['id'] == _selectedPaymentMethod)['icon'],
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _paymentMethods
                            .firstWhere((m) => m['id'] == _selectedPaymentMethod)['title'],
                        style: AppTextStyles.subtitle1,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _paymentMethods
                            .firstWhere((m) => m['id'] == _selectedPaymentMethod)['subtitle'],
                        style: AppTextStyles.body2,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Payment summary
          const Text(
            'Payment Summary',
            style: AppTextStyles.headline3,
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Service Fee',
                      style: AppTextStyles.body2,
                    ),
                    Text(
                      '\$24.00',
                      style: AppTextStyles.body1,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Booking Fee',
                      style: AppTextStyles.body2,
                    ),
                    const Text(
                      '\$5.00',
                      style: AppTextStyles.price,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Tax',
                      style: AppTextStyles.body2,
                    ),
                    const Text(
                      '\$7.50',
                      style: AppTextStyles.price,
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Divider(
                    color: Colors.grey,
                    thickness: 0.5,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total',
                      style: AppTextStyles.subtitle1,
                    ),
                    Text(
                      '\$36.50',
                      style: AppTextStyles.price,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade800,
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStepCircle(0, 'Service'),
          _buildStepLine(0),
          _buildStepCircle(1, 'Cleaner'),
          _buildStepLine(1),
          _buildStepCircle(2, 'Schedule'),
          _buildStepLine(2),
          _buildStepCircle(3, 'Review'),
        ],
      ),
    );
  }

  Widget _buildStepCircle(int step, String label) {
    final bool isCompleted = _currentStep > step;
    final bool isCurrent = _currentStep == step;
    
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isCompleted || isCurrent
                ? Theme.of(context).colorScheme.primary
                : Colors.grey.shade800,
          ),
          child: Center(
            child: isCompleted
                ? const Icon(Icons.check, color: Colors.white, size: 18)
                : Text(
                    '${step + 1}',
                    style: TextStyle(
                      color: isCurrent ? Colors.white : Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isCurrent ? Theme.of(context).colorScheme.primary : Colors.grey,
            fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildStepLine(int step) {
    final bool isCompleted = _currentStep > step;
    
    return Expanded(
      child: Container(
        height: 2,
        margin: const EdgeInsets.only(bottom: 20),
        color: isCompleted
            ? Theme.of(context).colorScheme.primary
            : Colors.grey.shade800,
      ),
    );
  }

  void _showAddressBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.7,
              decoration: const BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey.shade800,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Confirm Your Address',
                            style: AppTextStyles.headline3,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _isAddingNewAddress = true;
                              _addressController.clear();
                            });
                          },
                          child: const Text('Change'),
                        ),
                      ],
                    ),
                  ),
                  
                  // Add new address button
                  if (!_isAddingNewAddress)
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            _isAddingNewAddress = true;
                            _addressController.clear();
                          });
                        },
                        icon: const Icon(Icons.add),
                        label: const Text('Add New Address'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    
                  // New address form
                  if (_isAddingNewAddress)
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Enter New Address',
                            style: AppTextStyles.subtitle1,
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: _addressController,
                            decoration: InputDecoration(
                              hintText: 'Enter your address',
                              filled: true,
                              fillColor: AppColors.card,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            maxLines: 3,
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _isAddingNewAddress = false;
                                    });
                                  },
                                  child: const Text('Cancel'),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_addressController.text.isNotEmpty) {
                                      _savedAddresses.add(_addressController.text);
                                      _selectedAddress = _addressController.text;
                                      setState(() {
                                        _isAddingNewAddress = false;
                                      });
                                      Navigator.pop(context);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Theme.of(context).colorScheme.primary,
                                    foregroundColor: Colors.white,
                                  ),
                                  child: const Text('Save'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                  // Saved addresses list
                  if (!_isAddingNewAddress)
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        itemCount: _savedAddresses.length,
                        itemBuilder: (context, index) {
                          final address = _savedAddresses[index];
                          final isSelected = address == _selectedAddress;
                          
                          return InkWell(
                            onTap: () {
                              _selectedAddress = address;
                              Navigator.pop(context);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: isSelected ? Theme.of(context).colorScheme.primary.withOpacity(0.1) : null,
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.grey.shade800,
                                    width: 1,
                                  ),
                                ),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.location_on, color: Colors.grey),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          index == 0 ? 'Home' : 'Work',
                                          style: AppTextStyles.subtitle2,
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          address,
                                          style: AppTextStyles.body2,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (isSelected)
                                    Icon(
                                      Icons.check_circle,
                                      color: Theme.of(context).colorScheme.primary,
                                    ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showPaymentMethodSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Select Payment Method',
                        style: AppTextStyles.headline3,
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        // Add new payment method functionality
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.add, size: 16),
                      label: const Text('Add New'),
                    ),
                  ],
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: _paymentMethods.length,
                itemBuilder: (context, index) {
                  final method = _paymentMethods[index];
                  final bool isSelected = method['id'] == _selectedPaymentMethod;
                  
                  return InkWell(
                    onTap: () {
                      setState(() {
                        _selectedPaymentMethod = method['id'];
                      });
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isSelected ? Theme.of(context).colorScheme.primary.withOpacity(0.1) : null,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              method['icon'],
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  method['title'],
                                  style: AppTextStyles.subtitle1,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  method['subtitle'],
                                  style: AppTextStyles.body2,
                                ),
                              ],
                            ),
                          ),
                          if (isSelected)
                            Icon(
                              Icons.check_circle,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  IconData _getStepIcon() {
    switch (_currentStep) {
      case 0:
        return Icons.cleaning_services;
      case 1:
        return Icons.person;
      case 2:
        return Icons.calendar_today;
      case 3:
        return Icons.receipt_long;
      default:
        return Icons.circle;
    }
  }
} 